import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/app-config.dart';
import 'package:app/src/data_layer/models/deilvery-time.dart';
import 'package:app/src/data_layer/models/times.dart';
import 'package:app/src/data_layer/repositories/delivery-repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../localizations.dart';

class DeliveryTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDeliveryTimeSheet(context);
      },
      child: Container(
        width: double.infinity,
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context).delivery_time,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                      valueListenable: selectedTime,
                      builder: (context, value, child) {
                        if((value as Time).from != null) {
                          var time = selectedDeliveryTime.value.dayAr +
                              " ( " +
                              selectedDeliveryTime.value.date +
                              " ) / (" +
                              (value as Time).from +
                              " - " +
                              (value as Time).to +
                              " )";
                          return selectedItem(time);
                        }else {
                          return Text(
                            AppLocalizations.of(context)
                                .select_delivery_time,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeliveryTimeSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: DeliveryDaysAndTimesWidget(),
          );
        });
  }

  Widget selectedItem(String selectedTimeType) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
          // color: Colors.green[50],
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        children: [
          Text(
            selectedTimeType,
            style: TextStyle(
                color: Colors.black, fontSize: 10, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
          Spacer(),
          Icon(
            Icons.check_circle_rounded ,
            color: shadowColor,
          ),
        ],
      ),
    );
  }
}

class DeliveryDaysAndTimesWidget extends StatefulWidget {
  const DeliveryDaysAndTimesWidget({Key key}) : super(key: key);

  @override
  _DeliveryDaysAndTimesWidgetState createState() =>
      _DeliveryDaysAndTimesWidgetState();
}

class _DeliveryDaysAndTimesWidgetState
    extends State<DeliveryDaysAndTimesWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: appConfigBloc.appConfigStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = (snapshot.data as AppConfig).timesArray;
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildDaysIcons(results),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: new Wrap(
                        children: _buildTimesTiles(
                            selectedDeliveryTime.value.times, context,selectedDeliveryTime.value.date)),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  List<Widget> _buildDaysIcons(List<DeliveryTime> deliveryTimes) {
    List<Widget> widgets = List<Widget>();

    if (selectedDeliveryTime.value.day == 'null') {
      selectedDeliveryTime.value = deliveryTimes.first;
    }
    for (var delivery in deliveryTimes) {
      widgets.add(new TopDaysIcons(parent: this, delivery: delivery));
      print(delivery.dayAr);
      for (var time in delivery.times) {
        print(time.from + " - " + time.to);
      }
    }

    return widgets;
  }

  List<Widget> _buildTimesTiles(List<Time> times, context, String date) {
    List<Widget> widgets = List<Widget>();

    if (times != null) {
      for (var time in times) {
        widgets.add(
          new ListTile(
              title: new Text(
                time.from + " - " + time.to,
                style: TextStyle(
                  decoration: (time.enabled && Helper.isTimeAvailable(time,date) ) ?  TextDecoration.none : TextDecoration.lineThrough,
                  decorationThickness: 2.85,
                ),
              ),
              onTap: () {
                if(time.enabled && Helper.isTimeAvailable(time,date)) {
                  Navigator.pop(context);
                  selectedTime.value = time;
                }
              }),
        );
      }
    }

    return widgets;
  }
}

class TopDaysIcons extends StatelessWidget {
  _DeliveryDaysAndTimesWidgetState parent;
  DeliveryTime delivery;

  TopDaysIcons({Key key, @required this.parent, @required this.delivery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow,
      highlightColor: Colors.blue,
      focusColor: Colors.red,
      onTap: () {
        this.parent.setState(() {
          selectedDeliveryTime.value = this.delivery;
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: shadowColor,
                blurRadius: 25.0,
                offset: Offset(0.0, 0.75),
              ),
            ]),
            child: Card(
                color: selectedDeliveryTime.value.date == this.delivery.date
                    ? Colors.blue
                    : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                child: Container(
                  width: 60,
                  height: 40,
                  child: Column(
                    children: [
                      Center(
                        child: Text(this.delivery.dayAr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6e6e71),
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(this.delivery.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6e6e71),
                                fontSize: 8,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
