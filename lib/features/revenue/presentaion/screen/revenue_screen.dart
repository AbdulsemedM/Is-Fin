import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});
  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  String transactionType = 'Cash In';
  DateTime selectedDate = DateTime.now();
  String? selectedCategory;
  String userInput = '';
  String result = '0';

  final List<String> categories = [
    'Salary',
    'Business',
    'Investment',
    'Rent',
    'Food',
    'Transportation',
    'Utilities',
    'Others',
  ];

  final List<String> buttonList = [
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '÷',
    '1',
    '2',
    '3',
    '-',
    '',
    '0',
    '.',
    '+',
    'C',
    '⌫',
    '%',
    '=',
  ];

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        userInput = '';
        result = '0';
        return;
      }

      if (buttonText == '⌫') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
          if (userInput.isEmpty) {
            result = '0';
          }
        }
        return;
      }

      if (buttonText == '=') {
        calculateResult();
        userInput = '';
        return;
      }

      // Handle percentage
      if (buttonText == '%') {
        if (userInput.isEmpty) return;

        try {
          // If it's a simple number, convert to percentage
          if (!userInput.contains(RegExp(r'[+\-×÷]'))) {
            double value = double.parse(userInput) / 100;
            result = value.toString();
            userInput = '';
          } else {
            // Handle percentage in expressions (e.g., 100 + 10%)
            var parts = userInput.split(RegExp(r'([+\-×÷])'));
            var operator = RegExp(r'[+\-×÷]').firstMatch(userInput)?.group(0);
            if (parts.length == 2 && operator != null) {
              double base = double.parse(parts[0]);
              double percentage = double.parse(parts[1]) / 100 * base;

              switch (operator) {
                case '+':
                  result = (base + percentage).toString();
                  break;
                case '-':
                  result = (base - percentage).toString();
                  break;
                case '×':
                  result = (base * percentage).toString();
                  break;
                case '÷':
                  result = (base / percentage).toString();
                  break;
              }
              userInput = '';
            }
          }
        } catch (e) {
          result = 'Error';
        }
        return;
      }

      // For operators (+, -, ×, ÷)
      if (['+', '-', '×', '÷'].contains(buttonText)) {
        if (!userInput.isEmpty &&
            !['+', '-', '×', '÷'].contains(userInput[userInput.length - 1])) {
          calculateResult();
          userInput = result + buttonText;
          result = '0';
        }
        return;
      }

      // For numbers and decimal
      userInput += buttonText;
      if (userInput.contains(RegExp(r'[+\-×÷]'))) {
        calculateResult();
      }
    });
  }

  void calculateResult() {
    if (userInput.isEmpty) {
      result = '0';
      return;
    }

    try {
      String finalUserInput =
          userInput.replaceAll('×', '*').replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      result = evalResult.toStringAsFixed(2);
      if (result.endsWith('.00')) {
        result = result.substring(0, result.length - 3);
      }
    } catch (e) {
      // If we can't evaluate yet, keep the current result
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => transactionType = 'Cash In'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: transactionType == 'Cash In'
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: transactionType == 'Cash In'
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cash In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: transactionType == 'Cash In'
                                    ? Colors.white
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => transactionType = 'Cash Out'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: transactionType == 'Cash Out'
                              ? Colors.redAccent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: transactionType == 'Cash Out'
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cash Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: transactionType == 'Cash Out'
                                    ? Colors.white
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Date Picker
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                'Date: ${selectedDate.toString().split(' ')[0]}',
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),

            const SizedBox(height: 8),

            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),

            const SizedBox(height: 16),

            // Calculator Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Calculator Buttons
            Expanded(
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return CalcButton(
                    buttonList[index],
                    onPressed: () => onButtonPressed(buttonList[index]),
                    color: getButtonColor(buttonList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getButtonColor(String buttonText) {
    if (['C', '⌫'].contains(buttonText)) {
      return Colors.red;
    } else if (['+', '-', '×', '÷', '%', '='].contains(buttonText)) {
      return Colors.blue;
    }
    return Colors.black54;
  }
}

class CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CalcButton(
    this.text, {
    required this.onPressed,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
