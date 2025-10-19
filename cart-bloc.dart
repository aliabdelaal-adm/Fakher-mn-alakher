import 'dart:async';
import 'package:app/src/common/helper.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:app/src/data_layer/models/coupon.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final cartStreamController = BehaviorSubject<Map<String, List<Product>>>();
  final _audioCache = AudioCache();

  Stream<Map<String, List<Product>>> get cartStream =>
      cartStreamController.stream;

  final Map<String, List<Product>> productsMap = new Map();

  void addToCart(Product product) {
    var prodId = Helper.getMapKey(product);
    if (productsMap.containsKey(prodId)) {
      productsMap[prodId].add(product);
    } else {
      List l = new List<Product>();
      l.add(product);
      productsMap[prodId] = l;
    }
    _audioCache.play('point_blank.mp3');
    cartStreamController.sink.add(productsMap);
  }

  void removeFromCart(Product product) {
    var prodId = Helper.getMapKey(product);

    if (productsMap.containsKey(prodId)) {

      if (productsMap[prodId].length >= 0) {
        productsMap[prodId].remove(productsMap[prodId]
            .lastWhere((element) => element.id == product.id));
        _audioCache.play('open_ended.mp3');
      }
      if (productsMap[prodId].length == 0) {
        productsMap.remove(prodId);
      }
      cartStreamController.sink.add(productsMap);
    }
  }

  String getProductsCartAmount() {
    double amount = 0;
    productsMap.forEach((key, value) {
      amount += returnProductsPrice(value);
    });
    return amount.toStringAsFixed(2);
  }

  String getTotalAmount(String tax, String deliveryFee, Coupon coupon) {
    double amount = double.parse(getProductsCartAmount());
    double discount = getDiscount(amount, coupon);
    amount -= discount;
    amount += double.parse(getTaxAmount(tax, coupon));
    if (coupon.enableFreeShipping == null ||
        coupon.enableFreeShipping == false) {
      amount += double.parse(deliveryFee);
    }
    return amount.toStringAsFixed(2);
  }

  String getTaxAmount(String tax, Coupon coupon) {
    double amount = double.parse(getProductsCartAmount());
    double discount = getDiscount(amount, coupon);
    amount -= discount;
    amount = amount * double.parse(tax) / 100;
    return amount.toStringAsFixed(2);
  }

  double returnProductsPrice(List<Product> list) {
    var amount = 0.0;
    for (Product p in list) {
      amount += p.price;
    }
    return amount;
  }

  @override
  void dispose() {
    cartStreamController.close();
  }

  void clearCart() {
    productsMap.clear();
    cartStreamController.sink.add(productsMap);
  }

  double getDiscount(double amount, Coupon coupon) {
    double discount = 0;
    if (coupon.type == 'percent' && coupon.amount != null) {
      discount = (amount * double.parse(coupon.amount) / 100);
    } else if (coupon.type == 'fixed_cart' && coupon.amount != null) {
      discount = double.parse(coupon.amount);
    }

    return discount;
  }
}

final cartBloc = CartBloc();
