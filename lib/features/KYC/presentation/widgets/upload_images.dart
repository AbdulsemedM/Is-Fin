import 'package:flutter/material.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({super.key});

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Upload the following files"),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Personal and Business Info."),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 1,
                )),
              ],
            ),
            const Row(
              children: [
                Text(
                  'Renewed Id.',
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
            SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Renewed Trade License',
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
            SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Commercial Registration Certificate',
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
            SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Tin No. (Applicant\'s)',
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
          ],
        ),
      ),
    );
  }
}
