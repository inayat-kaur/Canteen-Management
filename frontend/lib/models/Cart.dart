class Cart {
  String username = "";
  String item = "";
  int quantity = 0;

  Cart({
    required this.username,
    required this.item,
    required this.quantity,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    item = json['item'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['item'] = this.item;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  String image;
  String title;
  int price;
  int quantity;
  String availability;
  int rating;
  String category;
  int type;

  Product(
      {required this.image,
      required this.title,
      required this.price,
      required this.quantity,
      required this.availability,
      required this.rating,
      required this.category,
      required this.type});
}
