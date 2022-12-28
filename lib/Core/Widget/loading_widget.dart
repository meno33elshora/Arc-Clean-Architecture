import 'package:arc/Core/Utils/color.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 30.0,
        width: 30.0,
        child: Center(
          child: CircularProgressIndicator(
            color: ColorManager.greenLight,
          ),
        ),
      ),
    );
  }
}
