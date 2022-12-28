import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:flutter/material.dart';
import '../Components/post_detail_widget.dart';

class DetailPost extends StatelessWidget {
  final Posts posts;

  const DetailPost({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
        centerTitle: true,
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PostDetailWidget(posts: posts,),
        ),
      ),
    );
  }
}
