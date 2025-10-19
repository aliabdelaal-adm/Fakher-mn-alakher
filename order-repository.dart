import 'dart:convert';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

ValueNotifier<String> customerNote = new ValueNotifier("null");

class OrderRepository {
  final _contextRoot = 'wp-json/wc/v3';
  final _noteApi = 'wc-api/v3/orders/order_id/notes';

  Map<String, String> get _keys => {
    'consumer_key': Helper.API_USER_NAME,
    'consumer_secret': Helper.API_PASSWORD
      };

  Map<String, String> get _headers =>
      {'Accept': 'application/json', "Content-Type": "application/json"};

  Future<Order> submitOrder(Order order) async {
    final path = 'orders';
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    Map jsonRequest = new Map();
    jsonRequest['payment_method'] = order.paymentMethod;
    jsonRequest['set_paid'] = order.setPaid;
    jsonRequest['customer_id'] = order.customerId;
    jsonRequest['line_items'] = order.lineItems;
    jsonRequest['meta_data'] = order.metaData;
    jsonRequest['note'] = order.customerNote;
    jsonRequest['coupon_lines'] = order.couponLines;
    jsonRequest['shipping_lines'] = order.shippingLines;
    jsonRequest['billing'] = order.billingData;

    var requestBody = jsonEncode(jsonRequest);
    final response = await http.post(uri, headers: _headers, body: requestBody);

    if (response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return Order.fromJson(jsonMap);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<List<Order>> getCustomerOrders(int customerId) async {
    Map<String, String> _keys = {
      'consumer_key': Helper.API_USER_NAME,
      'consumer_secret': Helper.API_PASSWORD,
      'customer': customerId.toString()
    };
    if (customerId == null) {
      return await new Future<List<Order>>.delayed(
          new Duration(seconds: 1), () => <Order>[]);
    }
    final path = 'orders';
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return (jsonMap as List).map((item) => Order.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get orders');
    }
  }

  Future<Order> updateOrder(Order order, String status) async {
    final path = 'orders/' + order.id.toString();
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    Map jsonRequest = new Map();
    jsonRequest['status'] = status;

    var requestBody = jsonEncode(jsonRequest);
    final response = await http.put(uri, body: requestBody);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return Order.fromJson(jsonMap);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<Order> updateOrderToPaid(Order order) async {
    final path = 'orders/' + order.id.toString();
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    Map jsonRequest = new Map();
    jsonRequest['set_paid'] = true;

    var requestBody = jsonEncode(jsonRequest);
    final response = await http.put(uri, body: requestBody);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return Order.fromJson(jsonMap);
    } else {
      throw Exception('Failed to post data');
    }
  }

  submitOrderNote(Order order, String note) async {
    final path = _noteApi.replaceAll('order_id', order.id.toString());
    final uri =
        Uri.https(Helper.BASE_URL, path, _keys);

    Map jsonRequest = new Map();
    Map jsonRequest2 = new Map();
    jsonRequest2['note'] = note;
    jsonRequest['order_note'] = jsonRequest2;

    var requestBody = jsonEncode(jsonRequest);
    final response = await http.post(uri, body: requestBody);
    if (response.statusCode != 201) {
      throw Exception('Failed to post note');
    }
  }
}
