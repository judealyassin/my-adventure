import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const PostPage(this.data, {super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      _imageController.text = widget.data!["image"];
      _descriptionController.text = widget.data!["description"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data != null ? "Edit post" : "Add post"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
                maxLines: 2,
                controller: _imageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Image Link"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                maxLines: 2,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Description"),
                )),
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "image": _imageController.text,
                      "description": _descriptionController.text,
                      "dateTime": DateTime.now(),
                      "owner": FirebaseAuth.instance.currentUser!.email
                    };
                    if (widget.data != null) {
                      FirebaseFirestore.instance
                          .collection("Posts")
                          .doc(widget.data!["id"])
                          .update(data);
                      //Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Post Edited Successfully"),
                        duration: Duration(milliseconds: 3000),
                      ));
                    } else {
                      FirebaseFirestore.instance
                          .collection("Posts")
                          .doc()
                          .set(data);

                      setState(() {
                        _imageController.clear();
                        _descriptionController.clear();
                      });
                    }
                    Navigator.of(context).pop();
                    if (widget.data == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Post Added Successfully"),
                        duration: Duration(milliseconds: 3000),
                      ));
                    }
                  },
                  child: Text(widget.data != null ? "Edit" : "Post"))),
        ],
      ),
    );
  }
}
