import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:arc/Features/Posts/Persentation/Components/update_btn.dart';
import 'package:flutter/material.dart';
import 'delete_post_btn.dart';

class PostDetailWidget extends StatelessWidget {
  final Posts posts;

  const PostDetailWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            posts.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            posts.body,
            style: const TextStyle(fontSize: 18.0),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UpdateBtn(
                posts: posts,
              ),
              DeletePostBtn(postId: posts.id!),
            ],
          ),
        ],
      ),
    );
  }
}
