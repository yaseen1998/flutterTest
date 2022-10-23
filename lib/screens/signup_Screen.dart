import 'package:citycafe_app/screens/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  Future<void> addUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    // Call the user's CollectionReference to add a new user
    return user
        .doc(userCredential.user?.uid)
        .set({
          'username': nameController.text, // John Doe
          'email': emailController.text, // John Doe
          'password': passwordController.text, // Stokes and Sons
          'isAdmin': false,
        })
        .then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Firestore())))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, controller, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: title,
                labelStyle: TextStyle(fontSize: 20),
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          addUser();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff2b5eaf), Color(0xff2b5eaf)])),
          child: Text(
            'Register Now',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_screen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.all(0),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                color: Color(0xff2b5eaf),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
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
              fontWeight: FontWeight.bold,
              letterSpacing: 7,
              fontSize: 38,
              color: Color(0xff2b5eaf)),
          children: [
            TextSpan(
              text: 'uc Stu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 7,
                  color: Colors.black,
                  fontSize: 38),
            ),
            TextSpan(
              text: 'dents',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2b5eaf),
                fontSize: 38,
                letterSpacing: 7,
              ),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          _entryField("Username", nameController),
          _entryField("Email id", emailController),
          _entryField("Password", passwordController, isPassword: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Text("abed"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 150),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 2, left: 2),
                      child: _title(),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: _emailPasswordWidget(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: _submitButton(),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: _loginAccountLabel(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
