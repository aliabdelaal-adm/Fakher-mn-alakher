import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/data_layer/repositories/delivery-repository.dart';
import 'package:app/src/theme/animation/scale-route.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/screens/tracking.dart';
import 'package:flutter/material.dart';
import '../../../localizations.dart';

class OrderSuccessWidget extends StatelessWidget {
  final String cashBack;

  OrderSuccessWidget({Key key, this.cashBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        key: _con.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 120,
          title:
              Image.asset('assets/img/logo.png', fit: BoxFit.cover, height: 80),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 150,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/img/success.png",
                    ),
                  ),
                  Container(
                    child: Text(
                      AppLocalizations.of(context)
                          .your_order_has_been_successfully_submitted,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      AppLocalizations.of(context).thanks_for_ordering,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (selectedPayment.value == "bacs")
                    Column(
                      children: [
                        Container(
                          child: Text(
                            AppLocalizations.of(context).send_to_bank_account,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ),
                        Container(
                          child: SelectableText(
                            appConfigBloc.appConfig.bankIBAN,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            appConfigBloc.appConfig.bankName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  if (double.parse(this.cashBack) > 0)
                    Container(
                      child: Text(
                        AppLocalizations.of(context).congrats_cash_back +
                            this.cashBack +
                            AppLocalizations.of(context).currency +
                            " " +
                            AppLocalizations.of(context).in_your_wallet,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, ScaleRoute(page: TrackingWidget()));
                        },
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context).tracking_order,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade200,
                              offset: Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.blue.shade200,
                              offset: Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
