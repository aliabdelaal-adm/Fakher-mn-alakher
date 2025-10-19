class Social {
  final String name;
  final String imgUrl;
  final String data;
  final bool isEnabled;

  Social.fromJson(json)
      : name = json['name'],
        imgUrl = json['image_url'],
        data = json['data'],
        isEnabled = json['is_enabled'];
}
