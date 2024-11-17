import 'package:flutter/material.dart';
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                      decoration: InputDecoration(
                        labelText: 'Quantity of Asset',
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
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Adjusting the TextFormField size
                  Flexible(
                    flex: 2,
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: 100), // Limit max height if needed
                      child: TextFormField(
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
                  ),
                  const SizedBox(width: 8), // Adjust spacing between widgets
                  // Adjusting button size
                  Flexible(
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
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
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
            ],
          ),
        ),
      ),
    );
  }
}
