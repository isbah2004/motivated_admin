import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomAnimatedText extends StatelessWidget {
  final String title;
  final Color firstColor, secondColor;
  const CustomAnimatedText(
      {super.key,
      required this.title,
      required this.firstColor,
      required this.secondColor});

  @override
  Widget build(BuildContext context) {
    List<Color> colorizeNewColors = [
      firstColor,
      secondColor,
    ];

    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          title,
          textStyle:
              Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 40),
          colors: colorizeNewColors,
        ),
      ],
    );
  }
}