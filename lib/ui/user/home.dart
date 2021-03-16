import 'package:flutter/material.dart';
import 'package:ays_operation/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ays_operation/services/api/authentication/authentication.dart';

String name;
String email;

getSharedPreferences() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  name = prefs.getString("_authenticated_name");
  email = prefs.getString("_authenticated_email");

  print(name);
  print(email);
}

class UserHome extends StatefulWidget {

  UserHome(){
    getSharedPreferences();
  }

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 160.0,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "images/avatar.jpg",
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 14),
                          child: Text(
                            name ?? '',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            email ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Colors.orange,
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Çıkış Yap'),
              onTap: () {
                Authentication.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Yönetici Ekranı',
        ),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Yönetici Ekranı',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
