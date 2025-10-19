import 'dart:convert';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Customer> currentCustomer = new ValueNotifier(Customer());

class CustomerRepository {
  final _getByEmailApi = 'wc-api/v3/customers/email';
  final _authApi = 'wp-json/jwt-auth/v1/token';
  final _contextRoot = 'wp-json/wc/v3';


  Map<String, String> get _keys =>
      {
        'consumer_key': Helper.API_USER_NAME,
        'consumer_secret': Helper.API_PASSWORD
      };


  Future<Customer> login(Customer customer) async {
    String phone = Helper.removePlus(customer.phone);
    var uri =
        Uri.https(Helper.BASE_URL, '$_authApi');
    var response = await http.post(uri,
        body: {'username': phone, 'password': customer.password});
    if (response.statusCode == 200) {
      final email = 'm' + phone + "@astore.com";
      uri = Uri.https(Helper.BASE_URL,
          '$_getByEmailApi/$email',_keys);
      response = await http.get(uri);
      if (response.statusCode == 200) {
        return Customer.fromJson(json.decode(response.body)['customer']);
      } else {
        throw Exception('Failed to get data');
      }
    }
    throw Exception('Phone number or password is invalid');
  }

  Future<Customer> signUp(Customer customer) async {
    final path = 'customers';
    final uri = Uri.https(
        Helper.BASE_URL, '$_contextRoot/$path',_keys);
    String phone = Helper.removePlus(customer.phone);
    var response = await http.post(uri, body: {
      'first_name': customer.firstName,
      'email': 'm' + phone + "@astore.com",
      'username': phone,
      'password': customer.password,
      "role": "customer"
    });

    if (response.statusCode == 201) {
      return Customer.fromJson(json.decode(response.body));
    } else {
      var code = json.decode(response.body)['code'];
      if (code == 'registration-error-email-exists') {
        throw Exception('registration-error-email-exists');
      }
      throw Exception('Failed to register customer');
    }
  }

  Future<void> logout() async {
    currentCustomer.value = new Customer();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }

  void saveCustomer(customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentCustomer.value = customer;
    currentCustomer.value.authenticated = true;
    prefs.setString('current_user', json.encode(customer));
  }

  Future<Customer> getSavedCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   // prefs.clear();
    if (currentCustomer.value.authenticated == null &&
        prefs.containsKey('current_user')) {
      print("customer" + prefs.get('current_user'));
      currentCustomer.value =
          Customer.fromJson(json.decode(await prefs.get('current_user')));
      currentCustomer.value.authenticated = true;
    } else {
      currentCustomer.value.authenticated = false;
    }
    return currentCustomer.value;
  }

}
