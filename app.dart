import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'localizations.dart';
import 'scope_model_wrapper.dart';
import 'src/routes.dart';
import 'src/theme/style.dart';

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _messageText = "Waiting for message...";
  String _homeScreenText = "Waiting for token...";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("error");
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            print("done");
            // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
            // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
            _firebaseMessaging.configure(
              onMessage: (Map<String, dynamic> message) async {
                _messageText = "Push Messaging message: $message";
                print("onMessage: $_messageText");
              },
              onLaunch: (Map<String, dynamic> message) async {
                _messageText = "Push Messaging message: $message";
                print("onLaunch: $_messageText");
              },
              onResume: (Map<String, dynamic> message) async {
                _messageText = "Push Messaging message: $message";
                print("onResume: $_messageText");
              },
            );
            _firebaseMessaging.requestNotificationPermissions(
                const IosNotificationSettings(
                    sound: true, badge: true, alert: true));
            _firebaseMessaging.onIosSettingsRegistered
                .listen((IosNotificationSettings settings) {
              print("Settings registered: $settings");
            });
            _firebaseMessaging.getToken().then((String token) {
              assert(token != null);
              _homeScreenText = "Push Messaging token: $token";
              print(_homeScreenText);
            });
          }
          return ScopedModelDescendant<AppModel>(
              builder: (context, child, model) => MaterialApp(
                    locale: model.appLocal,
                    localizationsDelegates: [
                      AppLocalizationsDelegate(),
                      // location_picker.S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      const Locale('ar', ''), // Arabic
                      const Locale('en', ''), // English
                    ],
                    debugShowCheckedModeBanner: false,
                    title: 'App',
                    theme: appTheme(),
                    initialRoute: '/splash',
                    onGenerateRoute: RouteGenerator.generateRoute,
                  ));
        });
  }
}
