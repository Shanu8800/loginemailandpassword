import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/Registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController employeController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'TutorialKart',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                  validator: (email){
                    if(email!.isEmpty){
                      return "name can not be emply";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (password){
                  RegExp regex =  RegExp(r'([A-Z]{5}[0-9]{4}[A-Z]{1}$)|([A-Z]{5}[0-9]{1,4}$)|[A-Z]{1,5}$');
                    if(password!.length < 6 && regex.hasMatch(password)){
                      return "password can be atleast 6 letters";
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Forgot Password',),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: employeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Employe name',
                  ),
                  validator: (employe){
                    if(employe!.isEmpty){
                      return "name can not be emply";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container
                (
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      var data = firestore.collection("Employes_name").doc().set({
                        "emloyename": employeController.text.toString()

                      });
                      print(data.toString());
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        if(_formkey.currentState!.validate()){
                          var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: nameController.text.toString(), password: passwordController.text.toString());
                          var success = response.user!.email;


                          if(success!= null){
                            setState(() {
                              isLoading = false;
                            });
                            print(response.toString());
                            Future.delayed(Duration(seconds: 2)).then((value) {
                              const CircularProgressIndicator();
                            }).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                            });
                          }
                        } else {
                          print('not registered');
                        }
                      } catch (e){
                        Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  Text('Does not have account?'),
                  TextButton(
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
