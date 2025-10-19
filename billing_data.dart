class Billing {
  String firstName;
  String lastName;
  String phone;

  Billing(this.firstName, this.lastName, this.phone);

  Billing.fromJson(Map json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        phone = json['phone'];

  Map<String, dynamic> toJson() {
    return {'first_name': firstName, 'last_name': lastName, 'phone': phone};
  }
}
