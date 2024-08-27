import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, this.title, required this.onPressed, this.margin})
      : super(key: key);

  final title;
  final VoidCallback onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 44)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(44 / 2)),
          ),
          backgroundColor:
              WidgetStateProperty.all(Theme.of(context).primaryColor)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}
