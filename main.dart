import 'dart:io';

import 'package:app/src/bloc/delivery-bloc.dart';
import 'package:flutter/material.dart';
import 'scope_model_wrapper.dart';
import 'src/bloc/app-config-bloc.dart';
import 'src/bloc/categories_fetch_bloc.dart';
import 'src/bloc/customer-bloc.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // await GlobalConfiguration().loadFromAsset("configurations");
  print('Fetch App Config');
  appConfigBloc.fetchAppConfig();
  print('get saved language');
  await appConfigBloc.getSavedLanguage();
  // print('getSavedAddresses');
  deliveryBloc.getSavedAddresses();
  print('Fetching categories');
  categoriesFetchBloc.fetchCategories();
  print('Get Customer');
  customerBloc.getSavedCustomer();
  runApp(new ScopeModelWrapper());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =(X509Certificate cert, String host, int port) {
        return true;
      };
  }
}