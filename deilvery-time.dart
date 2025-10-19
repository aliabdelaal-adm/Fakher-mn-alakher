
import 'package:app/src/data_layer/models/times.dart';

class DeliveryTime {
  final String day;
  final bool enabled;
  final List<Time> times;
  String date;
  String dayAr;

  DeliveryTime(this.day, this.enabled, [this.times]);

  factory DeliveryTime.fromJson(dynamic json) {
    if (json['times'] != null) {
      var timesObjsJson = json['times'] as List;
      List<Time> _times = timesObjsJson.map((timesJson) => Time.fromJson(timesJson)).toList();

      return DeliveryTime(
          json['day'] as String,
          json['enabled'] as bool,
          _times
      );
    } else {
      return DeliveryTime(
          json['day'] as String,
          json['enabled'] as bool
      );
    }
  }

}
