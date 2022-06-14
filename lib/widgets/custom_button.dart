import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const CustomButton({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ElevatedButton(
        onPressed: onTap,
        child: new Container(
          margin: EdgeInsets.all(16),
          child: new Text(
            text,
            style: new TextStyle(fontSize: 16),
          ),
        ));
  }
}
