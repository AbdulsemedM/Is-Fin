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
  final TextEditingController _yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                    child: Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Business Info."),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1,
                )),
              ],
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
                      labelText: 'Tin No.',
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
                Expanded(
                  child: TextFormField(
                    readOnly: true, // Makes the field non-editable
                    decoration: InputDecoration(
                      labelText: 'Year of Establishment',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon:
                          Icon(Icons.calendar_today), // Adds a calendar icon
                    ),
                    controller:
                        _yearController, // Controller for the selected year
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900), // Earliest selectable year
                        lastDate: DateTime.now(), // Latest selectable year
                        initialDatePickerMode:
                            DatePickerMode.year, // Opens in year selection
                      );
                      if (pickedDate != null) {
                        // Update the controller with the selected year
                        _yearController.text = pickedDate.year.toString();
                        print(_yearController.text);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Ownership',
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
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Finance Source',
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
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Type of Business',
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
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Starting Capital',
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
                      labelText: 'Current Capital',
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
                      labelText: 'Starting Employee No.',
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
                      labelText: 'Current Employee No.',
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
                      labelText: 'Monthly Sales(ETB)',
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
                      labelText: 'Monthly Revenue(ETB)',
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
                    child: Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Business Address Info."),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Region',
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
                      labelText: 'Zone',
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
                      labelText: 'Woreda',
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
                      labelText: 'Kebele',
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
            // Row(
            //   children: [
            //     Text(
            //       'Add Business License',
            //       style: TextStyle(fontSize: 16),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.photo, size: 40),
            //       onPressed: () {
            //         // Implement gallery selection
            //       },
            //     ),
            //     const SizedBox(width: 32),
            //     IconButton(
            //       icon: Icon(Icons.camera_alt, size: 40),
            //       onPressed: () {
            //         // Implement camera capture
            //       },
            //     ),
            //   ],
            // ),
            // // const Spacer(),
            // const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Text(
            //       'Add Shop Image',
            //       style: TextStyle(fontSize: 16),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.photo, size: 40),
            //       onPressed: () {
            //         // Implement gallery selection
            //       },
            //     ),
            //     const SizedBox(width: 32),
            //     IconButton(
            //       icon: Icon(Icons.camera_alt, size: 40),
            //       onPressed: () {
            //         // Implement camera capture
            //       },
            //     ),
            //   ],
            // ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
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
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
