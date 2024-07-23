import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/provider/home_providers.dart';
import 'package:motivated_admin/reusablewidgets/neomorphism_loading_button.dart';
import 'package:motivated_admin/theme/theme_data.dart';
import 'package:motivated_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class AddConcept extends StatefulWidget {
  final String name;
  const AddConcept({super.key, required this.name});

  @override
  State<AddConcept> createState() => _AddConceptState();
}

class _AddConceptState extends State<AddConcept> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final addConcept = FirebaseFirestore.instance;
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode subtitleFocusNode = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    titleFocusNode.dispose();
    subtitleFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.hintColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.hintColor,
        title: Text(
          'Add Concept',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              focusNode: titleFocusNode,
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'name',
                labelText: 'name',
                fillColor: AppTheme.textFieldFilledColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, titleFocusNode, subtitleFocusNode);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              focusNode: subtitleFocusNode,
              controller: subTitleController,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Concept',
                labelText: 'Concept',
                fillColor: AppTheme.textFieldFilledColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Consumer<AddPhilospherProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              return NeomorphismLoadingButton(
                  title: 'Add Concept',
                  onTap: () {
                    provider.setLoading(true);

                    addConcept.collection(widget.name.toString()).add({
                      'name': titleController.text.toString(),
                      'concept': subTitleController.text.toString(),
                      'id': DateTime.now().millisecondsSinceEpoch.toString()
                    }).then((value) {
                      Navigator.pop(context);
                      provider.setLoading(false);
                      Utils.showMessage(
                          context: context,
                          title: 'Concept successfully added',
                          message: ' ');
                    }).onError((error, stackTrace) {
                      Utils.showMessage(
                          context: context,
                          title: 'Error',
                          message: error.toString());
                      provider.setLoading(false);
                    });
                  },
                  toggleElevation: provider.isLoading);
            },
          )
        ],
      ),
    );
  }
}
