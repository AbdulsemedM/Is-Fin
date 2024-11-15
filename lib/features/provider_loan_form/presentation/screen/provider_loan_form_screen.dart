import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_product_price_prompt.dart';

class ProviderLoanFormScreen extends StatefulWidget {
  const ProviderLoanFormScreen({super.key});

  @override
  State<ProviderLoanFormScreen> createState() => _ProviderLoanFormScreenState();
}

class _ProviderLoanFormScreenState extends State<ProviderLoanFormScreen> {
  final List<Map<String, String>> products = [
    {'name': 'Laptop (x3)', 'description': 'realme Core i5 1 TB by 12GB RAM'},
    {
      'name': 'Tablet Phone (x10)',
      'description': 'iPad 5th generation 6” 500 GB by 12GB RAM'
    },
    {
      'name': 'Smart Phone (x7)',
      'description': 'Samsung S21 5G 500 GB by 16GB RAM'
    },
    {'name': 'Smart TV (x10)', 'description': 'LG android 54’'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Owner Form",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child:
                    Text("Fill product prices form for Abdulsemed's request"),
              )),
              SizedBox(
                  height: ScreenConfig.screenHeight * 0.4,
                  child: ProductTable(products: products)),
                  
            ],
          ),
        ),
      ),
    );
  }
}
