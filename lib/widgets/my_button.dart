import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

class MyButton extends StatelessWidget {
  MyButton({required this.text, required this.onPressed});

  final String text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: defaultColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: titleStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
