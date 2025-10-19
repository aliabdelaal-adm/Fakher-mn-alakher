class Customer {
  int id;
  String firstName;
  String lastName;
  String phone;
  String password;

  bool authenticated;

  Customer();

  Customer.fromJson(Map json)
      : id = json['id'],
        firstName = json['first_name'] != null ? json['first_name'] : " ",
        lastName = json['last_name'] != null ? json['last_name'] : " ",
        phone = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': phone,
    };
  }
}
