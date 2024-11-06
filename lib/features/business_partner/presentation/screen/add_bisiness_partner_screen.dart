import 'package:flutter/material.dart';

class AddBisinessPartnerScreen extends StatefulWidget {
  const AddBisinessPartnerScreen({super.key});

  @override
  State<AddBisinessPartnerScreen> createState() =>
      _AddBisinessPartnerScreenState();
}

class _AddBisinessPartnerScreenState extends State<AddBisinessPartnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Business Partner",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
