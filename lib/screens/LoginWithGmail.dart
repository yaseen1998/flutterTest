import 'package:citycafe_app/screens/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithGmail extends StatelessWidget {
  const LoginWithGmail({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    Future<void> addUser() async {
      var login = FirebaseAuth.instance;
      UserCredential userCredential =
          await login.signInWithPopup(GoogleAuthProvider());
      // check if user document is exist
      var userDoc = await user.doc(userCredential.user!.uid).get();
      if (!userDoc.exists) {
        // if not exist create new user document
        await user.doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'isAdmin': false,
        });
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Firestore()),
      );
    }

    return Container(
      child: ElevatedButton(
        onPressed: () {
          // try {
          addUser();
        },
        child: const Text('Login with Gmail'),
      ),
    );
  }
}