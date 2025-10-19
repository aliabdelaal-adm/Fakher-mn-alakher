import 'package:app/src/bloc/order-bloc.dart';
import 'package:app/src/data_layer/models/order.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../localizations.dart';

class TrackingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          toolbarHeight: 120,
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
        body: StreamBuilder<Object>(
            stream: orderBloc.orders,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  (snapshot.data as List<Order>).length > 0) {
                final orders = snapshot.data as List<Order>;

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Offstage(
                          offstage: false,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Theme(
                                  data: ThemeData(
                                    primaryColor: primaryColor,
                                  ),
                                  child: Stepper(
                                    physics: ClampingScrollPhysics(),
                                    controlsBuilder: (BuildContext context,
                                        {VoidCallback onStepContinue,
                                        VoidCallback onStepCancel}) {
                                      return SizedBox(height: 0);
                                    },
                                    steps:
                                        getTrackingSteps(context, orders.first),
                                    currentStep: 0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 30),
                                child: ButtonTheme(
                                  height: 50,
                                  child: FlatButton(
                                    onPressed: () async {
                                      orderBloc.fetchCustomerOrders(
                                          currentCustomer.value.id);
                                    },
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context).update,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
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
                              ),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                );
              }
              return Container();
            }));
  }
}

List<Step> getTrackingSteps(BuildContext context, Order order) {
  DateTime createdAt = DateTime.parse(order.dateCreated);
  DateTime lastModifiedAt = DateTime.parse(order.dateModified);
  DateTime dateCompleted;
  if (order.dateCompleted != null) {
    dateCompleted = DateTime.parse(order.dateCompleted);
  }

  List<Step> _orderStatusSteps = [];
  _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        AppLocalizations.of(context).order_received,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Text(
        '${DateFormat('HH:mm | yyyy-MM-dd', 'en').format(createdAt)}',
        style: Theme.of(context).textTheme.caption,
        overflow: TextOverflow.ellipsis,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
//              Text(
//                'hintddd',
//              ),
            ],
          )),
      isActive: true));

  _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        AppLocalizations.of(context).preparing,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Text(
        '${DateFormat('HH:mm | yyyy-MM-dd', 'en').format(lastModifiedAt)}',
        style: Theme.of(context).textTheme.caption,
        overflow: TextOverflow.ellipsis,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // Text(
              //   'hint',
              // ),
            ],
          )),
      isActive: (order.status == Order.STATUS_PROCESSING ||
          order.status == Order.STATUS_COMPLETED ||
          order.status == Order.STATUS_PENDING ||
          order.status == Order.STATUS_ON_THE_WAY ||
          order.status == Order.STATUS_DELIVERED)));

  _orderStatusSteps.add(Step(
    state: StepState.complete,
    title: Text(
      AppLocalizations.of(context).ready,
      style: Theme.of(context).textTheme.subtitle1,
    ),
    subtitle: Text(
      dateCompleted != null
          ? '${DateFormat('HH:mm | yyyy-MM-dd', 'en').format(dateCompleted)}'
          : '',
      style: Theme.of(context).textTheme.caption,
      overflow: TextOverflow.ellipsis,
    ),
    content: SizedBox(
        width: double.infinity,
        child:
        Text(
          '',
        )
    ),
    isActive: (order.status == Order.STATUS_COMPLETED ||
        order.status == Order.STATUS_ON_THE_WAY||
        order.status == Order.STATUS_DELIVERED),
  ));

  _orderStatusSteps.add(Step(
    state: StepState.complete,
    title: Text(
      AppLocalizations.of(context).on_the_way,
      style: Theme.of(context).textTheme.subtitle1,
    ),
    subtitle: Text(
      order.status == Order.STATUS_ON_THE_WAY
          ? '${DateFormat('HH:mm | yyyy-MM-dd', 'en').format(lastModifiedAt)}'
          : '',
      style: Theme.of(context).textTheme.caption,
      overflow: TextOverflow.ellipsis,
    ),
    content: SizedBox(
        width: double.infinity,
        child: Text(
          '',
        )),
    isActive: (order.status == Order.STATUS_ON_THE_WAY || order.status == Order.STATUS_DELIVERED),
  ));

  _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        AppLocalizations.of(context).delivered,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Text(
        order.status == Order.STATUS_DELIVERED
            ? '${DateFormat('HH:mm | yyyy-MM-dd', 'en').format(lastModifiedAt)}'
            : '',
        style: Theme.of(context).textTheme.caption,
        overflow: TextOverflow.ellipsis,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
          )),
      isActive: order.status == Order.STATUS_DELIVERED));

  return _orderStatusSteps;
}
