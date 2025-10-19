import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/bloc/cart-bloc.dart';
import 'package:app/src/bloc/order-bloc.dart';
import 'package:app/src/bloc/wallet-bloc.dart';
import 'package:app/src/common/awesome-loader.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/coupon.dart';
import 'package:app/src/data_layer/models/order-factory.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/coupon-repository.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/data_layer/repositories/delivery-repository.dart';
import 'package:app/src/data_layer/repositories/order-repository.dart';
import 'package:app/src/theme/animation/scale-route.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/screens/order_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../localizations.dart';

class ContinueButtonWidget extends StatefulWidget {
  final Product product;
  final String type;

  ContinueButtonWidget({Key key, this.type, this.product}) : super(key: key);

  @override
  _ContinueButtonWidgetState createState() => _ContinueButtonWidgetState();
}

class _ContinueButtonWidgetState extends State<ContinueButtonWidget> {

  AwesomeLoaderController loaderController = AwesomeLoaderController();

  void clearAndNavigateToSuccessPage(String cashBack) {
    cartBloc.clearCart();
    currentCoupon.value = Coupon();
    Navigator.pushReplacement(
        context, ScaleRoute(page: OrderSuccessWidget(cashBack: cashBack)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xFFfbab66),
            ),
            BoxShadow(
              color: Color(0xFFf7418c),
            ),
          ],
          gradient: new LinearGradient(
              colors: [primaryColor, primaryColor],
              begin: const FractionalOffset(0.4, 0.4),
              end: const FractionalOffset(1.4, 1.4),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: primaryColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 25,
                height: 25,
                child: AwesomeLoader(
                  outerColor: Colors.white,
                  innerColor: Colors.white,
                  strokeWidth: 3.0,
                  controller: loaderController,
                ),
              ),
              Spacer(),
              Text(AppLocalizations.of(context).submit_order,
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
              Spacer(),
              Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
            ]),
            onPressed: () async {
              this.makeOrder(context);
            }));
  }

  void makeOrder(BuildContext context) {
    OverlayEntry loader = Helper.overlayLoader(context);

    if (cartBloc.productsMap.isEmpty) {
      Helper.showSnackErrorMessage(context,
          AppLocalizations.of(context).dont_have_any_item_in_your_cart);
    } else if (currentAddress.value == null ||
        currentAddress.value.address == null) {
      Helper.showSnackErrorMessage(
          context, AppLocalizations.of(context).add_new_delivery_address);
    } else if (selectedTime.value == null || selectedTime.value.from == null) {
      Helper.showSnackErrorMessage(
          context, AppLocalizations.of(context).select_delivery_time);
    } else if (selectedPayment.value == null ||
        selectedPayment.value == 'Select your payment method') {
      Helper.showSnackErrorMessage(context,
          AppLocalizations.of(context).select_your_preferred_payment_mode);
    } else if (currentCustomer.value == null ||
        currentCustomer.value.id == null) {
      Navigator.of(context).pushReplacementNamed('/pages', arguments: 3);
    } else if (double.parse(appConfigBloc.appConfig.minAllowedAmount) >
        double.parse(cartBloc.getProductsCartAmount())) {
      Helper.showSnackErrorMessage(
          context,
          AppLocalizations.of(context).order_is_less_than +
              appConfigBloc.appConfig.minAllowedAmount +
              ' ' +
              AppLocalizations.of(context).currency);
    } else if (currentCoupon.value.minimumAmount != null &&
        double.parse(currentCoupon.value.minimumAmount) >
            double.parse(cartBloc.getProductsCartAmount())) {
      Helper.showSnackErrorMessage(
          context,
          AppLocalizations.of(context)
                  .discount_deleted_becasue_amount_is_less_than +
              currentCoupon.value.minimumAmount +
              AppLocalizations.of(context).currency);
      currentCoupon.value = Coupon();
    } else {
      var totalAmount = double.parse(cartBloc.getTotalAmount(
          appConfigBloc.appConfig.vat,
          appConfigBloc.appConfig.deliveryFee,
          currentCoupon.value));

      if (selectedPayment.value == "wallet") {
        if (double.parse(walletBloc.walletBalance) < totalAmount) {
          Helper.showSnackErrorMessage(
              context, AppLocalizations.of(context).no_enough_credit_on_wallet);
          return;
        } else {
          debitWallet(currentCustomer.value.id, totalAmount);
        }
      }

      var order = OrderFactory.create();
      Overlay.of(context).insert(loader);
      orderBloc.submitOrder(order).then((value) async {
        if (value != null) {
          if (customerNote.value != null && customerNote.value != "null") {
            await orderBloc.submitOrderNote(
                value, customerNote.value.toString());
          }
          if (selectedPayment.value == "tap_payment") {
            // startSDK(value, false);
          } else {
            clearAndNavigateToSuccessPage("0");
          }
        } else {
          Helper.showSnackErrorMessage(
              context, AppLocalizations.of(context).problem_occurred);
        }
      }).catchError((e) {
        loader.remove();
        print(e.toString());
        Helper.showSnackErrorMessage(
            context, AppLocalizations.of(context).problem_occurred);
      }).whenComplete(() async {
        await orderBloc.fetchCustomerOrders(currentCustomer.value.id);
        Helper.hideLoader(loader);
      });
    }
  }

  void debitWallet(int id, double amount) {
    walletBloc
        .debit(currentCustomer.value.id, amount)
        .then((value) => walletBloc.fetchWalletBalance(id))
        .catchError((e) {
      Helper.showSnackErrorMessage(
          context, AppLocalizations.of(context).problem_occurred);
      return;
    });
  }

  void creditWallet(int id, double amount) {
    walletBloc
        .credit(currentCustomer.value.id, amount)
        .then((value) => walletBloc.fetchWalletBalance(id))
        .catchError((e) {
      Helper.showSnackErrorMessage(
          context, AppLocalizations.of(context).problem_occurred);
      return;
    });
  }
}
