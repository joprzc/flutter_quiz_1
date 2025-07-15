import 'package:flutter/material.dart';

// clase para llamar las respuestas
class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.text, required this.onTap});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    //return ElevatedButton(onPressed: () {}, child: Text(data));
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
