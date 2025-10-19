class Category {
  final int id;
  final String name;
  final String desc;
  final String img;
  final int menuOrder;

  Category(this.id, this.name, this.desc, this.img, this.menuOrder);

  Category.fromJson(json)
      : id = json['id'],
        name = json['name'],
        img = (json['image'] != null && json['image']['src'] != null)
            ? json['image']['src']
            : " ",
        desc = json['description'],
        menuOrder = json['menu_order'];
}
