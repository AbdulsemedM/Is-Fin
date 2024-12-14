import 'package:flutter/material.dart';

class ProviderAccountWidget extends StatefulWidget {
  const ProviderAccountWidget({super.key});

  @override
  State<ProviderAccountWidget> createState() => _ProviderAccountWidgetState();
}

class _ProviderAccountWidgetState extends State<ProviderAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "data",
          style: TextStyle(color: const Color.fromARGB(255, 11, 49, 19)),
        ),
      ),
    );
  }
}
