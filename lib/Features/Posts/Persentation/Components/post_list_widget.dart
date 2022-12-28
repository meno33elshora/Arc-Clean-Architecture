import 'package:arc/Core/Utils/color.dart';
import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:arc/Features/Posts/Persentation/Pages/detail_post.dart';
import 'package:flutter/material.dart';

class PostsListWidget extends StatelessWidget {
  final List<Posts> posts;

  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(
              fontSize: 20.0,
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(
              fontSize: 18.0,
              color: ColorManager.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPost(posts: posts[index])));
          },
        );
      },

      separatorBuilder: (context, index) => const Divider(),
      itemCount: posts.length,
    );
  }
}
