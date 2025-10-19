class WalletResponse {
  String response;
  int id;

  WalletResponse(this.response, this.id);

  WalletResponse.fromJson(Map json)
      : response = json['response'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'id': id
    };
  }
}
