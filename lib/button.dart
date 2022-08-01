/* Developed by: Eng. Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, this.color, this.child, this.function}) : super(key: key);

  final Color? color;
  final Widget? child;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: color,
            height: 70,
            width: 70,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
