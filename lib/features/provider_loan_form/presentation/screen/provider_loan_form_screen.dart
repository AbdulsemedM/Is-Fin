import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
// import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/provider_loan_form/bloc/provider_loan_form_bloc.dart';
import 'package:ifb_loan/features/provider_loan_form/models/requested_products_model.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_product_price_prompt.dart';

class ProviderLoanFormScreen extends StatefulWidget {
  final String id;
  final String name;
  const ProviderLoanFormScreen(
      {super.key, required this.id, required this.name});

  @override
  State<ProviderLoanFormScreen> createState() => _ProviderLoanFormScreenState();
}

class _ProviderLoanFormScreenState extends State<ProviderLoanFormScreen> {
  // Add list to store products from API
  List<RequestedProductsModel> products = [];
  List<RequestedProductsModel> productsToRemove = [];
  bool loading = false;
  // Add date controller
  DateTime? expirationDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<ProviderLoanFormBloc>()
        .add(FetchRequestedProductsById(widget.id));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Owner Form",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<ProviderLoanFormBloc, ProviderLoanFormState>(
        listener: (context, state) {
          if (state is RequestedProductsFetchedSuccess) {
            setState(() {
              products = state.requestedProducts;
            });
          } else if (state is RequestedProductsFetchedFailure) {
            displaySnack(context, state.errorMessage, Colors.red);
          } else if (state is RequestedProductsFetchedLoading) {
            print('Loading...');
          } else if (state is RequestedProductsPriceSentSuccess) {
            displaySnack(context, state.message, Colors.green);
            context
                .read<ProviderLoanFormBloc>()
                .add(FetchProviderLoanFormList());
            Navigator.pop(context);
          } else if (state is RequestedProductsPriceSentFailure) {
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                        "Fill product prices form for ${widget.name}'s request"),
                  ),
                ),
                BlocBuilder<ProviderLoanFormBloc, ProviderLoanFormState>(
                  builder: (context, state) {
                    if (state is RequestedProductsFetchedLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (products.isEmpty) {
                      return const Center(
                        child: Text('No products found'),
                      );
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Please enter the individual price for each product",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: (products.length * 60.0) + 80,
                          child: ProductTable(
                            products: products,
                            onProductPrice: (product, price) {
                              setState(() {
                                final index = products
                                    .indexWhere((p) => p.id == product.id);
                                if (index != -1) {
                                  products[index] = products[index]
                                      .copyWith(productPrice: price);
                                }
                              });
                            },
                            onProductRemove: (product) {
                              setState(() {
                                products.remove(product);
                                productsToRemove.add(product);
                              });
                            },
                          ),
                        ),
                        // Add total price display
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Total Price: ETB ${_calculateTotalPrice()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Add date picker field before the submit button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Price Expiration Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now().add(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          expirationDate = picked;
                          _dateController.text =
                              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MyButton(
                    height: ScreenConfig.screenHeight * 0.055,
                    width: ScreenConfig.screenWidth,
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () async {
                            // Add date validation
                            if (expirationDate == null) {
                              displaySnack(
                                  context,
                                  "Please select a price expiration date",
                                  Colors.red);
                              return;
                            }

                            // Check if any product has null price
                            bool hasNullPrice = products
                                .any((product) => product.productPrice == null);

                            if (hasNullPrice) {
                              displaySnack(
                                  context,
                                  "Please fill in all product prices",
                                  Colors.red);
                              return;
                            }
                            if (await _showConfirmationDialog('Submit')) {
                              context.read<ProviderLoanFormBloc>().add(
                                  SendRequestedProductsPrice(
                                      products,
                                      widget.id,
                                      expirationDate.toString(),
                                      "APPROVED"));
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
                            style: TextStyle(color: AppColors.bg1),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MyButton(
                    height: ScreenConfig.screenHeight * 0.055,
                    width: ScreenConfig.screenWidth,
                    backgroundColor: loading ? AppColors.iconColor : Colors.red,
                    onPressed: loading
                        ? () {}
                        : () async {
                            // Add date validation
                            if (await _showConfirmationDialog('Reject')) {
                              context.read<ProviderLoanFormBloc>().add(
                                  SendRequestedProductsPrice(
                                      products,
                                      widget.id,
                                      expirationDate.toString(),
                                      "REJECT"));
                            }
                            // context.read<ProviderLoanFormBloc>().add(
                            //     SendRequestedProductsPrice(products, widget.id,
                            //         expirationDate.toString(), "REJECT"));
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
                            "Reject",
                            style: TextStyle(color: AppColors.bg1),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(String action) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm $action'),
              content: Text('Are you sure you want to $action this request?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(action),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  String _calculateTotalPrice() {
    double total = products.fold<double>(0, (sum, product) {
      if (product.productPrice == null) return sum;
      return sum +
          ((double.tryParse(product.productPrice!) ?? 0) * product.quantity);
    });
    return total.toStringAsFixed(2);
  }
}
