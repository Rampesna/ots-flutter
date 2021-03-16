import 'package:ays_operation/ui/employee/home.dart';
import 'package:ays_operation/ui/user/home.dart';
import 'package:flutter/material.dart';
import 'package:ays_operation/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;
String model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("_token");
  model = prefs.getString("_model");
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Operasyon Takip Sistemi',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: token == null
          ? LoginPage()
          : (model == 'User' ? UserHome() : (model == 'Employee' ? EmployeeHome() : LoginPage())),
    );
  }
}
