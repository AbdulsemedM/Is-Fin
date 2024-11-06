import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
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
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Select Id. from gallery or capture',
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
          const Spacer(),
        ],
      ),
    );
  }
}
