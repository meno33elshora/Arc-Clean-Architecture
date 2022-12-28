import 'package:arc/Core/Utils/color.dart';
import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:arc/Features/Posts/Persentation/Components/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/crud/crud_bloc.dart';
import 'btn_submit.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Posts? posts;

  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.posts,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final controllerTitle = TextEditingController();
  final controllerBody = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      controllerTitle.text = widget.posts!.title;
      controllerBody.text = widget.posts!.body;
    }
    super.initState();
  }

  void validateCrud() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final posts = Posts(
        id: widget.isUpdatePost ? widget.posts!.id : null,
        title: controllerTitle.text,
        body: controllerBody.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<CrudBloc>(context).add(UpdatePostEvent(posts: posts));
      } else {
        BlocProvider.of<CrudBloc>(context).add(AddPostEvent(posts: posts));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextFormField for title
            TextFormFieldWidget(
              controller: controllerTitle,
              labelTitle: 'Title',
              multiLine: false,
            ),
            // TextFormField for body
            TextFormFieldWidget(
              controller: controllerBody,
              labelTitle: 'Body',
              multiLine: true,
            ),
            // btn (add or update)
            BtnSubmit(
                isUpdatePost: widget.isUpdatePost, onPressed: validateCrud),
          ],
        ),
      ),
    );
  }
}
