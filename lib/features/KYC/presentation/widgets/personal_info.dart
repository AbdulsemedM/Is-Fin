import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/address_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/alternative_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/spouse_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  var loading = false;
  var loadValues = false;
  var zoneFetched = false;
  List<RegionModel> myRegions = [];
  List<ZoneModel> myZones = [];
  GlobalKey<FormState> myKey = GlobalKey();
  final TextEditingController _doBController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _idTypeController = TextEditingController();
  final TextEditingController _idNoController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _sFirstNameController = TextEditingController();
  final TextEditingController _sLastNameController = TextEditingController();
  final TextEditingController _sPhoneNoController = TextEditingController();
  final TextEditingController _sIdNoController = TextEditingController();
  final TextEditingController _cFirstNameController = TextEditingController();
  final TextEditingController _cLastNameController = TextEditingController();
  final TextEditingController _cPhoneNoController = TextEditingController();
  final TextEditingController _cIdNoController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _woredaController = TextEditingController();
  final TextEditingController _kebeleController = TextEditingController();
  final TextEditingController _educationLevelController =
      TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr;
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Please enter a valid name (letters and spaces only)'.tr;
    } else if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long'.tr;
    }
    return null; // Return null if validation passes
  }

  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr;
    } else if (value.trim().length < 2) {
      return 'This field must be at least 2 characters long'.tr;
    }
    return null; // Return null if validation passes
  }

  String? newValidateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr;
    }
    return null; // Return null if validation passes
  }

  String? validateIdNo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr;
    } else if (_idTypeController.text == 'Driver\'s License' &&
        value.trim().length < 6) {
      return 'Id. No. must be at least 6 characters long'.tr;
    } else if (_idTypeController.text == 'Passport' &&
        value.trim().length != 9) {
      return 'Id. No. must be 9 characters long'.tr;
    } else if (_idTypeController.text == 'National ID' &&
        value.trim().length != 12) {
      return 'Id. No. must be 12 characters long'.tr;
    }
    return null; // Return null if validation passes
  }

  String? validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.tr;
    }
    return null; // Validation passed
  }

  PersonalInfoModel? personalData;
  @override
  void initState() {
    super.initState();
    context.read<KycBloc>().add(RegionsKYCFetched());
    getPersonalInfo();
  }

  Future<PersonalInfoModel?> getPersonalInfo() async {
    setState(() {
      loadValues = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    PhoneNumberManager phoneManager = PhoneNumberManager();
    String? phone = await phoneManager.getPhoneNumber();

    final String? jsonString = prefs.getString('personal_info_$phone');

    if (jsonString != null) {
      if (mounted) {
        setState(() {
          personalData = PersonalInfoModel.fromJson(jsonString);
        });
        _initializeTextFields();
      }

      if (mounted) {
        setState(() {
          loadValues = false;
        });
      }

      return PersonalInfoModel.fromJson(jsonString);
    }

    if (mounted) {
      context.read<KycBloc>().add(PersonalKYCFetched());
    }

    if (mounted) {
      setState(() {
        loadValues = false;
      });
    }

    return null; // Return null if no data is found
  }

  void fetchzone(String regionId) async {
    context.read<KycBloc>().add(ZonesKYCFetched(regionId: regionId));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocListener<KycBloc, KycState>(
          listener: (context, state) {
            if (state is KycPersonalSentLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is KycPersonalSentSuccess) {
              context.read<KycBloc>().add(KYCStatusFetched());
              setState(() {
                loading = false;
              });
              displaySnack(context, "Personal info. sent successfully!".tr,
                  Colors.black);
            } else if (state is KycPersonalSentFailure) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            } else if (state is KycPersonalFetchedLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is KycPersonalFetchedSuccess) {
              setState(() {
                personalData = state.personalInfo;
                _initializeTextFields();
                loading = false;
              });
            } else if (state is KycPersonalFetchedFailure) {
              setState(() {
                loading = false;
              });
            } else if (state is KycRegionsFetchedLoading) {
              setState(() {
                loadValues = true;
              });
            } else if (state is KycRegionsFetchedSuccess) {
              setState(() {
                myRegions = state.regionInfo;
                if (personalData != null) {
                  String regionId = myRegions
                      .firstWhere((region) =>
                          region.regionName ==
                          personalData!.residentialInfoDto.region)
                      .id
                      .toString();
                  // print("regionId");
                  // print(regionId);
                  fetchzone(regionId);
                }
                // _initializeTextFields();
                loadValues = false;
              });
            } else if (state is KycRegionsFetchedFailure) {
              // print("I'm fetching the personal data");
              setState(() {
                loadValues = false;
              });
            } else if (state is KycZonesFetchedLoading) {
              setState(() {
                loadValues = true;
              });
            } else if (state is KycZonesFetchedSuccess) {
              setState(() {
                myZones = state.zoneInfo;
                if (!zoneFetched) {
                  _initializeTextFields();
                }
                zoneFetched = true;
                loadValues = false;
              });
            } else if (state is KycZonesFetchedFailure) {
              // print("I'm fetching the personal data");
              setState(() {
                loadValues = false;
              });
            }
          },
          child: Form(
            key: myKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Complete all the fields below".tr),
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Personal Info.".tr),
                    ),
                    const Expanded(
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
                        validator: (value) => validateName(value),
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name'.tr,
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
                        validator: (value) => validateName(value),
                        controller: _middleNameController,
                        decoration: InputDecoration(
                          labelText: 'Middle Name'.tr,
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
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        validator: (value) => validateName(value),
                        decoration: InputDecoration(
                          labelText: 'Last Name'.tr,
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
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _genderController.text.isNotEmpty &&
                                  ['MALE', 'FEMALE']
                                      .contains(_genderController.text)
                              ? _genderController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Gender'.tr,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'MALE',
                              child: Text('Male'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'FEMALE',
                              child: Text('Female'.tr),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _genderController.text = value!;
                            });
                          },
                        ),
                      ),
                    const SizedBox(width: 16),
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _idTypeController.text.isNotEmpty &&
                                  [
                                    'Driver\'s License',
                                    'Passport',
                                    'National ID'
                                  ].contains(_idTypeController.text)
                              ? _idTypeController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Id. Type'.tr,
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
                              child: Text('Driver\'s License'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'Passport',
                              child: Text('Passport'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'National ID',
                              child: Text('National ID'.tr),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _idNoController.clear();
                              _idTypeController.text = value!;
                            });
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
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth'.tr,
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        onTap: () async {
                          // Calculate the date 18 years ago from today
                          final DateTime eighteenYearsAgo = DateTime.now()
                              .subtract(const Duration(days: 365 * 18));

                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                eighteenYearsAgo, // Set initial date to 18 years ago
                            firstDate: DateTime(1900),
                            lastDate:
                                eighteenYearsAgo, // Set maximum date to 18 years ago
                          );

                          if (pickedDate != null) {
                            // Handle the selected date
                            // Format the date and update the field
                            final formattedDate =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                            // Assuming you use a controller to set the value
                            setState(() {
                              _doBController.text = formattedDate;
                            });
                            // print(_dateController.text);
                          }
                        },
                        controller: _doBController,
                        validator: (value) => validateField(value),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _educationLevelController.text.isNotEmpty &&
                                  ['Primary', 'Secondary', 'BSc', 'MSc']
                                      .contains(_educationLevelController.text)
                              ? _educationLevelController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Education level'.tr,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Primary',
                              child: Text('Primary'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'Secondary',
                              child: Text('Secondary'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'BSc',
                              child: Text('BSc.'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'MSc',
                              child: Text('MSc.'.tr),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _educationLevelController.text = value!;
                            });
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
                        enabled: _idTypeController.text.isNotEmpty,
                        controller: _idNoController,
                        validator: (value) => validateIdNo(value),
                        decoration: InputDecoration(
                          labelText: 'ID. No.'.tr,
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
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _maritalStatusController.text.isNotEmpty &&
                                  ['Single', 'Married', 'Divorced', 'Widowed']
                                      .contains(_maritalStatusController.text)
                              ? _maritalStatusController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Marital Status'.tr,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Single',
                              child: Text('Single'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'Married',
                              child: Text('Married'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'Divorced',
                              child: Text('Divorced'.tr),
                            ),
                            DropdownMenuItem(
                              value: 'Widowed',
                              child: Text('Widowed'.tr),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _maritalStatusController.text = value!;
                              _sFirstNameController.clear();
                              _sLastNameController.clear();
                              _sPhoneNoController.clear();
                              _sIdNoController.clear();
                            });
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_maritalStatusController.text == "Married")
                  Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(
                            color: Colors.grey, // Set the color of the divider
                            thickness: 1,
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Spouse info.".tr),
                          ),
                          const Expanded(
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
                              controller: _sFirstNameController,
                              validator: (value) => validateName(value),
                              decoration: InputDecoration(
                                labelText: 'First Name'.tr,
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
                              controller: _sLastNameController,
                              validator: (value) => validateName(value),
                              decoration: InputDecoration(
                                labelText: 'Last Name'.tr,
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
                              controller: _sPhoneNoController,
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return 'Phone number is required'.tr;
                                } else if (value!.length != 10) {
                                  return 'Invalid phone number format'.tr;
                                } else if (!value.startsWith("09")) {
                                  return 'Invalid phone number format'.tr;
                                } else if (!RegExp(r'^\d+$')
                                    .hasMatch(value.trim())) {
                                  return 'This field must contain only numbers'
                                      .tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone Number'.tr,
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
                              controller: _sIdNoController,
                              validator: (value) => newValidateField(value),
                              decoration: InputDecoration(
                                labelText: 'ID. No.'.tr,
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
                    ],
                  ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Altenative contact person".tr),
                    ),
                    const Expanded(
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
                        controller: _cFirstNameController,
                        validator: (value) => validateName(value),
                        decoration: InputDecoration(
                          labelText: 'First Name'.tr,
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
                        controller: _cLastNameController,
                        validator: (value) => validateName(value),
                        decoration: InputDecoration(
                          labelText: 'Last Name'.tr,
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
                        controller: _cPhoneNoController,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Phone number is required'.tr;
                          } else if (value!.length != 10) {
                            return 'Invalid phone number format'.tr;
                          } else if (!value.startsWith("09")) {
                            return 'Invalid phone number format'.tr;
                          } else if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                            return 'This field must contain only numbers'.tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number'.tr,
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
                        controller: _cIdNoController,
                        validator: (value) => newValidateField(value),
                        decoration: InputDecoration(
                          labelText: 'ID. No.'.tr,
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
                    const Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Residential Info.".tr),
                    ),
                    const Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                  ],
                ),
                Row(
                  children: [
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _regionController.text.isNotEmpty &&
                                  myRegions.any((region) =>
                                      region.regionName ==
                                      _regionController.text)
                              ? _regionController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Region/ District'.tr,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: myRegions.map((region) {
                            return DropdownMenuItem(
                              value: region.regionName,
                              child: Text(region.regionName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;

                            setState(() {
                              _regionController.text = value;
                            });

                            try {
                              String regionId = myRegions
                                  .firstWhere(
                                      (region) => region.regionName == value)
                                  .id
                                  .toString();

                              _zoneController.clear();
                              fetchzone(regionId);
                            } catch (e) {
                              // Handle the case where region is not found
                              displaySnack(context,
                                  "Selected region not found".tr, Colors.red);
                            }
                          },
                        ),
                      ),
                    const SizedBox(width: 16),
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _zoneController.text.isNotEmpty &&
                                  myZones.any((zone) =>
                                      zone.zoneName == _zoneController.text)
                              ? _zoneController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Zone/ Subcity'.tr,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: myZones.map((zone) {
                            return DropdownMenuItem(
                              value: zone.zoneName,
                              child: Text(zone.zoneName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;

                            setState(() {
                              _zoneController.text = value;
                            });
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
                        controller: _woredaController,
                        validator: (value) => newValidateField(value),
                        decoration: InputDecoration(
                          labelText: 'Woreda'.tr,
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
                        controller: _kebeleController,
                        validator: (value) => newValidateField(value),
                        decoration: InputDecoration(
                          labelText: 'Kebele'.tr,
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
                MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            if (myKey.currentState!.validate()) {
                              context.read<KycBloc>().add(PersonalKYCSent(
                                  personalinfo: PersonalInfoModel(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      middleName: _middleNameController.text,
                                      gender: _genderController.text,
                                      idType: _idTypeController.text,
                                      dateOfBirth: _doBController.text,
                                      educationLevel:
                                          _educationLevelController.text,
                                      idNo: _idNoController.text,
                                      meritalStatus:
                                          _maritalStatusController.text,
                                      alternativeContactPerson:
                                          ContactPersonInfoModel(
                                              contactPersonfirstName:
                                                  _cFirstNameController.text,
                                              contactPersonlastName:
                                                  _cLastNameController.text,
                                              contactPersonphoneNumber:
                                                  _cPhoneNoController.text,
                                              idNo: _cIdNoController.text),
                                      residentialInfoDto: AddressInfoModel(
                                          region: _regionController.text,
                                          zone: _zoneController.text,
                                          woreda: _woredaController.text,
                                          kebele: _kebeleController.text),
                                      spouseInformationDto:
                                          _maritalStatusController.text == "Married"
                                              ? SpouseInfoModel(
                                                  firstName: _sFirstNameController
                                                      .text,
                                                  lastName:
                                                      _sLastNameController.text,
                                                  phoneNumber:
                                                      _sPhoneNoController.text,
                                                  idNo: _sIdNoController.text)
                                              : null)));
                            }
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
                        : Text(
                            personalData != null ? "Re-Submit".tr : "Submit".tr,
                            style: const TextStyle(color: Colors.white),
                          )),
                const SizedBox(height: 16),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _initializeTextFields() async {
    _firstNameController.text = personalData!.firstName;
    _lastNameController.text = personalData!.lastName;
    _middleNameController.text = personalData?.middleName ?? '';
    _genderController.text = personalData!.gender;
    _idTypeController.text = personalData!.idType;
    _doBController.text = personalData!.dateOfBirth;
    _educationLevelController.text = personalData!.educationLevel;
    _idNoController.text = personalData!.idNo;
    _maritalStatusController.text = personalData!.meritalStatus;
    if (personalData!.spouseInformationDto != null) {
      _sFirstNameController.text =
          personalData!.spouseInformationDto!.firstName;
      _sLastNameController.text = personalData!.spouseInformationDto!.lastName;
      _sPhoneNoController.text =
          personalData!.spouseInformationDto!.phoneNumber;
      _sIdNoController.text = personalData!.spouseInformationDto!.idNo;
    }
    _cFirstNameController.text =
        personalData!.alternativeContactPerson.contactPersonfirstName;
    _cLastNameController.text =
        personalData!.alternativeContactPerson.contactPersonlastName;
    _cPhoneNoController.text =
        personalData!.alternativeContactPerson.contactPersonphoneNumber;
    _cIdNoController.text = personalData!.alternativeContactPerson.idNo;
    _regionController.text = personalData!.residentialInfoDto.region;
    _zoneController.text = personalData!.residentialInfoDto.zone;
    _woredaController.text = personalData!.residentialInfoDto.woreda;
    _kebeleController.text = personalData!.residentialInfoDto.kebele;
  }
}
