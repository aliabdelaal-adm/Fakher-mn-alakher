import 'dart:convert';

import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/wallet-response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

ValueNotifier<String> wallet = new ValueNotifier("null");

class WalletRepository {
  final _contextRoot = 'wp-json/wc/v2';


  Map<String, String> get _keys =>
      {
        'consumer_key': Helper.API_USER_NAME,
        'consumer_secret': Helper.API_PASSWORD
      };


  Future<WalletResponse> issueWalletTransaction(
      int customerId, amount, String type) async {
    final path = 'wallet/' + customerId.toString();
    final uri = Uri.https(
        Helper.BASE_URL, '$_contextRoot/$path',_keys);

    Map jsonRequest = new Map();
    jsonRequest['amount'] = amount;
    jsonRequest['type'] = type;

    var requestBody = jsonEncode(jsonRequest);
    final response = await http.post(uri, body: requestBody);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return WalletResponse.fromJson(jsonMap);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<WalletResponse> credit(int customerId, amount) async {
    return this.issueWalletTransaction(customerId, amount, 'credit');
  }

  Future<WalletResponse> debit(int customerId, amount) async {
    return this.issueWalletTransaction(customerId, amount, 'debit');
  }

  Future<String> getCustomerWalletBalance(customerId) async {
    final path = 'wallet/balance/' + customerId.toString();
    final uri = Uri.https(
        Helper.BASE_URL, '$_contextRoot/$path',_keys);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get balance');
    }
  }
}
