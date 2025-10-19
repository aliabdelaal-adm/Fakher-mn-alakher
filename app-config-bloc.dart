import 'package:app/src/data_layer/models/app-config.dart';
import 'package:app/src/data_layer/repositories/app-config-repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppConfigBloc {
  AppConfigRepository _appConfigRepository = AppConfigRepository();

  AppConfig appConfig ;

  Locale locale;

  final _appConfigFetcher = BehaviorSubject<AppConfig>();

  Stream<AppConfig> get appConfigStream => _appConfigFetcher.stream;

  fetchAppConfig() async {
    AppConfig appConfigResponse = await _appConfigRepository.fetchAppConfig();
    _appConfigFetcher.sink.add(appConfigResponse);
    appConfig = appConfigResponse;
  }

  getSavedLanguage() async {
    String language = await _appConfigRepository.getSavedLanguage();
    locale = Locale(language);
  }

  saveLanguage(String language) => _appConfigRepository.saveLanguage(language);

  dispose() {
    _appConfigFetcher.close();
  }
}

final appConfigBloc = AppConfigBloc();
