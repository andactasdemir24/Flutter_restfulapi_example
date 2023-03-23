import 'package:flutter_restfulapi/Model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String url = 'https://reqres.in/api/users?page=2';

  Future<UsersModel?> fetchUsers() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonBody = UsersModel.fromJson(jsonDecode(response.body));
      return jsonBody;
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }
}
