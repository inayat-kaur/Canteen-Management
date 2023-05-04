class Menu {
  String item = "";
  int price = 0;
  String availability = "U"; // U: unavailable, A: available
  int rating = 0;
  String category = ""; // TODO: decide categories
  int type = 0; // 0: veg, 1: non-veg
  String image = "";

  Menu({
    required this.item,
    required this.price,
    required this.availability,
    required this.rating,
    required this.category,
    required this.type,
    required this.image,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    price = json['price'];
    availability = json['availability'];
    rating = json['rating'];
    category = json['category'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['price'] = this.price.toString();
    data['availability'] = this.availability;
    data['rating'] = this.rating.toString();
    data['category'] = this.category;
    data['type'] = this.type.toString();
    data['image'] = this.image;
    return data;
  }
}
