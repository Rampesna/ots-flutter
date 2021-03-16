import 'package:shared_preferences/shared_preferences.dart';
import 'package:ays_operation/services/api/api_base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authentication extends ApiBase {
  login(email, password, model) async {
    var apiVersion = 'v1';
    var endpoint = '/authentication/login';

    var response = await http.post(
      getBaseUrl() + apiVersion + endpoint,
      body: {
        'email': email,
        'password': password,
        'model': model,
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString('_authenticated_name', jsonResponse['content']['name']);
      sharedPreferences.setString('_authenticated_email', jsonResponse['content']['email']);
      sharedPreferences.setString('_token', jsonResponse['content']['api_token']);
      sharedPreferences.setString('_model', model);

      return jsonResponse;
    } else {
      return null;
    }
  }

  static logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('_authenticated_name', null);
    sharedPreferences.setString('_authenticated_email', null);
    sharedPreferences.setString('_token', null);
    sharedPreferences.setString('_model', null);
  }
}
