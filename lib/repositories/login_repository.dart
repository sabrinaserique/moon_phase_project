import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Login.dart';

const loginListKey = 'login_list';

class LoginRepository {
  LoginRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }
  late SharedPreferences sharedPreferences;

  Future<List<Login>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(loginListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded.map((e) => Login.fromJson(e)).toList();

  }

  void saveLoginList(List<Login> registros){
    final jsonString = json.encode(registros);
    sharedPreferences.setString('login_list', jsonString);
  }

  Future<void> cleanShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}