import 'package:flutter/material.dart';

class TableItem {
  final String name;
  final double quantity;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TableItem({
    required this.name,
    required this.quantity,
    required this.onDelete,
    required this.onEdit,
  });
}

class TableWidget extends StatelessWidget {
  final List<TableItem> items;

  const TableWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(40.0),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(60.0),
          3: FixedColumnWidth(40.0), // Delete button
          4: FixedColumnWidth(40.0), // Edit button
        },
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey[300]!),
        ),
        children: [
          // Table header
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[200]),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text('No.', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 40), // Delete button spacing
              SizedBox(width: 40), // Edit button spacing
            ],
          ),
          // Table rows
          for (int i = 0; i < items.length; i++)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((i + 1).toString()), // Auto-generated number
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(items[i].name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(items[i].quantity.toString()),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: items[i].onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: items[i].onDelete,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
