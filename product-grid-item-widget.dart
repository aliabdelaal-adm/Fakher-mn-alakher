import 'package:app/src/bloc/cart-bloc.dart';
import 'package:app/src/bloc/variation-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/ui/widgets/product-widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import '../../../localizations.dart';

class ProductGridItemWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  ProductGridItemWidget({Key key, this.product, this.onAdd, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(children: <Widget>[
            GestureDetector(
              onTap: () {
                if (product.stockStatus != Product.OUT_OF_STOCK_STATUS) {
                  navigateToProductWidget(context, this.product);
                }
              },
              child: Container(

                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100]),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      width: 120,
                      height: 90,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/maleh_logo.png',
                        fit: BoxFit.cover,
                      ),
                      imageUrl: product.img,
                      // imageUrl: 'assets/img/maleh_logo.png',
                      fit: BoxFit.contain,
                      fadeInCurve: Curves.linearToEaseOut,
                      fadeOutCurve: Curves.easeInOutBack,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    if (product.dateOnSaleFrom != null)
                      Container(
                          alignment: Alignment.center,
                          // padding:
                          // const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Directionality(
                            textDirection: TextDirection.ltr,   // notice lower case
                            child: CountdownTimer(
                              endTime: DateTime.parse(product.dateOnSaleTo)
                                  .millisecondsSinceEpoch +
                                  1000 * 30,
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time != null) {
                                  return Text(
                                    '${time.days != null ? time.days.toString() + ' Day' : ''} ${time.hours}:${time.min}:${time.sec}',style:TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      backgroundColor: Colors.red ,
                                      color: Colors.white) ,);
                                }
                                return Text("");
                              },
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          )
                      ),
                    if (product.dateOnSaleFrom == null)
                      Container(
                          alignment: Alignment.center,
                          // padding:
                          // const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Text(
                            "",style:TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              backgroundColor: Colors.red ,
                              color: Colors.white) ,)
                      ),
                  ],
                ),
              ),
            ),
            if (getUnitAndQuantity(this.product, context) != null)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(8))),
                  child: Text(
                    getUnitAndQuantity(this.product, context),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            if (product.stockStatus == Product.ON_BACK_ORDER_STATUS)
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                  child: Text(
                    AppLocalizations.of(context).on_back_order,
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
          ]),
          Text(
            '${product.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          if (product.regularPrice != null)
            Text(
                product.regularPrice != product.price
                    ? '${product.regularPrice}' +
                        ' ' +
                        AppLocalizations.of(context).currency
                    : "",
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.85,
                    fontSize: 9)),
          Text('${product.price}' + ' ' + AppLocalizations.of(context).currency,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 12)),
          if (product.stockStatus != Product.OUT_OF_STOCK_STATUS)
            Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[200],
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 45,
                    child: FloatingActionButton(
                      heroTag: "add" + Helper.getMapKey(product),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 14,
                      ),
                      onPressed: () {
                        if (product.variations.length > 0) {
                          navigateToProductWidget(context, this.product);
                        } else {
                          onAdd();
                        }
                      },
                      backgroundColor: Colors.white,
                    ),
                  ),
                  StreamBuilder<Object>(
                      stream: cartBloc.cartStream,
                      builder: (context, snapshot) {
                        return Text((snapshot.hasData &&
                                (snapshot.data as Map<String, List<Product>>)
                                    .containsKey(Helper.getMapKey(product))
                            ? (snapshot.data as Map<String, List<Product>>)[
                                    Helper.getMapKey(product)]
                                .length
                                .toString()
                            : "0"));
                      }),
                  Container(
                    height: 20,
                    width: 45,
                    child: FloatingActionButton(
                      heroTag: "remove" + Helper.getMapKey(product),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                        size: 14,
                      ),
                      onPressed: () {
                        if (product.variations.length > 0) {
                          navigateToProductWidget(context, this.product);
                        } else {
                          onRemove();
                        }
                      },
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          if (product.stockStatus == Product.OUT_OF_STOCK_STATUS)
            Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(AppLocalizations.of(context).out_of_stock)))
        ],
      ),
    );
  }

  void navigateToProductWidget(BuildContext context, Product product) {
    variationFetchBloc.clear();
    variationFetchBloc.fetchVariations(product.id.toString());
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0)), //this right here
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ProductWidget(
            product: product, isVariated: product.variations.length > 0),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}

getUnitAndQuantity(Product product, BuildContext context) {
  var sku = product.sku;
  var qtyAndUnit;
  if (sku != null && sku != '') {
    var arr = sku.split('.');

    if (arr.length == 3) {
      switch (arr[0].toLowerCase()) {
        case 'full_box':
        case 'box':
          qtyAndUnit = AppLocalizations.of(context).box;
          break;
        case 'pack':
          qtyAndUnit = AppLocalizations.of(context).pack;
          break;
        case 'dish':
          qtyAndUnit = AppLocalizations.of(context).dish;
          break;
        case 'kilo':
          qtyAndUnit = AppLocalizations.of(context).kilo;
          break;
        case 'piece':
          qtyAndUnit = AppLocalizations.of(context).piece;
          break;
        case 'gram':
          qtyAndUnit = AppLocalizations.of(context).gram;
          break;
        case 'bag':
          qtyAndUnit = AppLocalizations.of(context).bag;
          break;
        case 'piece2':
          qtyAndUnit = AppLocalizations.of(context).piece2;
          break;
        case 'package':
          qtyAndUnit = AppLocalizations.of(context).package;
          break;
        case 'packet':
          qtyAndUnit = AppLocalizations.of(context).packet;
          break;
        case 'barrel':
          qtyAndUnit = AppLocalizations.of(context).barrel;
          break;
        case 'bottle':
          qtyAndUnit = AppLocalizations.of(context).bottle;
          break;
        case 'bucket':
          qtyAndUnit = AppLocalizations.of(context).bucket;
          break;
        case 'free':
          qtyAndUnit = AppLocalizations.of(context).free;
          break;
        case 'discount':
          qtyAndUnit = AppLocalizations.of(context).discount;
          break;
        case 'discount2':
          qtyAndUnit = AppLocalizations.of(context).discount2;
          break;
        case 'exclusive_offer':
          qtyAndUnit = AppLocalizations.of(context).exclusive_offer;
          break;
        case 'competition':
          qtyAndUnit = AppLocalizations.of(context).competition;
          break;
        case 'free_delivery':
          qtyAndUnit = AppLocalizations.of(context).free_delivery;
          break;
        case 'save_m':
          qtyAndUnit = AppLocalizations.of(context).save_m;
          break;
        case 'order_now':
          qtyAndUnit = AppLocalizations.of(context).order_now;
          break;
        case 'limited_quantity':
          qtyAndUnit = AppLocalizations.of(context).limited_quantity;
          break;
        case 'less_price':
          qtyAndUnit = AppLocalizations.of(context).less_price;
          break;
        case 'sold_out':
          qtyAndUnit = AppLocalizations.of(context).sold_out;
          break;
        case 'new_product':
          qtyAndUnit = AppLocalizations.of(context).new_product;
          break;
        case 'hurry_up_to_order':
          qtyAndUnit = AppLocalizations.of(context).hurry_up_to_order;
          break;
        case 'to_participate':
          qtyAndUnit = AppLocalizations.of(context).to_participate;
          break;
        default:
          qtyAndUnit = AppLocalizations.of(context).piece;
      }
      qtyAndUnit = (arr[1] != "1" ? arr[1] + ' ' : '') + qtyAndUnit;
    }
  }

  return qtyAndUnit;
}
