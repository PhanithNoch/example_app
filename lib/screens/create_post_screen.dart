import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePostScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var snackBar = SnackBar(
    content: Text('Created successfully.'),
  );
  var snackBarErr = SnackBar(
    content: Text('Created failed.'),
  );
  void createPost(String title, String author, context) async {
    Map<String, String> bodyRequest = {'title': title, 'author': author};
    var url = Uri.parse('http://localhost:3000/posts');
    var response = await http.post(url, body: bodyRequest);
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      clearText();
      print('created successfully.');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBarErr);

      print('created failed.');
    }
  }

  void clearText() {
    titleController.text = '';
    bodyController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: bodyController,
                decoration: const InputDecoration(hintText: 'Body'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            String title = titleController.text;
                            String author = bodyController.text;
                            print('title $title');
                            print('body $author');
                            if (_formKey.currentState!.validate()) {
                              createPost(title, author, context);
                            }
                          },
                          child: const Text('Save')))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
