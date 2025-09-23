import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/business_partner/bloc/providers_bloc.dart';
import 'package:ifb_loan/features/loan_application/bloc/loan_app_bloc.dart';
import 'package:ifb_loan/features/loan_application/models/products_model.dart';
import 'package:ifb_loan/features/loan_application/models/products_request_model.dart';
import 'package:ifb_loan/features/loan_application/presentation/widgets/table_item_widget.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanApplicationScreen extends StatefulWidget {
  final String? productName;
  const LoanApplicationScreen({super.key, this.productName});

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  var loading = false;
  var loading1 = false;
  var isSectorFetched = false;
  var isRepayment = false;
  var isUnitofMeasurement = false;
  var isProviderFetched = false;
  final UserManager userManager = UserManager();
  bool isInformalUser = false;
  bool isRepaymentAutoSelected = false;
  List<Map<String, String>> mySectors = [];
  List<Map<String, String>> myRepayments = [];
  List<Map<String, String>> myUnitofMeasurements = [];
  List<Map<String, String>> myProviders = [];
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productDescController = TextEditingController();
  final TextEditingController _productUoMController = TextEditingController();
  final TextEditingController _productSectorController =
      TextEditingController();
  final TextEditingController _productProviderController =
      TextEditingController();
  final TextEditingController _productRepaymentController =
      TextEditingController();
  List<ProductsModel> myProducts = [];
  bool saveProductsEnabled = false;
  GlobalKey<FormState> myKey1 = GlobalKey();
  GlobalKey<FormState> myKey2 = GlobalKey();
  @override
  void initState() {
    super.initState();
    _initializeUserType();
    context.read<LoanAppBloc>().add(SectorsFetch());
    context.read<LoanAppBloc>().add(RepaymentsFetch());
    context.read<LoanAppBloc>().add(UnitofMeasurementsFetch());
    context.read<ProvidersBloc>().add(ProviderFetch(isRateProvider: false));
    _loadProductsFromCache();

    // Pre-fill product name if passed from home screen
    if (widget.productName != null) {
      _productNameController.text = widget.productName!;
      _autoSelectSector(widget.productName!);
    }
  }

  Future<void> _saveProductsToCache() async {
    if (!saveProductsEnabled) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> productsJsonList =
          myProducts.map((product) => product.toJson()).toList();
      await prefs.setStringList('saved_products', productsJsonList);
    } catch (e) {
      print('Error saving products to cache: $e');
    }
  }

  Future<void> _loadProductsFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedProductsJsonList =
          prefs.getStringList('saved_products');

      if (savedProductsJsonList != null && savedProductsJsonList.isNotEmpty) {
        final loadedProducts = savedProductsJsonList
            .map((jsonStr) => ProductsModel.fromJson(jsonStr))
            .toList();

        if (loadedProducts.isNotEmpty) {
          setState(() {
            saveProductsEnabled = true;
            myProducts = loadedProducts;
          });
        }
      }
    } catch (e) {
      print('Error loading products from cache: $e');
    }
  }

  Future<void> _initializeUserType() async {
    String? userType = await userManager.getUserType();
    setState(() {
      isInformalUser = userType == "IN_FORMAL";
    });
  }

  void _autoSelectSector(String productName) {
    // Auto-select sector based on product name for informal users
    if (mySectors.isEmpty) {
      return;
    }

    // Find matching sector dynamically from available sectors
    String sectorName = '';
    String productLower = productName.toLowerCase();

    // Try exact match first
    var exactMatch = mySectors.firstWhere(
        (sector) => sector['sectorName']?.toLowerCase() == productLower,
        orElse: () => <String, String>{});

    if (exactMatch.isNotEmpty) {
      sectorName = exactMatch['sectorName'] ?? '';
    } else {
      // Try partial matches with key terms
      for (var sector in mySectors) {
        String sectorNameLower = (sector['sectorName'] ?? '').toLowerCase();

        // Check for agriculture/apiculture matches
        if ((productLower.contains('agriculture') ||
                productLower.contains('beekeep')) &&
            sectorNameLower.contains('apiculture')) {
          sectorName = sector['sectorName'] ?? '';
          break;
        }
        // Check for shoat/fattening matches
        else if ((productLower.contains('shoat') ||
                productLower.contains('fattening')) &&
            (sectorNameLower.contains('shoat') ||
                sectorNameLower.contains('fattening'))) {
          sectorName = sector['sectorName'] ?? '';
          break;
        }
        // Check for poultry matches
        else if (productLower.contains('poultry') &&
            sectorNameLower.contains('poultry')) {
          sectorName = sector['sectorName'] ?? '';
          break;
        }
      }
    }

    // Set the sector if found
    if (sectorName.isNotEmpty) {
      setState(() {
        _productSectorController.text = sectorName;
      });
      _autoSelectRepaymentForInformal(sectorName);
    }
  }

  void _autoSelectRepaymentForInformal(String sectorName) {
    if (!isInformalUser) {
      return;
    }

    // Find the sector in mySectors and get its duration dynamically
    String duration = '';
    var matchingSector = mySectors.firstWhere(
        (sector) => sector['sectorName'] == sectorName,
        orElse: () => <String, String>{});

    if (matchingSector.isNotEmpty) {
      duration = matchingSector['duration'] ?? '';
    }

    if (duration.isNotEmpty && myRepayments.isNotEmpty) {
      var matchingRepayment = myRepayments.firstWhere(
          (repayment) => repayment['duration'] == duration,
          orElse: () => <String, String>{});

      if (matchingRepayment.isNotEmpty) {
        setState(() {
          _productRepaymentController.text = duration;
          isRepaymentAutoSelected = true;
        });
      }
    }
  }

  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr;
    }
    return null; // Return null if validation passes
  }

  String? validateQuantityField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a quantity'.tr;
    }
    final doubleValue = double.tryParse(value);
    if (doubleValue == null) {
      return 'Please enter a valid number'.tr;
    }
    return null;
  }

  String? validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.tr;
    }
    return null; // Validation passed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apply for Murabaha Finance".tr,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<ProvidersBloc, ProvidersState>(
        listener: (context, state) {
          if (state is ProviderFetchSuccess) {
            setState(() {
              myProviders = state.providers;
              if (myProviders.isEmpty) {
                displaySnack(context, "No providers found", Colors.red);
              }
              isProviderFetched = true;
            });
          }
        },
        child: BlocListener<LoanAppBloc, LoanAppState>(
          listener: (context, state) {
            if (state is ProductsSentLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is ProductsSentSuccess) {
              setState(() {
                loading = false;
              });
              displaySnack(context, "Product request sent successfully".tr,
                  Colors.black);
              Navigator.pop(context);
            } else if (state is ProductsSentFailure) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            }
            /////////////////////////////////////////////////
            if (state is SectorFetchFailure) {
              displaySnack(context, state.errorMessage, Colors.red);
            }
            if (state is RepaymentFetchFailure) {
              displaySnack(context, state.errorMessage, Colors.red);
            }
            if (state is UnitofMeasurementsFetchFailure) {
              displaySnack(context, state.errorMessage, Colors.red);
            }
            if (state is SectorFetchSuccess) {
              setState(() {
                mySectors = state.sectors;
                isSectorFetched = true;
                // Try to auto-select sector again now that sectors are loaded
                if (widget.productName != null) {
                  _autoSelectSector(widget.productName!);
                }
              });
            }
            if (state is RepaymentFetchSuccess) {
              setState(() {
                myRepayments = state.repayments;
                isRepayment = true;
              });
            }
            if (state is UnitofMeasurementsFetchSuccess) {
              setState(() {
                myUnitofMeasurements = state.unitofMeasurement;
                isUnitofMeasurement = true;
              });
            }

            if (isRepayment && isSectorFetched && isUnitofMeasurement) {}
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Form(
                      key: myKey1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _productNameController,
                                  validator: (value) => validateField(value),
                                  decoration: InputDecoration(
                                    labelText: 'Name of Product'.tr,
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
                                  controller: _productQuantityController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true), // Allow decimals
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(
                                          r'^\d*\.?\d*$'), // Regular expression to allow digits and a single decimal point
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Quantity of Asset'.tr,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) =>
                                      validateQuantityField(value),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            constraints: const BoxConstraints(
                                maxHeight: 100), // Limit max height if needed
                            child: TextFormField(
                              controller: _productDescController,
                              validator: (value) => validateField(value),
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Product Desc.'.tr,
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  value: _productUoMController.text.isNotEmpty
                                      ? _productUoMController.text
                                      : null,
                                  validator: (value) => validateDropDown(value),
                                  decoration: InputDecoration(
                                    labelText: 'Unit of Measurement'.tr,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  items: myUnitofMeasurements.map((uoM) {
                                    return DropdownMenuItem(
                                      value: uoM[
                                          'unitOfMeasurement'], // Use ID as the value
                                      child: Text(uoM['unitOfMeasurement']
                                          .toString()), // Display the name in the dropdown
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _productUoMController.text = value!;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(
                                  width: 8), // Adjust spacing between widgets
                              // Adjusting button size
                              Expanded(
                                flex: 1,
                                child: MyButton(
                                  backgroundColor: loading1
                                      ? AppColors.iconColor
                                      : AppColors.primaryDarkColor,
                                  onPressed: loading1
                                      ? () {}
                                      : () {
                                          if (myKey1.currentState!.validate()) {
                                            setState(() {
                                              loading1 = true;
                                              myProducts.add(ProductsModel(
                                                  productName:
                                                      _productNameController
                                                          .text,
                                                  productDescription:
                                                      _productDescController
                                                          .text,
                                                  productQuantity: double.parse(
                                                      _productQuantityController
                                                          .text),
                                                  productUnitofMeasurement:
                                                      _productUoMController
                                                          .text));

                                              _productNameController.clear();
                                              _productDescController.clear();
                                              _productQuantityController
                                                  .clear();
                                              _productUoMController.clear();
                                              loading1 = false;
                                            });
                                            if (saveProductsEnabled) {
                                              _saveProductsToCache();
                                            }
                                            // print(myProducts.length);
                                          }
                                        },
                                  buttonText: loading1
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.add_outlined,
                                          color: Colors.white,
                                          size: 20, // Smaller icon size
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.primaryColor,
                        value: saveProductsEnabled,
                        onChanged: (value) {
                          setState(() {
                            saveProductsEnabled = value ?? false;
                          });
                          if (saveProductsEnabled) {
                            _saveProductsToCache();
                          }
                        },
                      ),
                      Text('Save products for later'.tr,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  TableWidget(
                    items: myProducts.map((product) {
                      return TableItem(
                        name: product.productName,
                        quantity: product.productQuantity,
                        onDelete: () {
                          setState(() {
                            myProducts.remove(product);
                          });
                          if (saveProductsEnabled) {
                            _saveProductsToCache();
                          }
                        },
                        onEdit: () {
                          setState(() {
                            myProducts.remove(product);
                            _productNameController.text = product.productName;
                            _productDescController.text =
                                product.productDescription;
                            _productQuantityController.text =
                                product.productQuantity.toString();
                            _productUoMController.text =
                                product.productUnitofMeasurement;
                          });
                          if (saveProductsEnabled) {
                            _saveProductsToCache();
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: myKey2,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _productSectorController.text.isNotEmpty
                              ? _productSectorController.text
                              : null,
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Sector'.tr,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: mySectors.map((sector) {
                            return DropdownMenuItem(
                              value:
                                  sector['sectorName'], // Use ID as the value
                              child: Text(sector['sectorName']
                                  .toString()), // Display the name in the dropdown
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _productSectorController.text = value!;
                              // Auto-select repayment when sector changes for informal users
                              if (isInformalUser) {
                                _autoSelectRepaymentForInformal(value);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value:
                                    _productProviderController.text.isNotEmpty
                                        ? _productProviderController.text
                                        : null,
                                validator: (value) => validateDropDown(value),
                                decoration: InputDecoration(
                                  labelText: 'Provider'.tr,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: myProviders.map((providers) {
                                  return DropdownMenuItem(
                                    value: providers[
                                        'phoneNumber'], // Use ID as the value
                                    child: Text(
                                      providers['fullName'].toString().length >
                                              13
                                          ? '${providers['fullName'].toString().substring(0, 13)}...'
                                          : providers['fullName'].toString(),
                                    ),
                                    // Display the name in the dropdown
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _productProviderController.text = value!;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value:
                                    _productRepaymentController.text.isNotEmpty
                                        ? _productRepaymentController.text
                                        : null,
                                validator: (value) => validateDropDown(value),
                                decoration: InputDecoration(
                                  labelText: 'Repayment Plan'.tr,
                                  filled: true,
                                  fillColor: (isInformalUser &&
                                          isRepaymentAutoSelected)
                                      ? Colors.grey[300]
                                      : Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: myRepayments.map((repayment) {
                                  return DropdownMenuItem(
                                    value: repayment[
                                        'duration'], // Use ID as the value
                                    child: Text(repayment['duration']
                                        .toString()), // Display the name in the dropdown
                                  );
                                }).toList(),
                                onChanged:
                                    (isInformalUser && isRepaymentAutoSelected)
                                        ? null
                                        : (value) {
                                            setState(() {
                                              _productRepaymentController.text =
                                                  value!;
                                              isRepaymentAutoSelected = false;
                                            });
                                          },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                      backgroundColor: loading
                          ? AppColors.iconColor
                          : AppColors.primaryDarkColor,
                      onPressed: loading
                          ? () {}
                          : () {
                              if (myKey2.currentState!.validate()) {
                                if (myProducts.isNotEmpty) {
                                  context
                                      .read<LoanAppBloc>()
                                      .add(ProductsRequestSent(
                                          products: ProductsRequestModel(
                                        products: myProducts,
                                        sector: _productSectorController.text,
                                        provider:
                                            _productProviderController.text,
                                        repymentPlan:
                                            _productRepaymentController.text,
                                      )));
                                } else {
                                  displaySnack(
                                      context,
                                      "Please add products first".tr,
                                      Colors.red);
                                }
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
                              "Apply Financing".tr,
                              style: TextStyle(color: Colors.white),
                            )),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
