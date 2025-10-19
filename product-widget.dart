import 'package:app/src/bloc/cart-bloc.dart';
import 'package:app/src/bloc/variation-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/models/variation.dart';
import 'package:app/src/ui/widgets/review-widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../localizations.dart';
import 'food-title-widget.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final bool isVariated;

  ProductWidget({Key key, this.product, this.isVariated = false})
      : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    width: 260,
                    height: 220,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/maleh_logo.png',
                      fit: BoxFit.cover,
                    ),
                    imageUrl: widget.product.img,
                    fit: BoxFit.contain,
                    fadeInCurve: Curves.linearToEaseOut,
                    fadeOutCurve: Curves.easeInOutBack,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  elevation: 1,
                  margin: EdgeInsets.all(5),
                ),
                FoodTitleWidget(
                    productName: widget.product.name,
                    productPrice: widget.product.price.toString()),
                SizedBox(
                  height: 5,
                ),
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
                          heroTag: "addd" + Helper.getMapKey(widget.product),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 14,
                          ),
                          onPressed: () {
                            // print(widget.product.variationDesc);
                            // print(widget.product.variationId);
                            Product product =
                                Helper.cloneObject(widget.product);
                            cartBloc.addToCart(product);
                          },
                          backgroundColor: Colors.white,
                        ),
                      ),
                      StreamBuilder<Object>(
                          stream: cartBloc.cartStream,
                          builder: (context, snapshot) {
                            return Text(
                              (snapshot.hasData &&
                                      (snapshot.data
                                              as Map<String, List<Product>>)
                                          .containsKey(
                                              Helper.getMapKey(widget.product)))
                                  ? (snapshot.data
                                              as Map<String, List<Product>>)[
                                          Helper.getMapKey(widget.product)]
                                      .length
                                      .toString()
                                  : "0",
                            );
                          }),
                      Container(
                        height: 20,
                        width: 45,
                        child: FloatingActionButton(
                          heroTag: "removee" + Helper.getMapKey(widget.product),
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 14,
                          ),
                          onPressed: () {
                            cartBloc.removeFromCart(widget.product);
                          },
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    Helper.skipHtml(widget.product.desc),
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        height: 1.50),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ReviewWidget(product: widget.product),
                if (widget.isVariated)
                  Container(
                    child: Column(
                      children: [_buildVariations()],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }



  _buildVariations() {
    return StreamBuilder<Object>(
        stream: variationFetchBloc.variations,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print((snapshot.data as List<Variation>).length);
            final results = snapshot.data as List<Variation>;
            if (selectedRadio == 0) {
              widget.product.variationId = results.first.id;
            }
            return Column(
              children: List.generate(
                results.length,
                (index) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color(0xFFfae3e2).withOpacity(0.1),
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
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 10, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CachedNetworkImage(
                                          width: 70,
                                          height: 50,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/maleh_logo.png',
                                            fit: BoxFit.fill,
                                            width: 40,
                                            height: 40,
                                          ),
                                          imageUrl: results[index].img,
                                          fit: BoxFit.fill,
                                          fadeInCurve: Curves.linearToEaseOut,
                                          fadeOutCurve: Curves.easeInOutBack,
                                        )),
                                  ),
                                  Radio(
                                    value: results[index].id,
                                    groupValue: selectedRadio == 0
                                        ? results.first.id
                                        : selectedRadio,
                                    activeColor: Colors.green,
                                    onChanged: (val) {
                                      widget.product.variationId = val;
                                      widget.product.variationDesc =
                                          results[index].desc;
                                      widget.product.price =
                                          results[index].price;
                                      setSelectedRadio(val);
                                    },
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          results[index].desc,
                                          style: TextStyle(
                                              fontSize:
                                                  results[index].desc.length >
                                                          18
                                                      ? 12
                                                      : 14,
                                              color: Color(0xFF3a3a3b),
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  child: Text(
                                    results[index].price.toString() +
                                        " " +
                                        AppLocalizations.of(context).currency,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
            heightFactor: 6,
          );
        });
  }
}
