import 'package:citycafe_app/Modal/AddProducts.dart';
import 'package:citycafe_app/Modal/UpdateCart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore extends StatefulWidget {
  const Firestore({super.key});

  @override
  State<Firestore> createState() => _FirestoreState();
}

class _FirestoreState extends State<Firestore> {
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get()
            .then((value) {
          setState(() {
            isAdmin = value.data()!['isAdmin'];
          });
        });
      }
    });
  }

  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
    Future<void> update(id) async {
      if (isAdmin) {
        showDialog(
          context: context,
          builder: (context) => UpdataData(documentID: id),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('you are no admin your can not update'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('login')),
            ],
          ),
        );
      }
    }

    Future<void> delete(id) async {
      if (isAdmin) {
        FirebaseFirestore.instance
            .collection('products')
            .doc(id)
            .delete()
            .then((value) => const Text("deleted"));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('you are no admin your can not update'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('login')),
            ],
          ),
        );
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(context: context, builder: (context) => const Adddata());
      }),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['value'].toString()),
                leading: const Icon(Icons.shopping_bag_sharp),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        delete(document.id);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        update(document.id);
                      },
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}