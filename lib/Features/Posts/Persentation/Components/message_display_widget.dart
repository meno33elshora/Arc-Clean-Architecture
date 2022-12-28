import 'package:flutter/material.dart';

import '../../../../Core/Utils/color.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message ;
  const MessageDisplayWidget({Key? key , required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: Center(
        child: SingleChildScrollView(
          child:  Text(
            message,
            style: const TextStyle(
              fontSize: 18.0,
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
