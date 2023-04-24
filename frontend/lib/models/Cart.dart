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

// class Cart {
//   String username = "";
//   String item = "";
//   int quantity = 0;
//   int price=0;
//   String image = "";
//   Cart({
//     required this.username,
//     required this.item,
//     required this.quantity,
//     required this.price,
//   });

//   Cart.fromJson(Map<String, dynamic> json) {
//     username = json['username'];
//     item = json['item'];
//     quantity = json['quantity'];
//     price = json['price'];
//     image =json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['username'] = this.username;
//     data['item'] = this.item;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['image']=this.image;
//     return data;
//   }
// }




