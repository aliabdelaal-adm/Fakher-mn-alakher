class OrderMetaData {
  String key;
  var value;

  OrderMetaData(this.key, this.value);

  OrderMetaData.fromJson(Map json)
      : key = json['key'],
        value = json['value'];

  Map<String, dynamic> toJson() {
    return {'key': key, 'value': value};
  }
}
