import 'package:flutter/material.dart';

class ProductTable extends StatelessWidget {
  final List<Map<String, String>> products;

  const ProductTable({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table headers
        Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(8.0),
          child: const Row(
            children: [
              Expanded(
                  child: Text('Name',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text('Desc.',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  name: product['name'] ?? '',
                  description: product['description'] ?? '',
                  onRemove: () {
                    // Handle product removal
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProductRow extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onRemove;

  const ProductRow({super.key, 
    required this.name,
    required this.description,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Product name and quantity
          Expanded(
            child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          // Product description
          Expanded(
            child: Text(description),
          ),
          // Price text field and delete button
          Row(
            children: [
              SizedBox(
                width: 80,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
