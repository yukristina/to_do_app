import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      color: Theme.of(context).primaryColor,
      );
  }
}
