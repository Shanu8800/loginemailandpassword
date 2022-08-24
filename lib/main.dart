import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginscreen/Homepage.dart';
import 'package:loginscreen/Registerpage.dart';
import 'package:loginscreen/Testpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyA7TdxwtsnebqK8SC_SV_nTkxUnhGXeH4w",
      appId: '1:648441638673:android:8ca9820737fa6c1e0e66b0',
      messagingSenderId: '648441638673',
      projectId: 'loginscreen-4d3e1'),
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static  String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title:  Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();

}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override

  final _auth= FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return const Loginpage();

  }
}















