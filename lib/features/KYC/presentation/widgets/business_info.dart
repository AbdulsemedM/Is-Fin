import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Complete all the fields below"),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Business Name',
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
                    labelText: 'Website url (optional)',
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
                    labelText: 'Business Address',
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
                    labelText: 'Business Type',
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
          Row(
            children: [
              Text(
                'Add Business License',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
          // const Spacer(),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Add Shop Image',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
          // const Spacer(),
          MyButton(
              backgroundColor:
                  loading ? AppColors.iconColor : AppColors.primaryDarkColor,
              onPressed: loading
                  ? () {}
                  : () {
                      setState(() {
                        loading = true;
                      });
                    },
              buttonText: loading
                  ? SizedBox(
                      height: ScreenConfig.screenHeight * 0.02,
                      width: ScreenConfig.screenHeight * 0.02,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    )),
        ],
      ),
    );
  }
}
