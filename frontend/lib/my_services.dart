import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/user.dart';

class MyService {
  static final MyService _instance = MyService._internal();
  factory MyService() => _instance;

  late User _profile;
  late String _token;

  MyService._internal() {
    _profile = User(username: '', role: 0, name: '', phone: '', password: '');
    _token = '';
  }

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      _token = token;
      List<String>? profileString = prefs.getStringList('profile');
      if (profileString != null) {
        _profile.name = profileString[0];
        _profile.phone = profileString[1];
        _profile.username = profileString[2];
        _profile.role = int.parse(profileString[3]);
      }
    }
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
