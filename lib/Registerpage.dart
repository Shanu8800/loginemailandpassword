import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginscreen/Homepage.dart';
import 'package:loginscreen/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    'Register',
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
                    if(password!.length < 6){
                      return "password can be atleast 6 letters";
                    }
                  },
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     //forgot password screen
              //   },
              //   child: const Text('Forgot Password',),
              // ),
              SizedBox(height: 20,),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();

                      try {
                        if(_formkey.currentState!.validate()){
                          var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: nameController.text.toString(),
                              password: passwordController.text.toString());
                          var success = response.user!.email;

                          if(success!= null){
                            print(response.toString());
                            Future.delayed(Duration(seconds: 2)).then((value) {
                              CircularProgressIndicator();
                            }).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                            });
                          } else{
                            print('not registered');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                          }
                        }
                        } catch (e){
                        print(e.toString());
                      }

                        //  var success = response.user!.email.toString();


                        // UserCredential  userCredential  = await  FirebaseAuth.instance.createUserWithEmailAndPassword(
                        //   email: nameController.text.toString(),
                        //   password: passwordController.text.toString(),
                        // );
                        // SharedPreferences pref =await SharedPreferences.getInstance();
                        // pref.setString('email', nameController.text.toString());
                        // pref.setString('email', passwordController.text.toString());
                        // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        // email: emailAddress,
                        // password: password
                        // );
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  Text('Do you have account?'),
                  TextButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginpage()));
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
