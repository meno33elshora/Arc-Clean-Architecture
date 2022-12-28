import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:flutter/material.dart';
import '../Pages/crud_page.dart';

class UpdateBtn extends StatelessWidget {
  final Posts posts;
  const UpdateBtn({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CrudPage(
                isUpdatePost: true,
                posts: posts,
              )));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit"));
  }
}
