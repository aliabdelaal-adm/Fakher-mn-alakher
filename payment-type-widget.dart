import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/data_layer/repositories/delivery-repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../localizations.dart';

class PaymentTypeWidget extends StatefulWidget {
  @override
  _PaymentTypeWidgetState createState() => _PaymentTypeWidgetState();
}

class _PaymentTypeWidgetState extends State<PaymentTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPaymentTypesSheet(context);
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
                      AppLocalizations.of(context).payment_mode,
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
                      valueListenable: selectedPayment,
                      builder: (context, value, child) {
                        if (value == "cash_on_delivery") {
                          return selectedItem(
                              AppLocalizations.of(context).cash_on_delivery);
                        } else if (value == "tap_payment") {
                          return selectedItem(
                              AppLocalizations.of(context).credit_card);
                        } else if (value == "wallet") {
                          return selectedItem(
                              AppLocalizations.of(context).wallet);
                        } else if (value == "bacs") {
                          return selectedItem(
                              AppLocalizations.of(context).bank_transfer);
                        }
                        else {
                          return Text(
                            AppLocalizations.of(context)
                                .select_your_preferred_payment_mode,
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

  void _showPaymentTypesSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(children: [
              if (appConfigBloc.appConfig.codEnabled)
                ListTile(
                    title:
                        new Text(AppLocalizations.of(context).cash_on_delivery),
                    onTap: () {
                      selectedPayment.value = 'cash_on_delivery';
                      Navigator.pop(context);
                    }),
              if (appConfigBloc.appConfig.tapPaymentEnabled)
                ListTile(
                    title: new Text(AppLocalizations.of(context).credit_card),
                    onTap: () {
                      selectedPayment.value = 'tap_payment';
                      Navigator.pop(context);
                    }),
              if (appConfigBloc.appConfig.walletEnabled)
                ListTile(
                    title: new Text(AppLocalizations.of(context).wallet),
                    onTap: () {
                      selectedPayment.value = 'wallet';
                      Navigator.pop(context);
                    }),
              if (appConfigBloc.appConfig.bankTransferEnabled)
                ListTile(
                    title: new Text(AppLocalizations.of(context).bank_transfer),
                    onTap: () {
                      selectedPayment.value = 'bacs';
                      Navigator.pop(context);
                    })
            ]),
          );
        });
  }

  Widget selectedItem(String selectedPaymentType) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
          // color: Colors.green[50],
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        children: [
          Text(
            selectedPaymentType,
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
