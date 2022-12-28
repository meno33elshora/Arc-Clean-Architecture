import 'package:arc/Core/Utils/snackbar_message.dart';
import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:arc/Features/Posts/Persentation/Bloc/crud/crud_bloc.dart';
import 'package:arc/Features/Posts/Persentation/Pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Components/form_widget.dart';

class CrudPage extends StatelessWidget {
  final Posts? posts;
  final bool isUpdatePost;

  const CrudPage({
    Key? key,
    this.posts,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<CrudBloc, CrudState>(
            listener: (context, state) {
              if (state is MessageCrudState) {
                snackBarMessage(context, state.message, Colors.green);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const PostsPage()),
                    (route) => false);
              } else if (state is ErrorCrudState) {
                snackBarMessage(context, state.error, Colors.red);
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(builder: (context) => const PostsPage()),
                //     (route) => false);
              }
            },
            builder: (context, state) {
              if (state is LoadingCrudState) {}
              return FormWidget(
                isUpdatePost: isUpdatePost,
                posts: isUpdatePost ? posts : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
