import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/reusablewidgets/neomorphism_loading_button.dart';
import 'package:motivated_admin/reusablewidgets/reusable_neomorphism_button.dart';

class PoemTab extends StatefulWidget {
  const PoemTab({super.key});

  @override
  State<PoemTab> createState() => _PoemTabState();
}

class _PoemTabState extends State<PoemTab> {
  final fireStore = FirebaseFirestore.instance.collection('poets').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('poets');
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
                return Center(
                  child: ReusableNeomorphismButton(
                      title: 'Something went wrong',
                      onTap: () {},
                      toggleElevation: true),
                );
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Center(
                    child: ReusableNeomorphismButton(
                        title: 'No poets available',
                        onTap: () {},
                        toggleElevation: true),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: NeomorphismLoadingButton(
                      title: 'Loading', onTap: () {}, toggleElevation: true),
                );
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
