import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/bloc/cart-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/repositories/coupon-repository.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/data_layer/repositories/delivery-repository.dart';
import 'package:app/src/data_layer/repositories/order-repository.dart';
import 'billing_data.dart';
import 'coupon-line.dart';
import 'line-item.dart';
import 'line-shipping.dart';
import 'order-meta_data.dart';
import 'order.dart';

class OrderFactory {
  static Order create() {
    List<LineItem> lineItems = [];
    for (String productIdWithVariation in cartBloc.productsMap.keys) {
      var productId = productIdWithVariation.split("-").first;
      var variationId = productIdWithVariation.split("-").last;

      lineItems.add(new LineItem(
          int.parse(productId),
          cartBloc.productsMap[productIdWithVariation].length,
          int.parse(variationId)));
    }
    List<OrderMetaData> metaData = [];
    Map json = new Map();
    json['time_from'] = selectedTime.value.from;
    json['time_to'] = selectedTime.value.to;
    metaData.add(
        new OrderMetaData('_delivery_date', selectedDeliveryTime.value.date));
    metaData.add(new OrderMetaData('_delivery_time_frame', json));
    metaData.add(new OrderMetaData(
        'billing_lat', currentAddress.value.latitude.toString()));
    metaData.add(new OrderMetaData(
        'billing_long', currentAddress.value.longitude.toString()));

    var phone = currentCustomer.value.phone;
    phone = Helper.toPhone(phone);
    Billing billing = new Billing(
        currentCustomer.value.firstName, currentCustomer.value.lastName, phone);

    String paymentMethod;
    bool setPaid = false;
    if (selectedPayment.value == 'tap_payment') {
      paymentMethod = 'tap';
    } else if (selectedPayment.value == 'cash_on_delivery') {
      paymentMethod = 'cod';
    } else if (selectedPayment.value == 'bacs') {
      paymentMethod = 'bacs';
    } else if (selectedPayment.value == 'wallet') {
      paymentMethod = 'wallet';
      setPaid = true;
    }
    List<CouponLine> couponLines = [];
    List<ShippingLine> shippingLines = [];
    shippingLines.add(new ShippingLine(
        'flat_rate', 'Delivery', appConfigBloc.appConfig.deliveryFee));
    if (currentCoupon.value != null && currentCoupon.value.code != null) {
      couponLines.add(new CouponLine(currentCoupon.value.code));
      if (currentCoupon.value.enableFreeShipping) {
        shippingLines.clear();
        shippingLines.add(new ShippingLine('flat_rate', 'Delivery', "0"));
      }
    }
    return new Order(
        paymentMethod,
        setPaid,
        currentCustomer.value.id,
        lineItems,
        metaData,
        customerNote.value,
        couponLines,
        shippingLines,
        billing);
  }
}
