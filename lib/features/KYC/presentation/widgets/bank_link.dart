import 'package:flutter/material.dart';

class BankLink extends StatefulWidget {
  const BankLink({super.key});

  @override
  State<BankLink> createState() => _BankLinkState();
}

class _BankLinkState extends State<BankLink> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tin Number',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Id. Type',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Driver\'s License',
                    child: Text('Driver\'s License'),
                  ),
                  DropdownMenuItem(
                    value: 'Passport',
                    child: Text('Passport'),
                  ),
                  DropdownMenuItem(
                    value: 'National ID',
                    child: Text('National ID'),
                  ),
                ],
                onChanged: (value) {
                  // Handle value change
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Select Id. from gallery or capture',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.photo, size: 40),
              onPressed: () {
                // Implement gallery selection
              },
            ),
            const SizedBox(width: 32),
            IconButton(
              icon: Icon(Icons.camera_alt, size: 40),
              onPressed: () {
                // Implement camera capture
              },
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
