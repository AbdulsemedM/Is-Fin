import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/finances/presentation/screens/finances_screen.dart';
import 'package:ifb_loan/features/home/presentation/screens/home_screen.dart';
import 'package:ifb_loan/features/profile/presentation/screens/profile_screen.dart';
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

  int currentIndex = 0;
  List<Widget> buildScreens() =>
      [const HomeScreen(), const FinancesScreen(), const ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: buildScreens()[currentIndex],
        ),
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
            icon: Icon(Icons.home_outlined),
            title: Text("Home"),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.description_outlined),
            title: Text("Finances"),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
