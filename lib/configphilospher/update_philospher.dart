import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/provider/update_provider.dart';
import 'package:motivated_admin/reusablewidgets/neomorphism_loading_button.dart';
import 'package:motivated_admin/reusablewidgets/title_text_field.dart';
import 'package:motivated_admin/theme/theme_data.dart';
import 'package:motivated_admin/utils/utils.dart';
import 'package:provider/provider.dart';

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
  State<UpdatePhilosopherScreen> createState() =>
      _UpdatePhilosopherScreenState();
}

class _UpdatePhilosopherScreenState extends State<UpdatePhilosopherScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode subtitleFocusNode = FocusNode();

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
    titleFocusNode.dispose();
    subtitleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.hintColor,
        title: Text(
          'Update Philospher',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ReusableTextField(
                currentFocusNode: titleFocusNode,
                controller: _titleController,
                hintAndLabelText: 'Title',
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, titleFocusNode, subtitleFocusNode);
                }),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
              currentFocusNode: subtitleFocusNode,
              controller: _titleController,
              hintAndLabelText: 'Subtitle',
            ),
            const SizedBox(height: 40),
            Consumer<UpdateProvider>(
              builder: (BuildContext context, provider, Widget? child) {
                return NeomorphismLoadingButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      provider.setLoading(true);
                      FirebaseFirestore.instance
                          .collection('philosphers')
                          .doc(widget.documentId)
                          .update({
                        'title': _titleController.text,
                        'subtitle': _subtitleController.text,
                      }).then((value) {
                        provider.setLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Updated successfully')));
                        Navigator.pop(context);
                      }).catchError((error) {
                        provider.setLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to update: $error')));
                      });
                    }
                  },
                  title: 'Update Philospher',
                  toggleElevation: provider.isLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
