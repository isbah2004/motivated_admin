import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/provider/home_providers.dart';
import 'package:motivated_admin/reusablewidgets/neomorphism_loading_button.dart';
import 'package:motivated_admin/theme/theme_data.dart';
import 'package:motivated_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPhilospher extends StatefulWidget {
  const AddPhilospher({super.key});

  @override
  State<AddPhilospher> createState() => _AddPhilospherState();
}

class _AddPhilospherState extends State<AddPhilospher> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final addPhilospher = FirebaseFirestore.instance;
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
          'Add Philospher',
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
              decoration: InputDecoration(hintText: 'Title',labelText: 'Title',
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
              decoration: InputDecoration(hintText: 'Subtitle',labelText: 'Subtitle',
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
                  title: 'Add Philospher',
                  onTap: () {
                    provider.setLoading(true);

                    addPhilospher.collection('philosphers').add({
                      'title': titleController.text.toString(),
                      'subtitle': subTitleController.text.toString(),
                      'id': DateTime.now().millisecondsSinceEpoch.toString()
                    }).then((value) {
                      
                      Utils.showMessage(
                          context: context,
                          title: 'Philospher successfully added',
                          message: ' ');
                      provider.setLoading(false);
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
