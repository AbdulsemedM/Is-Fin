import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/features/provider_loan_form/models/requested_products_model.dart';

class ProductTable extends StatelessWidget {
  final List<RequestedProductsModel> products;
  final Function(RequestedProductsModel) onProductRemove;
  final Function(RequestedProductsModel, String) onProductPrice;

  const ProductTable({
    super.key,
    required this.products,
    required this.onProductRemove,
    required this.onProductPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table headers
        Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Name'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Desc.'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Qnt.'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Price'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 1,
                color: Colors.black,
              ),
              // const Expanded(
              //   flex: 2,
              //   child: Text(
              //     'Remove',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          ),
        ),
        // List of products
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductRow(
                  quantity: product.quantity.toString(),
                  name: product.productName,
                  description: product.description,
                  onRemove: () async {
                    final shouldRemove = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Remove Product'.tr),
                          content: Row(
                            children: [
                              Text('Are you sure you want to remove '.tr),
                              Text(
                                "(${product.productName})?",
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'.tr),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Remove'.tr),
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldRemove == true) {
                      onProductRemove(product);
                    }
                  },
                  onProductPriceChange: (String price) {
                    onProductPrice(product, price);
                  },
                  unitOfMeasurement: product.unitOfMeasurement,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProductRow extends StatefulWidget {
  final String name;
  final String description;
  final String quantity;
  final String unitOfMeasurement;
  final VoidCallback onRemove;
  final Function(String) onProductPriceChange;

  const ProductRow({
    super.key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitOfMeasurement,
    required this.onRemove,
    required this.onProductPriceChange,
  });

  @override
  State<ProductRow> createState() => _ProductRowState();
}

class _ProductRowState extends State<ProductRow> {
  // final FocusNode _focusNode = FocusNode();
  // bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Show the modal dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(widget.name),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Description'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(widget.description),
                    const SizedBox(height: 16),
                    Text(
                      'Quantity'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(widget.quantity),
                    const SizedBox(height: 16),
                    Text(
                      'Unit of measurement'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(widget.unitOfMeasurement),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'.tr),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
              flex: 3,
              child: Text(widget.description),
            ),
            Container(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
              flex: 2,
              child: Text(widget.quantity),
            ),
            Container(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
              flex: 3,
              child: TextField(
                // focusNode: _focusNode,
                // enabled: _isEnabled,
                onTap: () {
                  setState(() {
                    // _isEnabled = true;
                  });
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d*$'),
                  ),
                ],
                onChanged: widget.onProductPriceChange,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Price'.tr,
                ),
              ),
            ),
            Container(
              width: 1,
              color: Colors.black,
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: widget.onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
