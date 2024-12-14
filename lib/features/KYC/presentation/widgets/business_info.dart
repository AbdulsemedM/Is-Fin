import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_address_model.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  var loading = false;
  var loadValues = false;
  var zoneFetched = false;
  List<RegionModel> myRegions = [];
  List<ZoneModel> myZones = [];
  GlobalKey<FormState> myKey = GlobalKey();
  final TextEditingController _yearofEstablishmentController =
      TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _websiteURLController = TextEditingController();
  final TextEditingController _tinNoController = TextEditingController();
  final TextEditingController _ownershipController = TextEditingController();
  final TextEditingController _financeSourceController =
      TextEditingController();
  final TextEditingController _typeofBusinessController =
      TextEditingController();
  final TextEditingController _startingCapitalController =
      TextEditingController();
  final TextEditingController _currentCapitalController =
      TextEditingController();
  final TextEditingController _startingEmployeeNoController =
      TextEditingController();
  final TextEditingController _currentEmployeeNoController =
      TextEditingController();
  final TextEditingController _monthlySalesController = TextEditingController();
  final TextEditingController _monthlyRevenueController =
      TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _woredaController = TextEditingController();
  final TextEditingController _kebeleController = TextEditingController();
  final TextEditingController _businessLevelController =
      TextEditingController();
  PhoneNumberManager phoneManager = PhoneNumberManager();
  BusinessInfoModel? businessData;
  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (value.trim().length < 2) {
      return 'This field must be at least 2 characters long';
    }
    return null; // Return null if validation passes
  }

  String? validateNumberField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
      return 'This field must contain only numbers';
    }
    return null; // Return null if validation passes
  }

  String? validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a gender';
    }
    return null; // Validation passed
  }

  @override
  void initState() {
    super.initState();
    // super.initState();
    fetchRegions();
    getBusinessInfo();
  }

  Future<BusinessInfoModel?> getBusinessInfo() async {
    setState(() {
      loadValues = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the JSON string
    PhoneNumberManager phoneManager = PhoneNumberManager();
    String? phone = await phoneManager.getPhoneNumber();
    final String? jsonString = prefs.getString('business_info_$phone');

    if (jsonString != null) {
      setState(() {
        businessData = BusinessInfoModel.fromJson(jsonString);
      });
      _initializeTextFields();
      setState(() {
        loadValues = false;
      });
      return BusinessInfoModel.fromJson(jsonString);
    }
    context.read<KycBloc>().add(BusinessKYCFetched());
    setState(() {
      loadValues = false;
    });
    return null; // Return null if no data is found
  }

  void fetchzone(String regionId) async {
    context.read<KycBloc>().add(ZonesKYCFetched(regionId: regionId));
  }

  void fetchRegions() async {
    // print(regionId);
    context.read<KycBloc>().add(RegionsKYCFetched());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocListener<KycBloc, KycState>(
          listener: (context, state) {
            if (state is KycBusinessSentLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is KycBusinessSentSuccess) {
              context.read<KycBloc>().add(KYCStatusFetched());
              setState(() {
                loading = false;
              });
              displaySnack(
                  context, "Business info. sent successfully", Colors.black);
            } else if (state is KycBusinessSentFailure) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            } else if (state is KycBusinessFetchedLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is KycBusinessFetchedSuccess) {
              setState(() {
                businessData = state.businessInfo;
                _initializeTextFields();
                loading = false;
              });
              displaySnack(
                  context, "Business info fetched successfully", Colors.black);
            } else if (state is KycBusinessFetchedFailure) {
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
                if (businessData != null) {
                  String regionId = myRegions
                      .firstWhere((region) =>
                          region.regionName ==
                          businessData!
                              .businessAddressDto.businessAddressregion)
                      .id
                      .toString();
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
                        controller: _businessNameController,
                        validator: (value) => validateField(value),
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
                        controller: _websiteURLController,
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
                        controller: _tinNoController,
                        validator: (value) => validateNumberField(value),
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
                        value: _typeofBusinessController.text.isNotEmpty
                            ? _typeofBusinessController.text
                            : null,
                        validator: (value) => validateDropDown(value),
                        decoration: InputDecoration(
                          labelText: 'Business Type',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Small Business Trade',
                            child: Text('Small Business Trade'),
                          ),
                          DropdownMenuItem(
                            value: 'Agriculture',
                            child: Text('Agriculture'),
                          ),
                          DropdownMenuItem(
                            value: 'Manufacturing',
                            child: Text('Manufacturing'),
                          ),
                          DropdownMenuItem(
                            value: 'Hospitality',
                            child: Text('Hospitality'),
                          ),
                          DropdownMenuItem(
                            value: 'Transport',
                            child: Text('Transport'),
                          ),
                          DropdownMenuItem(
                            value: 'Technology',
                            child: Text('Technology'),
                          ),
                          DropdownMenuItem(
                            value: 'Halal Tourism',
                            child: Text('Halal Tourism'),
                          ),
                          DropdownMenuItem(
                            value: 'Education',
                            child: Text('Education'),
                          ),
                          DropdownMenuItem(
                            value: 'Building and Construction',
                            child: Text('Building and Construction'),
                          ),
                          DropdownMenuItem(
                            value: 'Other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _typeofBusinessController.text = value!;
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
                        validator: (value) => validateField(value),
                        readOnly: true, // Makes the field non-editable
                        decoration: InputDecoration(
                          labelText: 'Year of Establishment',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: const Icon(
                              Icons.calendar_today), // Adds a calendar icon
                        ),
                        controller:
                            _yearofEstablishmentController, // Controller for the selected year
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime(1900), // Earliest selectable year
                            lastDate: DateTime.now(), // Latest selectable year
                            initialDatePickerMode:
                                DatePickerMode.year, // Opens in year selection
                          );
                          if (pickedDate != null) {
                            // Update the controller with the selected year
                            _yearofEstablishmentController.text =
                                pickedDate.year.toString();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _ownershipController.text.isNotEmpty
                            ? _ownershipController.text
                            : null,
                        validator: (value) => validateDropDown(value),
                        decoration: InputDecoration(
                          labelText: 'Ownership',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Sole',
                            child: Text('Sole'),
                          ),
                          DropdownMenuItem(
                            value: 'Partnership',
                            child: Text('Partnership'),
                          ),
                          DropdownMenuItem(
                            value: 'PLC',
                            child: Text('PLC'),
                          ),
                          DropdownMenuItem(
                            value: 'Cooperative',
                            child: Text('Cooperative'),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _ownershipController.text = value!;
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
                      child: DropdownButtonFormField<String>(
                        value: _financeSourceController.text.isNotEmpty
                            ? _financeSourceController.text
                            : null,
                        validator: (value) => validateDropDown(value),
                        decoration: InputDecoration(
                          labelText: 'Finance Source',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Own',
                            child: Text('Own'),
                          ),
                          DropdownMenuItem(
                            value: 'Family',
                            child: Text('Family'),
                          ),
                          DropdownMenuItem(
                            value: 'Fund',
                            child: Text('Fund'),
                          ),
                          DropdownMenuItem(
                            value: 'Loan',
                            child: Text('Loan'),
                          ),
                          // DropdownMenuItem(
                          //   value: 'Inheritance',
                          //   child: Text('Inheritance'),
                          // ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _financeSourceController.text = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _businessLevelController.text.isNotEmpty
                            ? _businessLevelController.text
                            : null,
                        validator: (value) => validateDropDown(value),
                        decoration: InputDecoration(
                          labelText: 'Business Level',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Startup',
                            child: Text('Startup'),
                          ),
                          DropdownMenuItem(
                            value: 'Growing',
                            child: Text('Growing'),
                          ),
                          DropdownMenuItem(
                            value: 'Advanced',
                            child: Text('Advanced'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _businessLevelController.text = value!;
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
                        controller: _startingCapitalController,
                        validator: (value) => validateNumberField(value),
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
                        validator: (value) => validateNumberField(value),
                        controller: _currentCapitalController,
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
                        controller: _startingEmployeeNoController,
                        validator: (value) => validateField(value),
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
                        controller: _currentEmployeeNoController,
                        validator: (value) => validateField(value),
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
                        controller: _monthlySalesController,
                        validator: (value) => validateField(value),
                        decoration: InputDecoration(
                          labelText: 'Annual Sales(ETB)',
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
                        controller: _monthlyRevenueController,
                        validator: (value) => validateField(value),
                        decoration: InputDecoration(
                          labelText: 'Annual Revenue(ETB)',
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
                      backgroundColor: loading
                          ? AppColors.iconColor
                          : AppColors.primaryDarkColor,
                      onPressed: loading
                          ? () {}
                          : () {
                              if (myKey.currentState!.validate()) {
                                context.read<KycBloc>().add(BusinessKYCSent(
                                    businessInfo: BusinessInfoModel(
                                        businessName:
                                            _businessNameController.text,
                                        tinNumber: _tinNoController.text,
                                        yearOfEstablishment:
                                            _yearofEstablishmentController.text,
                                        ownership: _ownershipController.text,
                                        businessType:
                                            _typeofBusinessController.text,
                                        financeSource:
                                            _financeSourceController.text,
                                        startingCapital:
                                            _startingCapitalController.text,
                                        currentCapital:
                                            _currentCapitalController.text,
                                        startingEmployee:
                                            _startingEmployeeNoController.text,
                                        currentEmployee:
                                            _currentEmployeeNoController.text,
                                        monthlySales:
                                            _monthlySalesController.text,
                                        monthlyRevenue:
                                            _monthlyRevenueController.text,
                                        businessAddressDto: BusinessAddressModel(
                                            businessAddressregion:
                                                _regionController.text,
                                            businessAdressZone:
                                                _zoneController.text,
                                            businessAdressWoreda:
                                                _woredaController.text,
                                            businessAdressKebele:
                                                _kebeleController.text))));
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
                              businessData != null ? "Re-Submit" : "Submit",
                              style: const TextStyle(color: Colors.white),
                            )),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _initializeTextFields() async {
    _businessNameController.text = businessData!.businessName;
    if (businessData!.websiteUrl != null) {
      _websiteURLController.text = businessData!.websiteUrl!;
    }
    _tinNoController.text = businessData!.tinNumber;
    _typeofBusinessController.text = businessData!.businessType;
    _yearofEstablishmentController.text = businessData!.yearOfEstablishment;
    _ownershipController.text = businessData!.ownership;
    _financeSourceController.text = businessData!.financeSource;
    _startingCapitalController.text = businessData!.startingCapital;
    _currentCapitalController.text = businessData!.currentCapital;
    _startingEmployeeNoController.text = businessData!.startingEmployee;
    _currentEmployeeNoController.text = businessData!.currentEmployee;
    _monthlySalesController.text = businessData!.monthlySales;
    _monthlyRevenueController.text = businessData!.monthlyRevenue;
    _regionController.text =
        businessData!.businessAddressDto.businessAddressregion;
    _zoneController.text = businessData!.businessAddressDto.businessAdressZone;
    _woredaController.text =
        businessData!.businessAddressDto.businessAdressWoreda;
    _kebeleController.text =
        businessData!.businessAddressDto.businessAdressKebele;
  }
}
