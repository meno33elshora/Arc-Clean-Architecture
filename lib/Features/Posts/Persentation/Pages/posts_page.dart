import 'package:arc/Core/Utils/color.dart';
import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:arc/Features/Posts/Persentation/Bloc/posts_bloc.dart';
import 'package:arc/Features/Posts/Persentation/Pages/crud_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Widget/loading_widget.dart';
import '../Components/message_display_widget.dart';
import '../Components/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CrudPage(
                    isUpdatePost: false,
                  )));
        },
        backgroundColor: ColorManager.primaryColor,
        child: const Icon(
          Icons.add,
          color: ColorManager.greenLight,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is LoadingPostsState) {
                return const LoadingWidget();
              } else if (state is LoadedPostsState) {
                return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: PostsListWidget(posts: state.posts));
              } else if (state is ErrorPostsState) {
                return MessageDisplayWidget(message: state.error);
              }
              return const LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}

Future<void> _onRefresh(context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvents());
}
