import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({super.key});

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  var loading = false;

  String? _idImageBase64;
  // String? _licenseImageBase64;
  String? _tradeLicenseImageBase64;
  String? _registrationCertImageBase64;
  String? _tinImageBase64;

  String? _idImageName;
  // String? _licenseImageName;
  String? _tradeLicenseImageName;
  String? _registrationCertImageName;
  String? _tinImageName;

  String? existsRenewedId;
  String? existsTradeLicense;
  String? existsRegCertificate;
  String? existsTinNumber;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    intializeFields();
  }

  void intializeFields() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the JSON string
    PhoneNumberManager phoneManager = PhoneNumberManager();
    String? phone = await phoneManager.getPhoneNumber();
    print(phone);
    setState(() {
      existsRenewedId = prefs.getString('images_info_renewedId_$phone');
      existsRegCertificate = prefs
          .getString('images_info_commercialRegistrationCertificate_$phone');
      existsTinNumber = prefs.getString('images_info_tinNumber_$phone');
      existsTradeLicense =
          prefs.getString('images_info_renewedTradeLicense_$phone');
    });
    print("here are the images");
    print(existsRenewedId);
    print(existsRegCertificate);
    print(existsTinNumber);
  }

  // Method to pick image from gallery
  Future<void> _pickImageFromGallery(String imageType) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _encodeImageToBase64(image, imageType);
    }
  }

  // Method to pick image from camera
  Future<void> _pickImageFromCamera(String imageType) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _encodeImageToBase64(image, imageType);
    }
  }

  // Method to encode image to base64 and store the file name
  void _encodeImageToBase64(XFile image, String imageType) async {
    File file = File(image.path);
    List<int> bytes = await file.readAsBytes();
    String base64String = base64Encode(bytes);

    setState(() {
      switch (imageType) {
        case 'id':
          _idImageBase64 = base64String;
          _idImageName = image.name;
          break;
        case 'tradeLicense':
          _tradeLicenseImageBase64 = base64String;
          _tradeLicenseImageName = image.name;
          break;
        case 'registrationCert':
          _registrationCertImageBase64 = base64String;
          _registrationCertImageName = image.name;
          break;
        case 'tin':
          _tinImageBase64 = base64String;
          _tinImageName = image.name;
          break;
      }
    });
  }

  // Method to handle form submission
  void _submitForm() {
    if (loading) return;

    // Check if at least one image is selected
    if (_idImageBase64 == null &&
        // _licenseImageBase64 == null &&
        _tradeLicenseImageBase64 == null &&
        _registrationCertImageBase64 == null &&
        _tinImageBase64 == null) {
      displaySnack(context, "Please upload at least one image.", Colors.red);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("Please upload at least one image."),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      return;
    }

    context.read<KycBloc>().add(ImagesKYCSent(
        imagesInfo: ImagesModel(
            renewedId: _idImageBase64,
            renewedIdFileName: _idImageName,
            renewedTradeLicense: _tradeLicenseImageBase64,
            renewedTradeLicenseFileName: _tradeLicenseImageName,
            commercialRegistrationCertificate: _registrationCertImageBase64,
            commercialRegistrationCertificateFileName:
                _registrationCertImageName,
            tinNumber: _tinImageBase64,
            tinNumberFileName: _tinImageName)));

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Images sent successfully!")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycBloc, KycState>(
      listener: (context, state) {
        if (state is KycImagesSentLoading) {
          setState(() {
            loading = true;
          });
        } else if (state is KycImagesSentSuccess) {
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Images sent successfully!")));
        } else if (state is KycImagesSentFailure) {
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Upload the following files"),
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Personal and Business Info."),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  )),
                ],
              ),
              ..._buildImageSection(
                existsRenewedId != null ? 'Renewed Id.' : 'Renewed Id.(Sent)',
                _idImageName,
                'id',
              ),
              ..._buildImageSection(
                existsTradeLicense != null
                    ? 'Renewed Trade License'
                    : "Renewed Trade License(Sent)",
                _tradeLicenseImageName,
                'tradeLicense', // Fix: Change from 'license' to 'tradeLicense'
              ),
              ..._buildImageSection(
                existsRegCertificate != null
                    ? 'Commercial Registration Certificate'
                    : 'Commercial Registration Certificate(Sent)',
                _registrationCertImageName,
                'registrationCert', // Fix: Ensure the key matches getBase64StringByType
              ),
              ..._buildImageSection(
                existsTinNumber != null
                    ? 'TIN No. (Applicant\'s)'
                    : 'TIN No. (Applicant\'s)(Sent)',
                _tinImageName,
                'tin',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading ? () {} : _submitForm,
                    buttonText: loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the image selection sections
  List<Widget> _buildImageSection(
    String title,
    String? imageName,
    String imageType,
  ) {
    return [
      Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (imageName != null)
            Row(
              children: [
                Image.memory(
                  base64Decode(getBase64StringByType(imageType)),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.photo, size: 30),
                  onPressed: () => _pickImageFromGallery(imageType),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 30),
                  onPressed: () => _pickImageFromCamera(imageType),
                ),
              ],
            )
          else
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo, size: 40),
                  onPressed: () => _pickImageFromGallery(imageType),
                ),
                const SizedBox(width: 32),
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 40),
                  onPressed: () => _pickImageFromCamera(imageType),
                ),
              ],
            ),
        ],
      ),
      if (imageName != null)
        Text(
          'Selected: $imageName',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      const SizedBox(height: 16),
    ];
  }

// Helper method to get the base64 string by image type
  String getBase64StringByType(String imageType) {
    switch (imageType) {
      case 'id':
        return _idImageBase64 ?? '';
      case 'tradeLicense':
        return _tradeLicenseImageBase64 ?? '';
      case 'registrationCert':
        return _registrationCertImageBase64 ?? '';
      case 'tin':
        return _tinImageBase64 ?? '';
      default:
        return '';
    }
  }
}
