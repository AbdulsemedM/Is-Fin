import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/provider_loan_form/bloc/provider_loan_form_bloc.dart';
import 'package:ifb_loan/features/provider_loan_form/models/requested_products_model.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_product_price_prompt.dart';

class ProviderLoanFormScreen extends StatefulWidget {
  final String id;
  const ProviderLoanFormScreen({super.key, required this.id});

  @override
  State<ProviderLoanFormScreen> createState() => _ProviderLoanFormScreenState();
}

class _ProviderLoanFormScreenState extends State<ProviderLoanFormScreen> {
  // Add list to store products from API
  List<RequestedProductsModel> products = [];

  @override
  void initState() {
    super.initState();
    context
        .read<ProviderLoanFormBloc>()
        .add(FetchRequestedProductsById(widget.id));
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
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                        "Fill product prices form for Abdulsemed's request"),
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

                    return SizedBox(
                      height: ScreenConfig.screenHeight * 0.4,
                      child: ProductTable(products: products),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
