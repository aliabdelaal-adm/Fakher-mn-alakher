import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../localizations.dart';

class FoodTitleWidget extends StatelessWidget {
  final String productName;
  final String productPrice;

  FoodTitleWidget({
    Key key,
    @required this.productName,
    @required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            productName,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w500),
          ),
          Text(
            productPrice + " " + AppLocalizations.of(context).currency,
            style: TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
