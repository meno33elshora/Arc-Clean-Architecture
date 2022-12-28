import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Utils/snackbar_message.dart';
import '../../../../Core/Widget/loading_widget.dart';
import '../Bloc/crud/crud_bloc.dart';
import '../Pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtn extends StatelessWidget {
  final int postId;
  // final Function() onPressed;
  const DeletePostBtn({Key? key , required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red)),
        onPressed: ()=> deleteDialog(context, postId),
        icon: const Icon(Icons.delete),
        label: const Text("Delete"));
  }

  void deleteDialog(context , int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return  BlocConsumer<CrudBloc, CrudState>(
            listener: (context, state) {
              if (state is MessageCrudState) {
                snackBarMessage(context, state.message, Colors.green);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const PostsPage()),
                        (route) => false);
              } else if (state is ErrorCrudState) {
                Navigator.of(context).pop();
                snackBarMessage(context, state.error, Colors.red);
              }
            },
            builder: (context, state) {
              if(state is LoadingCrudState){
                return const AlertDialog(
                  title: Center(child: LoadingWidget()),
                );
              }
              return DeleteDialogWidget(postId : postId);
            },
          );
        });
  }

}
