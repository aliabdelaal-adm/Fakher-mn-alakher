import 'dart:convert';

class Address {
  String description;
  String address;
  double latitude;
  double longitude;
  bool isDefault;

  Address();

  Address.fromJson(Map<String, dynamic> jsonMap) {
    try {
      description = jsonMap['description'] != null
          ? jsonMap['description'].toString()
          : null;
      address = jsonMap['address'] != null ? jsonMap['address'] : null;
      latitude = jsonMap['latitude'] != null ? jsonMap['latitude'] : null;
      longitude = jsonMap['longitude'] != null ? jsonMap['longitude'] : null;
      isDefault = jsonMap['is_default'] ?? false;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Map<String, dynamic> toMap(Address address) => {
    'address': address.address,
    'latitude': address.latitude,
    'longitude': address.longitude,
  };


  static List<Address> decodeAddresses(String addresses) =>
      (json.decode(addresses) as List<dynamic>)
          .map<Address>((item) => Address.fromJson(item))
          .toList();

  static String encodeAddresses(List<Address> addresses) => json.encode(
    addresses
        .map<Map<String, dynamic>>((item) => Address.toMap(item))
        .toList(),
  );
}
