import 'package:flutter/material.dart';

class TableItem {
  final String name;
  final int quantity;
  final VoidCallback onDelete;

  TableItem({
    required this.name,
    required this.quantity,
    required this.onDelete,
  });
}

class TableWidget extends StatelessWidget {
  final List<TableItem> items;

  const TableWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

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
          3: FixedColumnWidth(40.0),
        },
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey[300]!),
        ),
        children: [
          // Table header
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[200]),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('No.', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 40), // For delete icon spacing
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
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(items[i].quantity.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: items[i].onDelete,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
