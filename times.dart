class Time {
  String from;
  String to;
  bool enabled;

  Time();

  Time.fromJson(json)
      : from = json['from'],
        to = json['to'],
        enabled = json['enabled'];
}
