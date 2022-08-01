/* Developed by: Eng. Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  const MyPixel({Key? key, this.child, this.innerColor, this.outerColor}) : super(key: key);

  final Color? innerColor;
  final Color? outerColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: outerColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: innerColor,
                child: Center(child: child)),
          ),
        ),
      ),
    );
  }
}
