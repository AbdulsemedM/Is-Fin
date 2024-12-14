import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/address_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/alternative_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/spouse_info_model.dart';
import 'package:ifb_loan/features/provider_KYC/bloc/provider_kyc_bloc.dart';

class ProviderPersonalInfoWidget extends StatefulWidget {
  final String phoneNumber;
  const ProviderPersonalInfoWidget({super.key, required this.phoneNumber});

  @override
  State<ProviderPersonalInfoWidget> createState() =>
      _ProviderPersonalInfoWidgetState();
}

class _ProviderPersonalInfoWidgetState
    extends State<ProviderPersonalInfoWidget> {
  var loading = false;
  var loadValues = false;
  var zoneFetched = false;
  List<RegionModel> myRegions = [];
  List<ZoneModel> myZones = [];
  GlobalKey<FormState> myKey = GlobalKey();
  final TextEditingController _doBController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
      return 'This field is required';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Please enter a valid name (letters and spaces only)';
    } else if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null; // Return null if validation passes
  }

  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (value.trim().length < 2) {
      return 'This field must be at least 2 characters long';
    }
    return null; // Return null if validation passes
  }

  String? validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null; // Validation passed
  }

  // PersonalInfoModel? personalData;
  @override
  void initState() {
    super.initState();
    context.read<ProviderKycBloc>().add(ProviderRegionsKYCFetched());
  }

  void fetchzone(String regionId) async {
    context
        .read<ProviderKycBloc>()
        .add(ProviderZonesKYCFetched(regionId: regionId));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocListener<ProviderKycBloc, ProviderKycState>(
          listener: (context, state) {
            if (state is ProviderPersonalInfoKYCSentLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is ProviderPersonalInfoKYCSentSuccess) {
              setState(() {
                loading = false;
              });
              displaySnack(
                  context, "Personal info. sent successfully!", Colors.black);
            } else if (state is ProviderPersonalInfoKYCSentError) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            } else if (state is ProviderRegionsKYCFetchedLoading) {
              setState(() {
                loadValues = true;
              });
            } else if (state is ProviderRegionsKYCFetchedSuccess) {
              setState(() {
                myRegions = state.regions;
                loadValues = false;
              });
            } else if (state is ProviderRegionsKYCFetchedError) {
              // print("I'm fetching the personal data");
              setState(() {
                loadValues = false;
              });
            } else if (state is ProviderZonesKYCFetchedLoading) {
              setState(() {
                loadValues = true;
              });
            } else if (state is ProviderZonesKYCFetchedSuccess) {
              setState(() {
                myZones = state.zones;
                zoneFetched = true;
                loadValues = false;
              });
            } else if (state is ProviderZonesKYCFetchedError) {
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Complete all the fields below"),
                ),
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Personal Info."),
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
                        validator: (value) => validateName(value),
                        controller: _firstNameController,
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
                        controller: _lastNameController,
                        validator: (value) => validateName(value),
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
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _genderController.text.isNotEmpty
                              ? _genderController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'MALE',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'FEMALE',
                              child: Text('Female'),
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
                          value: _idTypeController.text.isNotEmpty
                              ? _idTypeController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Id. Type',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: const [
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
                            setState(() {
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
                        readOnly: true, // Makes the field non-editable
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: const Icon(
                              Icons.calendar_today), // Adds a calendar icon
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), // Default date
                            firstDate: DateTime(1900), // Earliest date
                            lastDate: DateTime
                                .now(), // Latest date (no future dates allowed)
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
                          value: _educationLevelController.text.isNotEmpty
                              ? _educationLevelController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Education level',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Primary',
                              child: Text('Primary'),
                            ),
                            DropdownMenuItem(
                              value: 'Secondary',
                              child: Text('Secondary'),
                            ),
                            DropdownMenuItem(
                              value: 'BSc',
                              child: Text('BSc.'),
                            ),
                            DropdownMenuItem(
                              value: 'MSc',
                              child: Text('MSc.'),
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
                        controller: _idNoController,
                        validator: (value) => validateField(value),
                        decoration: InputDecoration(
                          labelText: 'ID. No.',
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
                          value: _maritalStatusController.text.isNotEmpty
                              ? _maritalStatusController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Marital Status',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Single',
                              child: Text('Single'),
                            ),
                            DropdownMenuItem(
                              value: 'Married',
                              child: Text('Married'),
                            ),
                            DropdownMenuItem(
                              value: 'Divorced',
                              child: Text('Divorced'),
                            ),
                            DropdownMenuItem(
                              value: 'Widowed',
                              child: Text('Widowed'),
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
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.grey, // Set the color of the divider
                            thickness: 1,
                          )),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Spouse info."),
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
                              controller: _sFirstNameController,
                              validator: (value) => validateName(value),
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
                              controller: _sLastNameController,
                              validator: (value) => validateName(value),
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
                              controller: _sPhoneNoController,
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return 'Phone number is required';
                                } else if (value!.length != 10) {
                                  return 'Invalid phone number format';
                                } else if (!value.startsWith("09")) {
                                  return 'Invalid phone number format';
                                } else if (!RegExp(r'^\d+$')
                                    .hasMatch(value.trim())) {
                                  return 'This field must contain only numbers';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
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
                              validator: (value) => validateField(value),
                              decoration: InputDecoration(
                                labelText: 'ID. No.',
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
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Altenative contact person"),
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
                        controller: _cFirstNameController,
                        validator: (value) => validateName(value),
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
                        controller: _cLastNameController,
                        validator: (value) => validateName(value),
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
                        controller: _cPhoneNoController,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Phone number is required';
                          } else if (value!.length != 10) {
                            return 'Invalid phone number format';
                          } else if (!value.startsWith("09")) {
                            return 'Invalid phone number format';
                          } else if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                            return 'This field must contain only numbers';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
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
                        validator: (value) => validateField(value),
                        decoration: InputDecoration(
                          labelText: 'ID. No.',
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
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Residential Info."),
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
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _regionController.text.isNotEmpty
                              ? _regionController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Region/ District',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: myRegions.map((region) {
                            return DropdownMenuItem(
                              value: region.regionName, // Use ID as the value
                              child: Text(region
                                  .regionName), // Display the name in the dropdown
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _regionController.text =
                                  value!; // Store the selected region
                            });

                            // Now fetch the zones after the state is updated
                            String regionId = myRegions
                                .firstWhere(
                                    (region) => region.regionName == value)
                                .id
                                .toString();

                            _zoneController.clear(); // Reset zone controller
                            fetchzone(
                                regionId); // Fetch zones based on the selected region
                          },
                        ),
                      ),
                    const SizedBox(width: 16),
                    if (!loadValues)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _zoneController.text.isNotEmpty
                              ? _zoneController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Zone/ Subcity',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: myZones.map((zone) {
                            return DropdownMenuItem(
                              value: zone.zoneName, // Use ID as the value
                              child: Text(zone
                                  .zoneName), // Display the name in the dropdown
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _zoneController.text =
                                  value!; // Store the selected ID
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
                        validator: (value) => validateField(value),
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
                        controller: _kebeleController,
                        validator: (value) => validateField(value),
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
                MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            if (myKey.currentState!.validate()) {
                              context.read<ProviderKycBloc>().add(ProviderPersonalInfoKYCSent(
                                  phoneNumber: widget.phoneNumber,
                                  personalInfo: PersonalInfoModel(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
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
                        : const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
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
}
