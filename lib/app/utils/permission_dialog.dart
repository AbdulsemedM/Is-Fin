import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class PermissionDialog {
  static Future<bool> requestCameraPermission(BuildContext context) async {
    bool hasPermission = await Permission.camera.status.isGranted;

    if (hasPermission) return true;

    if (await Permission.camera.isPermanentlyDenied) {
      // Show dialog to open settings
      return _showSettingsDialog(
        context,
        'Camera Access Required',
        'Please enable camera access in settings to take photos.',
      );
    }

    bool? showRationale = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Camera Permission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryDarkColor.withOpacity(0.1),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 40,
                color: AppColors.primaryDarkColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We need camera access to take photos for your profile and documents.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Not Now',
              style: TextStyle(color: AppColors.iconColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Allow Access',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (showRationale == true) {
      final status = await Permission.camera.request();
      return status.isGranted;
    }

    return false;
  }

  static Future<bool> requestGalleryPermission(BuildContext context) async {
    bool hasPermission = await Permission.storage.status.isGranted;

    if (hasPermission) return true;

    if (await Permission.storage.isPermanentlyDenied) {
      return _showSettingsDialog(
        context,
        'Gallery Access Required',
        'Please enable gallery access in settings to select photos.',
      );
    }

    bool? showRationale = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Gallery Permission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryDarkColor.withOpacity(0.1),
              ),
              child: Icon(
                Icons.photo_library,
                size: 40,
                color: AppColors.primaryDarkColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We need gallery access to select photos for your profile and documents.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Not Now',
              style: TextStyle(color: AppColors.iconColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Allow Access',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (showRationale == true) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }

    return false;
  }

  static Future<bool> _showSettingsDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    bool? openSettings = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.iconColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Open Settings',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (openSettings == true) {
      await openAppSettings();
      // Check if permission was granted in settings
      if (title.contains('Camera')) {
        return await Permission.camera.status.isGranted;
      } else {
        return await Permission.storage.status.isGranted;
      }
    }

    return false;
  }
}
