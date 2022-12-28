import 'package:flutter/material.dart';

class BtnSubmit extends StatelessWidget {
  final Function () onPressed ;
  final bool isUpdatePost;

  const BtnSubmit({Key? key,required this.onPressed,required this.isUpdatePost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdatePost
            ? const Icon(Icons.edit)
            : const Icon(Icons.add),
        label:
        isUpdatePost ? const Text("Update") : const Text("Add"));
  }
}
