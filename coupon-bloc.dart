import 'dart:async';
import 'package:app/src/data_layer/models/coupon.dart';
import 'package:app/src/data_layer/repositories/coupon-repository.dart';

class CouponBloc {
  CouponRepository _couponRepository = CouponRepository();

  Future<Coupon> getCoupon(couponCode) => _couponRepository.getCoupon(couponCode);
}

final couponBloc = CouponBloc();
