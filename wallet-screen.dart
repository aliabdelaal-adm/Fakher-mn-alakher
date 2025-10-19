import 'package:app/src/bloc/wallet-bloc.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../localizations.dart';

class WalletWidget extends StatelessWidget {
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
        body: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 40, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 160,
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
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          AppLocalizations.of(context).wallet_balance,
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF3a3a3b),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: StreamBuilder<Object>(
                            stream: walletBloc.walletBalanceStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final results = (snapshot.data as String) +
                                    AppLocalizations.of(context).currency;
                                return Text(
                                  results,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                );
                              }
                              return Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              );
                            }),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
