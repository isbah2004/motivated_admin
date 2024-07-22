import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/addphilospher/add_philospher.dart';

class PhilosphyTab extends StatefulWidget {
  const PhilosphyTab({super.key});

  @override
  State<PhilosphyTab> createState() => _PhilosphyTabState();
}

class _PhilosphyTabState extends State<PhilosphyTab> {
  final fireStore =
      FirebaseFirestore.instance.collection('philosphers').snapshots();

  CollectionReference philosphersRef =
      FirebaseFirestore.instance.collection('Philosphers');
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
                      trailing:PopupMenuButton(
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
                                child: PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);

                                      philosphersRef
                                          .doc(snapshot
                                              .child('id')
                                              .value
                                              .toString())
                                          .update({'title': 'nice world'})
                                          .then((value) {})
                                          .onError((error, stackTrace) {
                                            Utils()
                                                .toastMessage(error.toString());
                                          });
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);

                                    // ref.child(snapshot.child('id').value.toString()).update(
                                    //     {
                                    //       'ttitle' : 'hello world'
                                    //     }).then((value){
                                    //
                                    // }).onError((error, stackTrace){
                                    //   Utils().toastMessage(error.toString());
                                    // });
                                    ref
                                        .child(snapshot
                                            .child('id')
                                            .value
                                            .toString())
                                        .remove()
                                        .then((value) {})
                                        .onError((error, stackTrace) {
                                      Utils().toastMessage(error.toString());
                                    });
                                  },
                                  leading: const Icon(Icons.delete_outline),
                                  title: const Text('Delete'),
                                ),
                              ),
                            ]),
                  
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
