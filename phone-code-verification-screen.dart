// import 'dart:async';
// import 'package:app/src/bloc/customer-bloc.dart';
// import 'package:app/src/common/helper.dart';
// import 'package:app/src/data_layer/models/customer.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import '../../../localizations.dart';
//
// class PinCodeVerificationScreen extends StatefulWidget {
//   final String phoneNumber;
//   final String name;
//   final String password;
//   final String verificationId;
//   final Customer customer = new Customer();
//
//   PinCodeVerificationScreen(this.phoneNumber, this.name, this.password,
//       this.verificationId);
//
//   @override
//   _PinCodeVerificationScreenState createState() =>
//       _PinCodeVerificationScreenState();
// }
//
// class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
//   var onTapRecognizer;
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   TextEditingController textEditingController = TextEditingController();
//
//   StreamController<ErrorAnimationType> errorController;
//
//   bool hasError = false;
//   String currentText = "";
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     onTapRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         Navigator.pop(context);
//       };
//     errorController = StreamController<ErrorAnimationType>();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     errorController.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     OverlayEntry loader = Helper.overlayLoader(context);
//
//     signUp(BuildContext context) async {
//       final code = textEditingController.text.trim();
//       print(code);
//       FirebaseUser firebaseUser;
//       try {
//         FirebaseUser firebaseUser = await _auth.signInWithPhoneNumber(
//             verificationId: widget.verificationId,smsCode: code);
//       } catch (ee) {
//         Helper.showSnackErrorMessage(
//             context, AppLocalizations
//             .of(context)
//             .invalid_verification_code);
//         print(ee.toString());
//         return;
//       }
//
//       if (firebaseUser != null) {
//         Overlay.of(context).insert(loader);
//         widget.customer.firstName = widget.name;
//         widget.customer.phone = widget.phoneNumber;
//         widget.customer.password = widget.password;
//         customerBloc.signUp(widget.customer).then((value) {
//           if (value != null && value.firstName != null) {
//             customerBloc.saveCustomer(value);
//             print(value.firstName);
//             Navigator.of(context).pop();
//             Helper.showSnackInfoMessage(
//                 context, AppLocalizations
//                 .of(context)
//                 .welcome);
//           } else {
//             Helper.showSnackErrorMessage(
//                 context, AppLocalizations
//                 .of(context)
//                 .problem_occurred);
//           }
//         }).catchError((e) {
//           print(e.toString());
//           loader.remove();
//           String error = AppLocalizations
//               .of(context)
//               .problem_occurred;
//           if (e.toString().contains('email-exists')) {
//             error = AppLocalizations
//                 .of(context)
//                 .this_phone_exists;
//           }
//           Helper.showSnackErrorMessage(context, error);
//         }).whenComplete(() {
//           Helper.hideLoader(loader);
//         });
//       } else {
//         Helper.showSnackErrorMessage(
//             context, AppLocalizations
//             .of(context)
//             .problem_while_verifying_code);
//       }
//     }
//
//     return Scaffold(
//       // resizeToAvoidBottomPadding: false,
//       resizeToAvoidBottomInset: false,
//       key: scaffoldKey,
//       body: GestureDetector(
//         onTap: () {},
//         child: Container(
//           height: MediaQuery
//               .of(context)
//               .size
//               .height,
//           width: MediaQuery
//               .of(context)
//               .size
//               .width,
//           child: ListView(
//             children: <Widget>[
//               InkWell(
//                 child: Container(
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Icon(Icons.close),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               SizedBox(height: 30),
//               Container(
//                 height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 3,
//                 child: Image.asset(
//                   "assets/img/maleh_logo.png",
//                 ),
//               ),
//               SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   AppLocalizations
//                       .of(context)
//                       .verification,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//                 child: RichText(
//                   text: TextSpan(
//                       text: AppLocalizations
//                           .of(context)
//                           .enter_phone_number_verification,
//                       children: [
//                         TextSpan(
//                             text: widget.phoneNumber,
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15)),
//                       ],
//                       style: TextStyle(color: Colors.black54, fontSize: 15)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Form(
//                 key: formKey,
//                 child: Builder(
//                   builder: (innerContext) =>
//                       Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8.0, horizontal: 30),
//                           child: Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: PinCodeTextField(
//                               textInputAction: TextInputAction.done,
//                               appContext: innerContext,
//                               pastedTextStyle: TextStyle(
//                                 color: Colors.green.shade600,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               length: 6,
//                               obscureText: false,
//                               obscuringCharacter: '*',
//                               animationType: AnimationType.fade,
//                               validator: (v) {
//                                 if (v.length < 3) {
//                                   return AppLocalizations
//                                       .of(context)
//                                       .invalid_verification_code;
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               pinTheme: PinTheme(
//                                 shape: PinCodeFieldShape.box,
//                                 borderRadius: BorderRadius.circular(5),
//                                 fieldHeight: 60,
//                                 fieldWidth: 50,
//                                 activeFillColor:
//                                 hasError ? Colors.orange : Colors.white,
//                               ),
//                               cursorColor: Colors.black,
//                               animationDuration: Duration(milliseconds: 300),
//                               textStyle: TextStyle(fontSize: 20, height: 1.6),
//                               enableActiveFill: true,
//                               errorAnimationController: errorController,
//                               controller: textEditingController,
//                               keyboardType: TextInputType.number,
//                               boxShadows: [
//                                 BoxShadow(
//                                   offset: Offset(0, 1),
//                                   color: Colors.black12,
//                                   blurRadius: 10,
//                                 )
//                               ],
//                               onCompleted: (v) async {
//                                 print("Completed");
//                                 signUp(innerContext);
//                               },
//                               onChanged: (value) {
//                                 print(value);
//                                 setState(() {
//                                   currentText = value;
//                                 });
//                               },
//                               beforeTextPaste: (text) {
//                                 print("Allowing to paste $text");
//                                 //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                                 //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                                 return true;
//                               },
//                             ),
//                           )),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Text(
//                   hasError ? "*Please fill up all the cells properly" : "",
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                     text: AppLocalizations
//                         .of(context)
//                         .did_not_receive_the_code,
//                     style: TextStyle(color: Colors.black54, fontSize: 15),
//                     children: [
//                       TextSpan(
//                           text: AppLocalizations
//                               .of(context)
//                               .resend,
//                           recognizer: onTapRecognizer,
//                           style: TextStyle(
//                               color: Color(0xFF91D3B3),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16))
//                     ]),
//               ),
//               Builder(
//                 builder: (innerContext) =>
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 16.0, horizontal: 30),
//                       child: ButtonTheme(
//                         height: 50,
//                         child: FlatButton(
//                           onPressed: () {
//                             var enteredPinCode = textEditingController.text
//                                 .trim();
//                             if (enteredPinCode.length > 3) {
//                               signUp(innerContext);
//                             }
//                           },
//                           child: Center(
//                               child: Text(
//                                 AppLocalizations
//                                     .of(context)
//                                     .verify,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.green.shade300,
//                           borderRadius: BorderRadius.circular(5),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.green.shade200,
//                                 offset: Offset(1, -2),
//                                 blurRadius: 5),
//                             BoxShadow(
//                                 color: Colors.green.shade200,
//                                 offset: Offset(-1, 2),
//                                 blurRadius: 5)
//                           ]),
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
