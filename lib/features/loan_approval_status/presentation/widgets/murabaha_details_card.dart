import 'package:flutter/material.dart';

class MurabahaDetailsCard extends StatelessWidget {
  final String purchaseCost;
  final String markup;
  final String totalPrice;
  final String duration;
  final String processingFees;

  // ignore: use_super_parameters
  const MurabahaDetailsCard({
    Key? key,
    required this.purchaseCost,
    required this.markup,
    required this.totalPrice,
    required this.duration,
    required this.processingFees,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(context, 'Purchase Cost', purchaseCost),
            const Divider(),
            _buildRow(context, 'Mark up', markup),
            const Divider(),
            _buildRow(context, 'Total Murabaha Price', totalPrice),
            const Divider(),
            _buildRow(context, 'Duration of Financing', duration),
            const Divider(),
            _buildRow(context, 'Processing Fees', processingFees),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey[800],
                ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.teal[700],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
