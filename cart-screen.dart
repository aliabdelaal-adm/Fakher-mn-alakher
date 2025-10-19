import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/bloc/cart-bloc.dart';
import 'package:app/src/bloc/coupon-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/app-config.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/coupon-repository.dart';
import 'package:app/src/data_layer/repositories/order-repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/widgets/continue-button-widget.dart';
import 'package:app/src/ui/widgets/delivery-address-widget.dart';
import 'package:app/src/ui/widgets/delivery-time-widget.dart';
import 'package:app/src/ui/widgets/payment-type-widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../../localizations.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title:
              Image.asset('assets/img/logo.png', fit: BoxFit.cover, height: 80),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: greyColor,
              size: 21,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          brightness: Brightness.light,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,20,50),
          child: ContinueButtonWidget(),
        ),
        body: StreamBuilder<Object>(
            stream: cartBloc.cartStream,
            initialData: new Map(),
            builder: (context, snapshot) {
              return (snapshot.data as Map).entries.length > 0
                  ? SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildCardItems(
                              snapshot.data as Map<String, List<Product>>)
                            ..addAll([
                              SizedBox(
                                height: 10,
                              ),
                              DeliveryAddressWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              DeliveryTimeWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              PaymentTypeWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              PromoCodeWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              CustomerNoteWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              TotalCalculationWidget(),

                              // ContinueButtonWidget()
                            ]),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(AppLocalizations.of(context)
                          .dont_have_any_item_in_your_cart));
            }));
  }
}

List<Widget> _buildCardItems(Map<String, List<Product>> map) {
  List<Widget> widgets = <Widget>[];
  map.forEach((key, value) {
    CartItem cartItem = new CartItem(
        product: value.first,
        onAdd: () {
          cartBloc.addToCart(value.first);
        },
        onRemove: () {
          cartBloc.removeFromCart(value.first);
        });
    widgets.add(cartItem);
    widgets.add(SizedBox(height: 5));
  });

  return widgets;
}

class TotalCalculationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: StreamBuilder<Object>(
          stream: appConfigBloc.appConfigStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final appConfig = snapshot.data as AppConfig;
              return Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: ValueListenableBuilder(
                      valueListenable: currentCoupon,
                      builder: (context, value, child) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 25, right: 30, top: 10, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).total,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    cartBloc.getProductsCartAmount() +
                                        ' ' +
                                        AppLocalizations.of(context).currency,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).tax,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    cartBloc.getTaxAmount(appConfig.vat,
                                            currentCoupon.value) +
                                        ' ' +
                                        AppLocalizations.of(context).currency,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).discount,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    (currentCoupon.value.amount != null
                                        ? (currentCoupon.value.type ==
                                                'fixed_cart'
                                            ? currentCoupon.value.amount +
                                                ' ' +
                                                AppLocalizations.of(context)
                                                    .currency
                                            : (double.parse(currentCoupon
                                                        .value.amount)
                                                    .toInt()
                                                    .toString()) +
                                                '%')
                                        : '0 '),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).delivery_fee,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    currentCoupon.value.enableFreeShipping !=
                                                null &&
                                            currentCoupon
                                                .value.enableFreeShipping
                                        ? "0 " +
                                            AppLocalizations.of(context)
                                                .currency
                                        : appConfig.deliveryFee +
                                            ' ' +
                                            AppLocalizations.of(context)
                                                .currency,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).total_amount,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    cartBloc.getTotalAmount(
                                            appConfig.vat,
                                            appConfig.deliveryFee,
                                            currentCoupon.value) +
                                        ' ' +
                                        AppLocalizations.of(context).currency,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }));
            }
            return Text("Undefined");
          }),
    );
  }
}

class PromoCodeWidget extends StatelessWidget {
  final _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OverlayEntry loader = Helper.overlayLoader(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFFfae3e2).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ]),
        child: TextFormField(
          controller: _couponController,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (term) {
            final coupon = _couponController.text.trim();
            if (coupon.isNotEmpty) {
              Overlay.of(context).insert(loader);
              couponBloc.getCoupon(coupon).then((value) {
                if (value != null && value.code != null) {
                  DateTime d = DateTime.parse(value.expiryDate);
                  if (d.isBefore(new DateTime.now())) {
                    Helper.showSnackErrorMessage(
                        context, AppLocalizations.of(context).expired_coupon);
                  } else if (double.parse(cartBloc.getProductsCartAmount()) <
                      double.parse(value.minimumAmount)) {
                    Helper.showSnackErrorMessage(
                        context,
                        AppLocalizations.of(context)
                                .order_amount_should_more_than +
                            value.minimumAmount +
                            ' ' +
                            AppLocalizations.of(context).currency);
                  } else {
                    Helper.showSnackSuccessMessage(
                        context, AppLocalizations.of(context).verified_coupon);
                    currentCoupon.value = value;
                  }
                } else {
                  Helper.showSnackErrorMessage(
                      context, AppLocalizations.of(context).invalid_coupon);
                }
              }).catchError((e) {
                loader.remove();
                Helper.showSnackErrorMessage(
                    context, AppLocalizations.of(context).invalid_coupon);
              }).whenComplete(() {
                Helper.hideLoader(loader);
              });
            }
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                  borderRadius: BorderRadius.circular(7)),
              fillColor: Colors.white,
              hintText: currentCoupon.value.code != null
                  ? currentCoupon.value.code
                  : AppLocalizations.of(context).add_coupon,
              filled: true,
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.local_offer,
                    color: Color(0xFFfd2c2c),
                  ),
                  onPressed: () {})),
        ),
      ),
    );
  }
}

class CustomerNoteWidget extends StatelessWidget {
  final _noteController = TextEditingController(
      text: customerNote.value == "null" ? null : customerNote.value);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFFfae3e2).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ]),
        child: TextFormField(
          minLines: 3,
          maxLines: 4,
          controller: _noteController,
          textInputAction: TextInputAction.done,
          onChanged: (d) {
            final note = _noteController.text.trim();
            if (note.isNotEmpty) {
              customerNote.value = note;
            }
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                  borderRadius: BorderRadius.circular(7)),
              fillColor: Colors.white,
              hintText: AppLocalizations.of(context).note,
              filled: true,
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.local_offer,
                    color: Color(0xFFfd2c2c),
                  ),
                  onPressed: () {})),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  CartItem({Key key, this.product, this.onAdd, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: CachedNetworkImage(
                        width: 80,
                        height: 60,
                        placeholder: (context, url) => Image.asset(
                          product.img,
                          fit: BoxFit.contain,
                        ),
                        imageUrl: product.img,
                        fit: BoxFit.cover,
                        fadeInCurve: Curves.linearToEaseOut,
                        fadeOutCurve: Curves.easeInOutBack,
                      )),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                product.name,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: Text(
                                product.variationDesc == null
                                    ? ""
                                    : product.variationDesc,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                onRemove();
                              },
                              icon: Icon(Icons.remove),
                              color: Colors.black,
                              iconSize: 18,
                            ),
                            StreamBuilder<Object>(
                                stream: cartBloc.cartStream,
                                builder: (context, snapshot) {
                                  return InkWell(
                                    onTap: () => {},
                                    child: Container(
                                      width: 70.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFfd2c2c),
                                        border: Border.all(
                                            color: Colors.white, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (snapshot.hasData &&
                                                  (snapshot.data as Map<String,
                                                          List<Product>>)
                                                      .containsKey(
                                                          Helper.getMapKey(
                                                              product)))
                                              ? (snapshot.data as Map<String,
                                                          List<Product>>)[
                                                      Helper.getMapKey(product)]
                                                  .length
                                                  .toString()
                                              : "0",
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            IconButton(
                              onPressed: () {
                                onAdd();
                              },
                              icon: Icon(Icons.add),
                              color: Colors.black,
                              iconSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.price.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
