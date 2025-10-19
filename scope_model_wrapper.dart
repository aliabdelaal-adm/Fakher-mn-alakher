import 'package:app/src/bloc/app-config-bloc.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'app.dart';

class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(model: AppModel(), child: App());
  }
}

class AppModel extends Model {
  Locale _appLocale =  appConfigBloc.locale;
  Locale get appLocal => _appLocale ?? Locale("ar");

  void changeDirection() {
    if (_appLocale == Locale("ar")) {
      _appLocale = Locale("en");
    } else {
      _appLocale = Locale("ar");
    }
    print(_appLocale.languageCode);
    appConfigBloc.saveLanguage(_appLocale.languageCode);

    notifyListeners();
  }
}