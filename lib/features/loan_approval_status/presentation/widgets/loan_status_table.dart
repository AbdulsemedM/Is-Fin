import 'package:flutter/material.dart';

class LoanStatusTable extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const LoanStatusTable({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Grey background color for the table
      padding: const EdgeInsets.all(8.0),
      child: DataTable(
        columnSpacing: 16,
        headingRowColor: WidgetStateColor.resolveWith(
            (states) => Colors.grey[300]!), // Light grey color for header
        columns: const [
          DataColumn(label: Text('No.')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Total')),
        ],
        rows: List<DataRow>.generate(
          items.length,
          (index) {
            final item = items[index];
            return DataRow(
              cells: [
                DataCell(Text((index + 1).toString())), // Auto-generated number
                DataCell(Text(item['name'] ?? '')),
                DataCell(Text(item['quantity'].toString())),
                DataCell(Text(item['total'].toString())),
              ],
            );
          },
        ),
      ),
    );
  }
}
