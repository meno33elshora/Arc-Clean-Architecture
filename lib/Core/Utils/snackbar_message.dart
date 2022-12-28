import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarMessage(context , String state , Color color){
  return   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        state,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
    ),
  );
}