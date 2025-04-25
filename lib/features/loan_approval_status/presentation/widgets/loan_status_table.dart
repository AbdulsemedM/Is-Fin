import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/features/loan_approval_status/model/offered_products_price_model.dart';
import 'package:intl/intl.dart';

class LoanStatusTable extends StatelessWidget {
  final List<OfferedProductsPriceModel> items;
  final Function(OfferedProductsPriceModel) onProductRemove;
  final Function(OfferedProductsPriceModel, String) onProductQuantityChange;

  const LoanStatusTable({
    super.key,
    required this.items,
    required this.onProductRemove,
    required this.onProductQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: DataTable(
        columnSpacing: 16,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.grey[300]!),
        columns: [
          // DataColumn(label: Text('No.')),
          DataColumn(label: Text('Name'.tr)),
          DataColumn(label: Text('Quantity'.tr)),
          DataColumn(label: Text('Total'.tr)),
          DataColumn(label: Text('Actions'.tr)),
        ],
        rows: List<DataRow>.generate(
          items.length,
          (index) {
            final item = items[index];
            return DataRow(
              onSelectChanged: (_) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(item.productName),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Product Name: '.tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: item.productName,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Unit Price: '.tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: NumberFormat('#,###')
                                    .format(item.productPrice),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Quantity: '.tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: item.quantity.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total: '.tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: NumberFormat('#,###')
                                    .format(item.productPrice * item.quantity),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'.tr),
                      ),
                    ],
                  ),
                );
              },
              cells: [
                // DataCell(Text((index + 1).toString())),
                DataCell(Text(item.productName)),
                DataCell(Text(item.quantity.toString())),
                DataCell(Text(NumberFormat('#,###')
                    .format(item.productPrice * item.quantity))),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () {
                          final TextEditingController quantityController =
                              TextEditingController(
                            text: item.quantity.toString(),
                          );

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Edit Quantity'.tr),
                              content: TextField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Quantity'.tr,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onProductQuantityChange(
                                        item, quantityController.text);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Save'.tr),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            size: 20, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Product'.tr),
                              content: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Are you sure you want to delete '.tr,
                                    ),
                                    TextSpan(
                                      text: item.productName,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onProductRemove(item);
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: Text('Delete'.tr),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
