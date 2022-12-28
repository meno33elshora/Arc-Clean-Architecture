import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelTitle;
  final bool multiLine;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.multiLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val!.isEmpty) {
            return "$labelTitle is Empty";
          }
          return null;
        },
        keyboardType: TextInputType.text,
        maxLines:multiLine ? 6 : 1,
        minLines:multiLine ? 6 : 1,
        decoration: InputDecoration(
          hintText: labelTitle,
        ),
      ),
    );
  }
}
