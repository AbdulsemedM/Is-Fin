// colored_containers.dart
import 'package:flutter/material.dart';

class ColoredContainers extends StatelessWidget {
  final Color myColor;
  final String myTitle;
  final String myDesc;

  // Constructor to accept the list of colors
  const ColoredContainers(
      {Key? key,
      required this.myColor,
      required this.myTitle,
      required this.myDesc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8), // Add space between containers
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: myColor,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          myTitle,
          style: const TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  // return Column(
  //   children: valuesWidget,
  // );
}
