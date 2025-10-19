import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:app/src/data_layer/models/date.dart';
import 'package:app/src/data_layer/models/deilvery-time.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/models/times.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import '../../localizations.dart';
import 'circular-loading-widget.dart';

class Helper {
  static const String BASE_URL = 'maleh.vip';
  static const String API_USER_NAME =
      'ck_4fdcdf42d05a27d8672d65ac9ad7838fda3ae27b';
  static const String API_PASSWORD =
      'cs_5740871d0578822c68c1b84d4ad0b490d534cb1d';

  BuildContext context;
  DateTime currentBackPressTime;

  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: primaryColor.withOpacity(0.85),
          child: CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: AppLocalizations.of(context).tapAgainToLeave);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  static Date dateFormatter(DateTime date) {
    dynamic dayDataEn =
        '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';
    dynamic dayDataAr =
        '{ "1" : "الأثنين", "2" : "الثلاثاء", "3" : "الأربعاء", "4" : "الخميس", "5" : "الجمعة", "6" : "السبت", "7" : "الأحد" }';

    String dayEn = json.decode(dayDataEn)['${date.weekday}'].toString();
    String dayAr = json.decode(dayDataAr)['${date.weekday}'].toString();
    String dayAndMonthAndYear = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();
    return new Date(dayEn, dayAr, dayAndMonthAndYear);
  }

  static List<DeliveryTime> getUpComingSevenDays(List<DeliveryTime> list) {
    List<Date> daysList = <Date>[];
    List<DeliveryTime> sortedList = <DeliveryTime>[];
    for (int i = 0; i <= 6; i++) {
      daysList.add(dateFormatter(DateTime.now().add(new Duration(days: i))));
    }

    for (Date date in daysList) {
      for (DeliveryTime delivery in list) {
        if (date.dayEn == delivery.day) {
          delivery.date = date.date;
          delivery.dayAr = date.dayAr;
          sortedList.add(delivery);
        }
      }
    }
    return sortedList;
  }

  static String removePlus(String phone) {
    return phone.replaceAll('+', '');
  }

  static String toPhone(String phone) {
    return phone.replaceAll('@astore.com', "").replaceAll('m', '+');
  }

  static String skipHtml(String htmlString) {
    try {
      var document = parse(htmlString);
      String parsedString = parse(document.body.text).documentElement.text;
      return parsedString;
    } catch (e) {
      return "";
    }
  }

  static void showSnackInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  static void showSnackErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(backgroundColor: Colors.red, content: new Text(message)));
  }

  static void showSnackSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        backgroundColor: primaryColor, content: new Text(message)));
  }

  static String getMapKey(Product product) {
    var key = product.id.toString() + "-" + product.variationId.toString();
    return key;
  }

  static Product cloneObject(Product product) {
    Product p1 = new Product();
    p1.variationId = product.variationId;
    p1.variationDesc = product.variationDesc;
    p1.price = product.price;
    p1.desc = product.desc;
    p1.id = product.id;
    p1.variations = product.variations;
    p1.img = product.img;
    p1.name = product.name;
    p1.regularPrice = product.regularPrice;
    p1.sku = product.sku;

    return p1;
  }

  static bool isTimeAvailable(Time time, String date) {
    var to = int.parse(time.to.substring(0, 2));
    var dateArraySeparated = date.split('-');
    var month = int.parse(dateArraySeparated[1]);
    var day = int.parse(dateArraySeparated[2]);
    var dayType = time.to.trim().characters.last;
    var currentHour = DateTime.now().hour + 1;
    if (dayType == 'م') {
      to += 12;
    }

    if (currentHour > to &&
        (day == DateTime.now().day && month == DateTime.now().month)) {
      return false;
    }

    return true;
  }
}
