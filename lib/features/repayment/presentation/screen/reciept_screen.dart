import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

// import 'package:app_settings/app_settings.dart';
class ReceiptPage extends StatefulWidget {
  final String transactionId;
  final String customerName;
  final double amount;

  const ReceiptPage({
    super.key,
    required this.transactionId,
    required this.customerName,
    required this.amount,
  });

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final _screenshotController = ScreenshotController();
  final DateTime _date = DateTime.now();
  final currencyFormat = NumberFormat.currency(symbol: '\$');

  Future<void> _saveToGallery() async {
    try {
      // Request photos permission for Android 13+ and storage permission for older versions
      final Permission permission = Platform.isAndroid &&
              await DeviceInfoPlugin()
                      .androidInfo
                      .then((info) => info.version.sdkInt) >=
                  33
          ? Permission.photos
          : Permission.storage;

      final status = await permission.request();

      if (status.isGranted) {
        // Capture receipt as image
        final Uint8List? imageBytes = await _screenshotController.capture();

        if (imageBytes != null) {
          // Save to gallery using image_gallery_saver_plus
          final result = await ImageGallerySaverPlus.saveImage(
            imageBytes,
            name: 'Receipt_${widget.transactionId}',
            quality: 100,
            isReturnImagePathOfIOS: true,
          );

          // Check if the save was successful by verifying the result map
          if (result != null && result['isSuccess'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Receipt saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            throw Exception('Failed to save image');
          }
        }
      } else if (status.isPermanentlyDenied) {
        // Guide user to app settings if permission is permanently denied
        await openAppSettings();
      } else {
        throw Exception('Permission denied');
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save receipt: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Receipt',
            style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Screenshot(
              controller: _screenshotController,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bank Logo
                    Center(
                      child: Image.asset(
                        'assets/images/mizan1.png',
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Transaction Receipt',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 2),
                    _buildReceiptRow('Transaction ID:', widget.transactionId),
                    _buildReceiptRow('Customer Name:', widget.customerName),
                    _buildReceiptRow('Amount:', ("ETB ${widget.amount}")),
                    _buildReceiptRow(
                        'Date:', DateFormat('dd/MM/yyyy HH:mm').format(_date)),
                    const Divider(thickness: 2),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(
                            8.0), // Add padding inside the rectangle
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.5), // Border color and width
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Rounded corners
                          color: Colors.white, // Optional: Background color
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/images/coop.png', height: 30),
                            const SizedBox(width: 10),
                            const Text('Bank Smarter, Live Better'),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Thank you for your business!',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
                width: ScreenConfig.screenWidth * 0.7,
                backgroundColor: AppColors.primaryColor,
                onPressed: _saveToGallery,
                buttonText: Text('Save to Gallery',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white))),
            const SizedBox(height: 20),
            // ElevatedButton.icon(
            //   onPressed: _saveToGallery,
            //   icon: Icon(Icons.download),
            //   label: Text('Save to Gallery'),
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),
          ),
          Text(value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor))
        ],
      ),
    );
  }
}
