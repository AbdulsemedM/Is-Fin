import 'package:flutter/material.dart';
import 'package:ifb_loan/features/revenue/presentaion/screen/revenue_calculator_screen.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  final List<Map<String, dynamic>> _entries = [
    {'date': '2024-12-01', 'type': 'Cash In', 'amount': '\$500'},
    {'date': '2024-12-01', 'type': 'Cash Out', 'amount': '\$200'},
    {'date': '2024-12-02', 'type': 'Cash In', 'amount': '\$300'},
  ];

  Map<String, List<Map<String, dynamic>>> _groupEntriesByDate() {
    final groupedEntries = <String, List<Map<String, dynamic>>>{};
    for (var entry in _entries) {
      groupedEntries.putIfAbsent(entry['date'], () => []).add(entry);
    }
    return groupedEntries;
  }

  @override
  Widget build(BuildContext context) {
    final groupedEntries = _groupEntriesByDate();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Revenue Manager'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: groupedEntries.isEmpty
            ? const Center(child: Text('No entries yet.'))
            : ListView.builder(
                itemCount: groupedEntries.keys.length,
                itemBuilder: (context, index) {
                  final date = groupedEntries.keys.elementAt(index);
                  final entries = groupedEntries[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...entries.map((entry) => Card(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Icon(
                                entry['type'] == 'Cash In'
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: entry['type'] == 'Cash In'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              title: Text(entry['type']!),
                              trailing: Text(
                                entry['amount']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RevenueCalculatorScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
