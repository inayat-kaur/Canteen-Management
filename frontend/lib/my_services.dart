import 'dart:convert';

import 'package:frontend/models/menu.dart';
import 'package:frontend/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/cart.dart';
import "package:http/http.dart";

class MyService {
  static final MyService _instance = MyService._internal();
  factory MyService() => _instance;

  late User _profile;
  late String _token = '';
  late List<Cart> _cart = [];
  late List<Menu> _menu = [];

  MyService._internal() {
    _profile = User(username: '', role: 0, name: '', phone: '', password: '');
    _token = '';
    _cart = [];
    _menu = [];
  }

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null && token != '') {
      _token = token;
      List<String>? profileString = prefs.getStringList('profile');
      if (profileString != null) {
        _profile.name = profileString[0];
        _profile.phone = profileString[1];
        _profile.username = profileString[2];
        _profile.role = int.parse(profileString[3]);
      }
      Client client = Client();
      final response = await client.get(getMenu, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List<dynamic> menuJson = json.decode(response.body);
        List<Menu> menu = [];
        for (int i = 0; i < menuJson.length; i++) {
          menu.add(Menu.fromJson(menuJson[i]));
        }
        _menu = menu;
      }
      final response2 = await client.get(getMyCart, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response2.statusCode == 200) {
        final List<dynamic> cartJson = json.decode(response2.body);
        List<Cart> cart = [];
        for (int i = 0; i < cartJson.length; i++) {
          cart.add(Cart.fromJson(cartJson[i]));
        }
        _cart = cart;
      }
      client.close();
    }
  }

  void printtest() {
    print("####################################");
    print(_cart.length);
    print(_menu.length);
    print(_token);
  }

  List<Menu> getMyMenu() {
    return _menu;
  }

  List<Cart> getCart() {
    return _cart;
  }

  void incrementInCart(String item, int quantity) {
    if (quantity <= 0) {
      Cart cart = Cart(username: "", item: "", quantity: 0);
      for (int i = 0; i < _cart.length; i++) {
        if (_cart[i].item == item) {
          cart = _cart[i];
          break;
        }
      }
      removeCart(cart);
    }
    for (int i = 0; i < _cart.length; i++) {
      if (_cart[i].item == item) {
        _cart[i].quantity = quantity;
        return;
      }
    }
  }

  void addCart(Cart cart) {
    if (_cart.contains(cart)) {
      for (int i = 0; i < _cart.length; i++) {
        if (_cart[i].item == cart.item) {
          _cart[i].quantity += cart.quantity;
          break;
        }
      }
    } else {
      _cart.add(cart);
    }
  }

  void removeCart(Cart cart) {
    _cart.remove(cart);
  }

  Future<void> updateToken(String token) async {
    _token = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == '') {
      prefs.remove('token');
    } else {
      prefs.setString('token', token);
    }
  }

  String getToken() {
    return _token;
  }

  Future<void> updateProfile(User user) async {
    _profile = user;
    List<String> profileString = [
      _profile.name,
      _profile.phone,
      _profile.username,
      _profile.role.toString()
    ];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('profile', profileString);
  }

  User getProfile() {
    return _profile;
  }
}
