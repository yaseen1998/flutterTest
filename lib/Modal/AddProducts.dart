import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adddata extends StatefulWidget {
  const Adddata({super.key});

  @override
  State<Adddata> createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
  String name = '';
  num price = 0;
  @override
  Widget build(BuildContext context) {
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return products
          .add({
            'name': name, // John Doe
            'value': price, // Stokes and Sons
          })
          .then((value) => print("products Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
     return AlertDialog(
      content: Column(children: [
        const Center(
          child: Text('welcom your app'),
        ),
        const Divider(height: 25),
        const Text("name"),
        TextField(
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
        const Text("Price"),
        TextField(
          onChanged: (value) {
            setState(() {
              price = num.parse(value);
            });
          
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'price',
          ),
        ),
        const Divider(
          height: 25,
        ),
        TextButton(
            onPressed: addUser,
            child: const Text('add products'))
      ]),
    );
  
  }
}