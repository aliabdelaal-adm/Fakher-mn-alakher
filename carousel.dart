class CarouselItem {
  final String image;
  final String title;


  CarouselItem.fromJson(json)
      : image = json['image'],
        title = json['title'];

}
