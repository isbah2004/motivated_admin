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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Deleted successfully')));
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to delete: $error')));
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

class UpdatePhilosopherScreen extends StatefulWidget {
  final String documentId;
  final String initialTitle;
  final String initialSubtitle;

  const UpdatePhilosopherScreen({
    super.key,
    required this.documentId,
    required this.initialTitle,
    required this.initialSubtitle,
  });

  @override
  _UpdatePhilosopherScreenState createState() =>
      _UpdatePhilosopherScreenState();
}

class _UpdatePhilosopherScreenState extends State<UpdatePhilosopherScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _subtitleController = TextEditingController(text: widget.initialSubtitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Philosopher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subtitleController,
                decoration: const InputDecoration(labelText: 'Subtitle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subtitle';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection('Philosphers')
                        .doc(widget.documentId)
                        .update({
                      'title': _titleController.text,
                      'subtitle': _subtitleController.text,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Updated successfully')));
                      Navigator.pop(context);
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update: $error')));
                    });
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
