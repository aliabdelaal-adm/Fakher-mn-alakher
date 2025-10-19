import 'dart:convert';
import 'dart:math';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/category.dart';
import 'package:app/src/data_layer/models/customer.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/models/variation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  final _contextRoot = 'wp-json/wc/v3';

  Map<String, String> get _keys => {
    'consumer_key': Helper.API_USER_NAME,
    'consumer_secret': Helper.API_PASSWORD
  };

  Map<String, String> get _headers =>
      {'Accept': 'application/json', "Content-Type": "application/json"};


  Future<List<Category>> fetchCategories() async {
    Map<String, String> _keys = {
      'consumer_key': Helper.API_USER_NAME,
      'consumer_secret': Helper.API_PASSWORD,
      'per_page': '100'
    };

    final path = 'products/categories';
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      List categories = (jsonMap as List)
          .map((item) => Category.fromJson(item))
          .where((element) => element.name != "Uncategorized")
          .toList();
      categories.sort((a, b) => a.menuOrder.compareTo(b.menuOrder));
      return categories;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<List<Product>> fetchProducts({@required String categoryId}) async {
    final path = 'products';

    Map<String, String> _keys = {
      'consumer_key': Helper.API_USER_NAME,
      'consumer_secret': Helper.API_PASSWORD,
      'category': categoryId,
      'per_page': '100'
    };

    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return (jsonMap as List).map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<List<Variation>> fetchVariations({@required String productId}) async {
    final path = 'products/' + productId + '/variations';

    Map<String, String> _keys = {
      'consumer_key': Helper.API_USER_NAME,
      'consumer_secret': Helper.API_PASSWORD,
      'per_page': '100'
    };

    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return (jsonMap as List).map((item) => Variation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<List<Product>> searchProducts({String keyword}) async{
    final path = 'products';

    Map<String, String> _keys = {
      'consumer_key': Helper.API_USER_NAME,
      'consumer_secret': Helper.API_PASSWORD,
      'search' : keyword
    };

    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return (jsonMap as List).map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<Product> submitReview(Product product, Customer customer) async {
    final path = 'products/reviews';
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path', _keys);

    Map jsonRequest = new Map();
    jsonRequest['product_id'] = product.id;
    jsonRequest['rating'] = product.currentRating;
    jsonRequest['review'] =  new Random().nextInt(1000000).toString() + ' Review';
    jsonRequest['reviewer'] = customer.firstName;
    jsonRequest['reviewer_email'] = customer.phone;


    var requestBody = jsonEncode(jsonRequest);
    final response = await http.post(uri, headers: _headers, body: requestBody);
    if (response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return Product.fromJson(jsonMap);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
