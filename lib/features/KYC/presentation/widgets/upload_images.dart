import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
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
    setState(() {
      existsRenewedId = prefs.getString('images_info_renewedId_$phone');
      existsRegCertificate = prefs
          .getString('images_info_commercialRegistrationCertificate_$phone');
      existsTinNumber = prefs.getString('images_info_tinNumber_$phone');
      existsTradeLicense =
          prefs.getString('images_info_renewedTradeLicense_$phone');
    });
    if (mounted &&
        existsRenewedId == null &&
        existsRegCertificate == null &&
        existsTinNumber == null &&
        existsTradeLicense == null) {
      context.read<KycBloc>().add(ImagesKYCFetched());
    }
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
      displaySnack(context, "Please upload at least one image.".tr, Colors.red);

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
      displaySnack(context, "Images sent successfully!".tr, Colors.black);
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
          context.read<KycBloc>().add(KYCStatusFetched());
          setState(() {
            loading = false;
          });
          displaySnack(context, "Images sent successfully!".tr, Colors.black);
        } else if (state is KycImagesSentFailure) {
          setState(() {
            loading = false;
          });
          displaySnack(context, state.errorMessage, Colors.red);
        } else if (state is KycIMagesFetchedLoading) {
          setState(() {
            loading = true;
          });
        } else if (state is KycIMagesFetchedSuccess) {
          setState(() {
            ImagesModel images = state.imagesInfo;
            existsRenewedId =
                (images.renewedId?.isNotEmpty ?? false) ? "Done" : null;

            existsTinNumber =
                (images.tinNumber?.isNotEmpty ?? false) ? "Done" : null;

            existsRegCertificate =
                (images.commercialRegistrationCertificateFileName?.isNotEmpty ??
                        false)
                    ? "Done"
                    : null;

            existsTradeLicense =
                (images.renewedTradeLicense?.isNotEmpty ?? false)
                    ? "Done"
                    : null;
            loading = false;
          });
          // displaySnack(context, "Images sent successfully!", Colors.black);
        } else if (state is KycIMagesFetchedFailure) {
          setState(() {
            loading = false;
          });
          displaySnack(context, state.errorMessage, Colors.red);
        }
      },
      child: BlocBuilder<UserTypeCubit, UserType>(
        builder: (context, userType) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    userType == UserType.provider
                        ? "Provider Upload Files"
                        : "Customer Upload Files",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("Upload the following files".tr),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Personal and Business Info.".tr),
                      ),
                      const Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                    ],
                  ),
                  ..._buildImageSection(
                    existsRenewedId == null
                        ? 'Renewed Id.'.tr
                        : 'Renewed Id.(Sent)'.tr,
                    _idImageName,
                    'id',
                  ),
                  ..._buildImageSection(
                    existsTinNumber == null
                        ? 'Id. Back Page (Optional)'.tr
                        : 'Id. Back Page (Optional)(Sent)'.tr,
                    _tinImageName,
                    'tin',
                  ),
                  ..._buildImageSection(
                    existsTradeLicense == null
                        ? 'Renewed Trade License'.tr
                        : "Renewed Trade License(Sent)".tr,
                    _tradeLicenseImageName,
                    'tradeLicense', // Fix: Change from 'license' to 'tradeLicense'
                  ),
                  ..._buildImageSection(
                    existsRegCertificate == null
                        ? 'Commercial Registration Certificate'.tr
                        : 'Commercial Registration Certificate(Sent)'.tr,
                    _registrationCertImageName,
                    'registrationCert', // Fix: Ensure the key matches getBase64StringByType
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
                            : Text(
                                "Submit".tr,
                                style: const TextStyle(color: Colors.white),
                              )),
                  ),
                ],
              ),
            ),
          );
        },
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
        Row(
          children: [
            Text(
              'Selected: '.tr,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              imageName,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
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
