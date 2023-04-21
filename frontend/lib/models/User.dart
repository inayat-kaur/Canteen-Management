class User {
  String username = "";
  int role = 0; // 0: customer, 1: owner
  String name = "";
  String phone = "";
  String password = "";

  User({
    required this.username,
    required this.role,
    required this.name,
    required this.phone,
    required this.password,
  });

  void fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['role'] = this.role.toString();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}
