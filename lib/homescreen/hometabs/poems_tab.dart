import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PoemTab extends StatefulWidget {
  const PoemTab({super.key});

  @override
  State<PoemTab> createState() => _PoemTabState();
}

class _PoemTabState extends State<PoemTab> {
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['full_name'].toString()),
                      subtitle: Text(data['company']),
                      onTap: () {
                        users
                            .doc(data['id'].toString())
                            .delete()
                            .then((value) => debugPrint("User Updated"))
                            .catchError((error) =>
                                debugPrint("Failed to update user: $error"));
                        users
                            .doc(data['id'].toString())
                            .update({'full_name': 'Asif Taj'})
                            .then((value) => debugPrint("User Updated"))
                            .catchError((error) =>
                                debugPrint("Failed to update user: $error"));
                      },
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
