import 'package:citycafe_app/screens/LoginWithGmail.dart';
import 'package:citycafe_app/screens/firestore.dart';
import 'package:citycafe_app/screens/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> Login() async {
    try {
      var login = FirebaseAuth.instance;
      UserCredential userCredential = await login.signInWithEmailAndPassword(
          email: nameController.text, password: passwordController.text);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Firestore()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 25),
                  child: _title()),
              Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("images/7.png"),
                  width: 300,
                  height: 205,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                height: 50,
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2b5eaf)),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Login();
                    },
                  )),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    color: Color(0xff2b5eaf),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    const Text(
                      'Does not have account?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff2b5eaf),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    const Text(
                      'you can Login with ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Gmail',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff2b5eaf),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginWithGmail();
                          },
                        ));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          )),
    );
  }
}

Widget _title() {
  return RichText(
    softWrap: false,
    text: TextSpan(
        onEnter: ((event) {
          print("123");
        }),
        text: 'Lt',
        style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 5,
            fontSize: 35,
            color: Color(0xff2b5eaf)),
        children: [
          TextSpan(
            text: 'uc Stu',
            style:
                TextStyle(letterSpacing: 5, color: Colors.black, fontSize: 35),
          ),
          TextSpan(
            text: 'dents',
            style: TextStyle(
              color: Color(0xff2b5eaf),
              fontSize: 35,
              letterSpacing: 5,
            ),
          ),
        ]),
  );
}
