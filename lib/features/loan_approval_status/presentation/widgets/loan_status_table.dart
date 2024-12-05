import 'package:flutter/material.dart';
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
      color: Colors.grey[200], // Grey background color for the table
      // padding: const EdgeInsets.all(8.0),
      child: DataTable(
        columnSpacing: 16,
        headingRowColor: WidgetStateColor.resolveWith(
            (states) => Colors.grey[300]!), // Light grey color for header
        columns: const [
          // DataColumn(label: Text('No.')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Actions')),
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
                        Text('Product Name: ${item.productName}'),
                        const SizedBox(height: 8),
                        Text(
                            'Unit Price: ${NumberFormat('#,###').format(item.productPrice)}'),
                        const SizedBox(height: 8),
                        Text('Quantity: ${item.quantity}'),
                        const SizedBox(height: 8),
                        Text(
                            'Total: ${NumberFormat('#,###').format(item.productPrice * item.quantity)}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
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
                              title: const Text('Edit Quantity'),
                              content: TextField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onProductQuantityChange(
                                        item, quantityController.text);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
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
                              title: const Text('Delete Product'),
                              content: Text(
                                  'Are you sure you want to delete ${item.productName}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onProductRemove(item);
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Delete'),
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
