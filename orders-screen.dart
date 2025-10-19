import 'package:app/src/bloc/order-bloc.dart';
import 'package:app/src/data_layer/models/order.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/theme/animation/scale-route.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/screens/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../../localizations.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    orderBloc.fetchCustomerOrders(currentCustomer.value.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: StreamBuilder<Object>(
            stream: orderBloc.orders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData &&
                    (snapshot.data as List<Order>).length > 0) {
                  return TrackingButtonWidget();
                }
              }
              return SizedBox(height: 10);
            }),
        appBar: AppBar(
            backgroundColor: bgColor,
            title: Image.asset('assets/img/logo.png',
                fit: BoxFit.cover, height: 80),
            centerTitle: true,
            elevation: 0,
            leadingWidth: 120,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).my_orders,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ))),
        body: StreamBuilder<Object>(
            stream: orderBloc.orders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData &&
                    (snapshot.data as List<Order>).length > 0) {
                  final orders = snapshot.data as List<Order>;
                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              orders[index].isExpanded =
                                  !orders[index].isExpanded;
                            });
                          },
                          children: orders.map((Order order) {
                            return ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                      AppLocalizations.of(context)
                                              .order_number +
                                          ' ' +
                                          order.id.toString() +
                                          '#',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 20, left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              order.status ,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: order.status ==
                                                          Order.STATUS_COMPLETED
                                                      ? Colors.green[600]
                                                      : Colors.red)),
                                          Text(
                                            '${DateFormat('HH:mm | yyyy-MM-dd', 'en').format(DateTime.parse(order.dateModified))}',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                              isExpanded: order.isExpanded,
                              body: Column(
                                children: this.getOrderLineItems(order)
                                  ..addAll([
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 20, left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context).tax,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(order.totalTax,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 20, left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)
                                                  .delivery_fee,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(order.shippingTotal,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 20, left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)
                                                  .total,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(order.total,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ))
                                        ],
                                      ),
                                    )
                                  ]),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                    child:
                        Text(AppLocalizations.of(context).dont_have_any_order,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            )));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                  heightFactor: 6,
                );
              }
            }));
  }

  List<Widget> getOrderLineItems(Order order) {
    List<Widget> widgets = <Widget>[];

    widgets.add(Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text("Order Summery",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800])),
        ],
      ),
    ));

    for (var lineItem in order.lineItems) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(lineItem.name + " " + lineItem.quantity.toString() + "x",
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800])),
            Text(lineItem.total,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800]))
          ],
        ),
      ));
    }

    return widgets;
  }
}

class TrackingButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.blue.shade400,
                  offset: Offset(1, -2),
                  blurRadius: 5),
              BoxShadow(
                  color: Colors.blue.shade400,
                  offset: Offset(-1, 2),
                  blurRadius: 5)
            ]),
        child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: primaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                AppLocalizations.of(context).tracking_order,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: "WorkSansBold"),
              ),
            ),
            onPressed: () async {
             Navigator.push(context, ScaleRoute(page: TrackingWidget()));
            }));
  }
}
