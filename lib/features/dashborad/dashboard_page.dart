import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/auth_service.dart';
import 'package:ifb_loan/features/finances/presentation/screens/finances_screen.dart';
import 'package:ifb_loan/features/home/presentation/screens/home_screen.dart';
import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';
import 'package:ifb_loan/features/profile/presentation/screens/profile_screen.dart';
import 'package:ifb_loan/features/revenue/presentaion/screen/revenue_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> deleteToken() async {
    final authService = AuthService();
    await authService.deleteToken();
    // print('Token: $token');
  }

  int currentIndex = 0;
  List<Widget> buildScreens() => [
        const HomeScreen(),
        const FinancesScreen(),
        const RevenueScreen(),
        const ProfileScreen()
      ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        body: SafeArea(
          child: buildScreens()[currentIndex],
        ),
        bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: AppColors.primaryDarkColor,
          backgroundColor: AppColors.bgColor,
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text("Home"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.description_outlined),
              title: const Text("Finances"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.calculate_outlined),
              title: const Text("Revenue"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Confirm Logout"),
          content: const Text("Do you want to Logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Show loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  await deleteToken();

                  // Pop loading indicator and navigate
                  if (context.mounted) {
                    Navigator.pop(context); // Pop loading dialog
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false, // This removes all previous routes
                    );
                  }
                } catch (e) {
                  // Handle any errors during logout
                  if (context.mounted) {
                    Navigator.pop(context); // Pop loading dialog
                    displaySnack(context, 'Error logging out', Colors.red);
                  }
                }
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
