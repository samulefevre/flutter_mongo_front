import 'package:flutter/material.dart';
import 'package:flutter_mongo_front/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name, password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Authenticate'),
              color: Colors.blue,
              onPressed: () {
                AuthService().login(name, password).then((val) {
                  if (val.data['success']) {
                    token = val.data['token'];
                    FlutterToast.showToast(
                      msg: 'Authenticated',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                });
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Add user'),
              color: Colors.green,
              onPressed: () {
                AuthService().addUser(name, password).then((val) {
                  FlutterToast.showToast(
                    msg: val.data['msg'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                });
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Get info'),
              color: Colors.green,
              onPressed: () {
                AuthService().getInfo(token).then((val) {
                  print(val);
                  FlutterToast.showToast(
                    msg: val.data['msg'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
