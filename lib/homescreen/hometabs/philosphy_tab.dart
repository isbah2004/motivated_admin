import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/configphilospher/add_philospher.dart';
import 'package:motivated_admin/configphilospher/philospher_concept.dart';
import 'package:motivated_admin/configphilospher/update_philospher.dart';
import 'package:motivated_admin/reusablewidgets/reusable_neomorphism_button.dart';
import 'package:motivated_admin/utils/utils.dart';

class PhilosphyTab extends StatefulWidget {
  const PhilosphyTab({super.key});

  @override
  State<PhilosphyTab> createState() => _PhilosphyTabState();
}

class _PhilosphyTabState extends State<PhilosphyTab> {
  final fireStore =
      FirebaseFirestore.instance.collection('philosphers').snapshots();

  CollectionReference philosphersRef =
      FirebaseFirestore.instance.collection('philosphers');
late String name;
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
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Center(
                    child: ReusableNeomorphismButton(
                        title: 'Loading', onTap: () {}, toggleElevation: true),
                  ),
                );
              }

            else  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Center(
                    child: ReusableNeomorphismButton(
                        title: 'No philosphers available',
                        onTap: () {
                       
                        },
                        toggleElevation: true),
                  ),
                );
              }
             
              return Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        name = data['title'];
                    return ListTile(
                      trailing: PopupMenuButton(
                        color: Colors.white,
                        elevation: 4,
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        icon: const Icon(
                          Icons.more_vert,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdatePhilosopherScreen(
                                      documentId: document.id,
                                      initialTitle: data['title'],
                                      initialSubtitle: data['subtitle'],
                                    ),
                                  ),
                                );
                              },
                              leading: const Icon(Icons.edit),
                              title: const Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                philosphersRef
                                    .doc(document.id)
                                    .delete()
                                    .then((value) {
                                  Utils.showMessage(
                                      context: context,
                                      title: 'Deleted successfully',
                                      message: ' ');
                                }).catchError((error) {
                                  Utils.showMessage(
                                      context: context,
                                      title: 'Failed to delete',
                                      message: error.toString());
                                });
                              },
                              leading: const Icon(Icons.delete_outline),
                              title: const Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                      title: Text(data['title'].toString()),
                      subtitle: Text(data['subtitle']),
                      onTap: () {},
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPhilospher(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
