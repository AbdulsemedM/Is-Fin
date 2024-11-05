import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/finances_widget.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              "Finances",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: ScreenConfig.screenHeight * 0.4,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return FinancesCard(
                  icon: Icons.file_copy,
                  iconContainerColor: index == 0
                      ? Colors.blue.shade200
                      : index == 1
                          ? Colors.orange.shade200
                          : index == 2
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                  title: index == 0
                      ? "Loan Request"
                      : index == 1
                          ? "Loan Repay"
                          : index == 2
                              ? "Loan Status"
                              : "Add Provider",
                  subtitle: 'Subtitle $index',
                  containerColor: index == 0
                      ? Colors.blue.shade100
                      : index == 1
                          ? Colors.orange.shade100
                          : index == 2
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                  onTap: () {},
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
