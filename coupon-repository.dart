import 'dart:convert';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/coupon.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

ValueNotifier<Coupon> currentCoupon = new ValueNotifier(Coupon());

class CouponRepository {
  final _contextRoot = 'wc-api/v3';

  Map<String, String> get _keys =>
      {
        'consumer_key': Helper.API_USER_NAME,
        'consumer_secret': Helper.API_PASSWORD
      };


  Future<Coupon> getCoupon(String coupon) async {
    final path = 'coupons/code/';
    final uri = Uri.https(Helper.BASE_URL,
        '$_contextRoot/$path' + coupon, _keys);

    final response = await http.get(uri);;

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body)['coupon'];
      return Coupon.fromJson(jsonMap);
    }
    throw Exception('invalid_coupon');
  }
}
