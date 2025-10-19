import 'dart:convert';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/app-config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigRepository {

  final _configApi = "wp-json";

  Future<AppConfig> fetchAppConfig() async {
    final path = 'app/config';
    final uri = Uri.https(Helper.BASE_URL, '$_configApi/$path');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      AppConfig appConfig =  AppConfig.fromJson(jsonMap);
      print(response.body);

      return appConfig;
    } else {
      throw Exception('Failed to get data');
    }
  }

  saveLanguage(language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  Future<String> getSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('language')) {
      return prefs.get('language');
    }
    return 'ar';
  }
}
