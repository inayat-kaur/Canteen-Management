import 'package:frontend/models/user.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:frontend/models/user.dart';
import '../../my_services.dart';
import '../../urls.dart';

Future<User> getProfile() async {
  MyService myServices = MyService();
  User user = myServices.getProfile();
  if (user.username == '') {
    Client client = Client();
    String token = myServices.getToken();
    final response = await client
        .get(getUserProfile, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      user.fromJson(body['message'][0]);
      myServices.updateProfile(user);
    } else {
      throw Exception('Error getting profile');
    }
  }
  return user;
}

Future<String> updateName(String newName) async {
  MyService myServices = MyService();
  Client client = Client();
  String token = myServices.getToken();
  final response = await client.put(updateUserName, headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'name': newName,
  });
  client.close();
  if (response.statusCode == 200) {
    User user = myServices.getProfile();
    user.name = newName;
    myServices.updateProfile(user);
    return newName;
  } else {
    throw Exception('Error updating profile');
  }
}

Future<String> updatePhone(String newPhone) async {
  MyService myServices = MyService();
  Client client = Client();
  String token = myServices.getToken();
  final response = await client.put(updateUserPhone, headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'phone': newPhone,
  });
  client.close();
  if (response.statusCode == 200) {
    User user = myServices.getProfile();
    user.phone = newPhone;
    myServices.updateProfile(user);
    return newPhone;
  } else {
    throw Exception('Error updating profile');
  }
}

Future<void> logout() async {
  MyService myServices = MyService();
  myServices.updateToken('');
}

Future<String> getUsername() async {
  MyService myServices = MyService();
  String username = myServices.getProfile().username;
  if (username == null) {
    return "";
  }
  print("getUsername() called");
  return username;
}
