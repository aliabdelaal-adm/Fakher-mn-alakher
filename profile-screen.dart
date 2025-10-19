import 'package:app/src/bloc/customer-bloc.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../localizations.dart';
import '../../../scope_model_wrapper.dart';
import 'login-screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: bgColor,
            toolbarHeight: 120,
            title: Image.asset('assets/img/logo.png',
                fit: BoxFit.cover, height: 120),
            centerTitle: true,
            elevation: 0,
            bottom: currentCustomer.value.authenticated
                ? PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).profile,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ))
                : null),
        body: ValueListenableBuilder(
            valueListenable: currentCustomer,
            builder: (context, value, child) {
              if (value.authenticated) {
                return profileWidget();
              } else {
                return LoginScreen();
              }
            })
        // (currentCustomer.value.authenticated)
        //     ? profileWidget()
        //     : SignUpScreen()
        // );

        );
  }

  profileWidget() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        currentCustomer.value.firstName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        currentCustomer.value.phone
                            .replaceAll("@astore.com", "")
                            .replaceFirst('m', ''),
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.50),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    //Navigator.of(context).pushNamed('/Help');
                  },
                  dense: true,
                  title: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.language,
                            size: 22,
                            color: greyColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).app_language,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      ScopedModelDescendant<AppModel>(
                          builder: (context, child, model) => MaterialButton(
                                onPressed: () {
                                  model.changeDirection();
                                },
                                // height: 60.0,
                                // color: const Color.fromRGBO(119, 31, 17, 1.0),
                                child: new Text(
                                  AppLocalizations.of(context).language,
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                      Divider(
                        color: greyColor,
                        height: 20,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      ListTile(
                        onTap: () {
                          customerBloc.logout();
                          setState(() {
                            currentCustomer.value.authenticated = false;
                          });
                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //     '/signup', (Route<dynamic> route) => false);
                          // Navigator.of(context).pushNamed('/DeliveryAddresses');
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.logout,
                              size: 22,
                              color: greyColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context).logout,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
