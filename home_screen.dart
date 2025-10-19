import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/bloc/products_fetch_bloc.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/theme/animation/scale-route.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/bloc/cart-bloc.dart';
import 'package:app/src/ui/widgets/carousel-widget.dart';
import 'package:app/src/ui/widgets/product-grid-item-widget.dart';
import 'package:app/src/ui/widgets/search-widget.dart';
import 'package:app/src/ui/widgets/top-categories.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livechatt/livechatt.dart';
import '../../../localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColor,
          title:
              Image.asset('assets/img/logo.png', fit: BoxFit.cover, height: 80),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 120,
          leading: StreamBuilder<Object>(
              stream: cartBloc.cartStream,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    Badge(
                      position: BadgePosition.topRight(top: 0, right: 4),
                      animationDuration: Duration(milliseconds: 300),
                      animationType: BadgeAnimationType.slide,
                      badgeColor: Colors.red,
                      shape: BadgeShape.circle,
                      borderRadius: 10,
                      toAnimate: true,
                      badgeContent: Text(
                          (snapshot.hasData)
                              ? (snapshot.data as Map).entries.length.toString()
                              : "0",
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart');
                        },
                        icon: Icon(Icons.shopping_cart, color: greyColor),
                        iconSize: 21,
                      ),
                    ),
                    Text(
                        cartBloc.getProductsCartAmount() +
                            ' ' +
                            AppLocalizations.of(context).currency,
                        style: TextStyle(color: textColor, fontSize: 12)),
                  ],
                );
              }),
          actions: <Widget>[
            // IconButton(
            //   padding: EdgeInsets.all(0),
            //   iconSize: 21,
            //   icon: Icon(Icons.wallet_giftcard_outlined, color: greyColor),
            //   onPressed: () {
            //     Navigator.push(context, ScaleRoute(page: WalletWidget()));
            //   },
            // )
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Column(
                children: [
                  TopCategories(),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(context, ScaleRoute(page: SearchWidget()))
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // padding: const EdgeInsets.only(top: 30.0,right: 20, left: 20),
                      height: 40,
                      width: 300,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: greyColor,
                            size: 21,
                          ),
                          Text(
                            AppLocalizations.of(context).search,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              isExtended: true,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(AppLocalizations.of(context).shopping_cart,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              backgroundColor: primaryColor,
            ),
            SizedBox(
              width: 40,
            ),
            if (appConfigBloc.appConfig != null && appConfigBloc.appConfig.liveChatEnabled &&
                null != appConfigBloc.appConfig.liveChatId)
              FloatingActionButton.extended(
                heroTag: "livechattag",
                onPressed: () {
                  Livechat.beginChat(
                      appConfigBloc.appConfig.liveChatId.toString(),
                      appConfigBloc.appConfig.liveChatGroup.toString(),
                      currentCustomer.value.firstName != null
                          ? currentCustomer.value.firstName
                          : 'User',
                      currentCustomer.value.phone != null
                          ? currentCustomer.value.phone
                          : "maleh@example.com");
                },
                isExtended: true,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                label: Text(AppLocalizations.of(context).help_supports,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                backgroundColor: Colors.red,
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            if (appConfigBloc.appConfig != null &&
                appConfigBloc.appConfig.carouselEnabled)
              CarouselWidget(),
            _buildGrid(),
          ]),
        ),
      ),
//        bottomNavigationBar: BottomNavBarWidget()
    );
  }

  Widget _buildGrid() {
    return StreamBuilder<Object>(
        stream: productsFetchBloc.products,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data as List;
            return new Container(
              child: GridView.count(
                childAspectRatio: 0.6,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 0.001,
                padding: EdgeInsets.symmetric(horizontal: 5),
                crossAxisCount: 3,
                children: List.generate(results.length, (index) {
                  return Container(
                    child: getStructuredGridCell(results[index]),
                  );
                }),
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

  ProductGridItemWidget getStructuredGridCell(Product product) {
    return new ProductGridItemWidget(
        product: product,
        onAdd: () {
          cartBloc.addToCart(product);
        },
        onRemove: () {
          print(product.name);
          cartBloc.removeFromCart(product);
        });
  }
}
