import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_application/presentation/widgets/table_item_widget.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  var loading = false;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productDescController = TextEditingController();
  final TextEditingController _productUoMController = TextEditingController();
  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null; // Return null if validation passes
  }

  String? validateQuantityField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a quantity';
    }
    if (int.tryParse(value) == null) {
      return 'Only numbers are allowed';
    }
    return null;
  }

  String? validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null; // Validation passed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apply for Murabaha Loan",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Form(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _productNameController,
                          validator: (value) => validateField(value),
                          decoration: InputDecoration(
                            labelText: 'Name of Product',
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
                              TextInputType.number, // Numeric keyboard
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Allow only digits
                          ],
                          decoration: InputDecoration(
                            labelText: 'Quantity of Asset',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) => validateQuantityField(value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 100), // Limit max height if needed
                    child: TextFormField(
                      controller: _productDescController,
                      validator: (value) => validateField(value),
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Product Desc.',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          validator: (value) => validateDropDown(value),
                          decoration: InputDecoration(
                            labelText: 'Unit of Measurement',
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
                          backgroundColor: loading
                              ? AppColors.iconColor
                              : AppColors.primaryDarkColor,
                          onPressed: loading
                              ? () {}
                              : () {
                                  setState(() {
                                    loading = true;
                                  });
                                },
                          buttonText: loading
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Divider(),
              ),
              TableWidget(
                items: [
                  TableItem(
                    name: 'Laptop',
                    quantity: 3,
                    onDelete: () {
                      // print("Delete Laptop");
                    },
                  ),
                  TableItem(
                    name: 'Tablet Phone',
                    quantity: 10,
                    onDelete: () {
                      // print("Delete Tablet Phone");
                    },
                  ),
                  TableItem(
                    name: 'Smart Phone',
                    quantity: 7,
                    onDelete: () {
                      // print("Delete Smart Phone");
                    },
                  ),
                  TableItem(
                    name: 'Smart TV',
                    quantity: 10,
                    onDelete: () {
                      // print("Delete Smart TV");
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sector',
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Provider',
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
                        labelText: 'Repayment Plan',
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
              SizedBox(height: 16),
              MyButton(
                  backgroundColor: loading
                      ? AppColors.iconColor
                      : AppColors.primaryDarkColor,
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
                          "Apply Loan",
                          style: TextStyle(color: Colors.white),
                        )),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
