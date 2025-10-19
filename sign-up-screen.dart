import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/bloc/customer-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/customer.dart';
import 'package:app/src/theme/animation/scale-route.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/screens/phone-code-verification-screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../localizations.dart';

class SignUpScreen extends StatefulWidget {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String isoCode = 'AE';
  PhoneNumber number = PhoneNumber(isoCode: 'AE');

  Future getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, isoCode);

    setState(() {
      this.number = number;
    });
  }

  // verifyUser(String phone, BuildContext context) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted:(FirebaseUser firebaseUser) {},
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //       codeSent: (String verificationId, [int forceResendingToken]) {
  //         print("verificationId " + verificationId);
  //         Navigator.push(
  //             context,
  //             ScaleRoute(
  //                 page: PinCodeVerificationScreen(
  //                     phone,
  //                     widget._nameController.text.trim(),
  //                     widget._passController.text.trim(),
  //                     verificationId)));
  //       }, verificationFailed: (AuthException error) { print("Failed verification"); });
  // }

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;
    OverlayEntry loader = Helper.overlayLoader(context);

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.close),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: 260,
                      height: 140,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/img/maleh_logo.png",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: widget._nameController,
                            showCursor: true,
                            textInputAction: TextInputAction.next,
                            validator: (v) {
                              if (v.length < 3) {
                                return AppLocalizations.of(context)
                                    .not_a_valid_full_name;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.short_text,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: AppLocalizations.of(context).name,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              setState(() {
                                this.isoCode = number.isoCode;
                              });
                            },
                            onInputValidated: (bool value) {},
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              backgroundColor: Colors.black,
                            ),
                            keyboardAction: TextInputAction.next,
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: widget._phoneController,
                            inputBorder: OutlineInputBorder(),
                            errorMessage:
                                AppLocalizations.of(context).not_a_valid_phone,
                            inputDecoration: InputDecoration(
                              hintText: AppLocalizations.of(context).phone,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                  color: Color(0xFF666666),
                                  fontFamily: defaultFontFamily,
                                  fontSize: defaultFontSize),
                            ),
                            countries: [
                              'SA',
                              'AE',
                              'KW',
                              'OM',
                              'QA',
                              'BH',
                              'EG',
                              appConfigBloc.appConfig.testingCountry
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: widget._passController,
                            obscureText: true,
                            showCursor: true,
                            textInputAction: TextInputAction.done,
                            validator: (v) {
                              if (v.length < 3) {
                                return AppLocalizations.of(context)
                                    .password_must_be_greater;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: AppLocalizations.of(context).password,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (innerContext) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30),
                        child: ButtonTheme(
                          height: 50,
                          child: FlatButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              bool isValid = formKey.currentState.validate();
                              if (isValid) {
                                await getPhoneNumber(
                                    widget._phoneController.text.trim());
                                print(this.number.phoneNumber);
                                if (appConfigBloc.appConfig != null &&
                                    !appConfigBloc
                                        .appConfig.phoneVerificationEnabled) {
                                  Overlay.of(context).insert(loader);
                                  Customer customer = Customer();
                                  customer.firstName =
                                      widget._nameController.text.trim();
                                  customer.phone = this.number.phoneNumber;
                                  customer.password =
                                      widget._passController.text.trim();
                                  customerBloc.signUp(customer).then((value) {
                                    if (value != null &&
                                        value.firstName != null) {
                                      customerBloc.saveCustomer(value);
                                      Helper.showSnackInfoMessage(context,
                                          AppLocalizations.of(context).welcome);
                                      Navigator.of(context).pop();
                                    } else {
                                      Helper.showSnackErrorMessage(
                                          context,
                                          AppLocalizations.of(context)
                                              .problem_occurred);
                                    }
                                  }).catchError((e) {
                                    print(e.toString());
                                    loader.remove();
                                    String error = AppLocalizations.of(context)
                                        .problem_occurred;
                                    if (e.toString().contains('email-exists')) {
                                      error = AppLocalizations.of(context)
                                          .this_phone_exists;
                                    }
                                    Helper.showSnackErrorMessage(
                                        innerContext, error);
                                  }).whenComplete(() {
                                    Helper.hideLoader(loader);
                                  });
                                } else {
                                  print("number is " + this.number.phoneNumber);
                                  // verifyUser(this.number.phoneNumber, context);
                                }
                              }
                            },
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context).sign_up,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: highlightColor,
                                  offset: Offset(1, -2),
                                  blurRadius: 5),
                              BoxShadow(
                                  color: highlightColor,
                                  offset: Offset(-1, 2),
                                  blurRadius: 5)
                            ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
