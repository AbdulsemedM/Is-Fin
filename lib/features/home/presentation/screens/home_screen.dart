import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Abdu!",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text("Have a nice day!"),
                ],
              ),
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Center(
                  child: Icon(Icons.person),
                ),
              )
            ],
          ),
          // )
          SizedBox(
            height: ScreenConfig.screenHeight * 0.04,
          ),
          Text(
            "Coop Bank's Sharia compliant financing products.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ScreenConfig.screenHeight * 0.01),
          Text(
            textAlign: TextAlign.center,
            "Coop Bank has developed a Sharia-compliant digital product aimed at providing ethical financial services that adhere to Islamic principles, ensuring all transactions are transparent, interest-free, and align with the values of fairness and social responsibility.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.6),
          )
        ],
      ),
    );
  }
}
