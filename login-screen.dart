import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:app/src/bloc/customer-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/customer.dart';
import 'package:app/src/theme/animation/scale-route.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/screens/sign-up-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../localizations.dart';

class LoginScreen extends StatefulWidget {
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
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

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;
    OverlayEntry loader = Helper.overlayLoader(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              child: Column(
                children: <Widget>[
                  Builder(
                    builder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
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
                                ignoreBlank: false,
                                keyboardAction: TextInputAction.done,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    TextStyle(color: Colors.black),
                                initialValue: number,
                                textFieldController: widget._phoneController,
                                inputBorder: OutlineInputBorder(),
                                errorMessage: AppLocalizations.of(context)
                                    .not_a_valid_phone,
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
                                showCursor: true,
                                obscureText: true,
                                controller: widget._passController,
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
//                          suffixIcon: Icon(
//                            Icons.remove_red_eye,
//                            color: Color(0xFF666666),
//                            size: defaultIconSize,
//                          ),
                                  fillColor: Color(0xFFF2F3F5),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                  ),
                                  hintText:
                                      AppLocalizations.of(context).password,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
//                      Container(
//                        width: double.infinity,
//                        child: Text(
//                          AppLocalizations.of(context).forgot_password,
//                          style: TextStyle(
//                            color: Color(0xFF666666),
//                            fontFamily: defaultFontFamily,
//                            fontSize: defaultFontSize,
//                            fontStyle: FontStyle.normal,
//                          ),
//                          textAlign: TextAlign.start,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 15,
//                      ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 30),
                          child: ButtonTheme(
                            height: 50,
                            child: FlatButton(
                              onPressed: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                bool isValid = formKey.currentState.validate();
                                if (isValid) {
                                  await getPhoneNumber(
                                      widget._phoneController.text.trim());
                                  Overlay.of(context).insert(loader);
                                  final Customer customer = Customer();
                                  final phone = this.number.phoneNumber;
                                  final password =
                                      widget._passController.text.trim();
                                  customer.phone = phone;
                                  customer.password = password;
                                  print(phone);
                                  print(password);

                                  customerBloc.login(customer).then((value) {
                                    if (value != null &&
                                        value.firstName != null) {
                                      customerBloc.saveCustomer(value);

                                    } else {
                                      Helper.showSnackErrorMessage(
                                          context,
                                          AppLocalizations.of(context)
                                              .problem_occurred);
                                    }
                                  }).catchError((e) {
                                    loader.remove();
                                    print(e.toString());
                                    Helper.showSnackErrorMessage(
                                        context,
                                        AppLocalizations.of(context)
                                            .wrong_phone_or_password);
                                  }).whenComplete(() {
                                    Helper.hideLoader(loader);
                                  });
                                }
                              },
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context).login,
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

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                AppLocalizations.of(context)
                                        .dont_have_an_account +
                                    " ",
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontFamily: defaultFontFamily,
                                  fontSize: defaultFontSize,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, ScaleRoute(page: SignUpScreen()));
                              },
                              child: Container(
                                child: Text(
                                  AppLocalizations.of(context).sign_up,
                                  style: TextStyle(
                                    color: Color(0xFFf7418c),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
