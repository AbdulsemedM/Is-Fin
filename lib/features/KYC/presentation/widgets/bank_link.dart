import 'package:flutter/material.dart';

class BankLink extends StatefulWidget {
  const BankLink({super.key});

  @override
  State<BankLink> createState() => _BankLinkState();
}

class _BankLinkState extends State<BankLink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text("Bank Link")],
      ),
    );
  }
}
