import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdataData extends StatefulWidget {
  final documentID;
  const UpdataData({super.key, this.documentID});

  @override
  State<UpdataData> createState() => _UpdataDataState();
}

class _UpdataDataState extends State<UpdataData> {
  var data = {
    'name': '',
    'value': 0,
  };
  @override
  Widget build(BuildContext context) {
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
              data['name'] = value;
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
              data['value'] = num.parse(value);
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
            onPressed: () async {
              try {
                FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.documentID)
                    .update(data);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                ));
              }
            },
            child: const Text('update'))
      ]),
    );
  }
}