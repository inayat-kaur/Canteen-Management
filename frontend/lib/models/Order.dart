class Order {
  String username = "";
  String orderType = "I"; // I: Instantaneous, P: Pre-Order
  String item = "";
  int quantity = 0;
  int price = 0;
  String orderStatus =
      "N"; // N: Not accepted, U: Under preparation, R: Ready, C: Collected
  String paymentStatus = "N"; // Y: Yes (Paid), N: No (Not Paid)
  DateTime time = DateTime.now();

  Order({
    required this.username,
    required this.orderType,
    required this.item,
    required this.quantity,
    required this.price,
    required this.orderStatus,
    required this.paymentStatus,
    required this.time,
  });

  Order.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    orderType = json['orderType'];
    item = json['item'];
    quantity = json['quantity'];
    price = json['price'];
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    time = DateTime.parse(json['delivery_time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['orderType'] = orderType;
    data['item'] = item;
    data['quantity'] = quantity;
    data['price'] = price;
    data['order_status'] = orderStatus;
    data['payment_status']  = paymentStatus;
    data['delivery_time'] = time.toIso8601String();
    return data;
  }
}
