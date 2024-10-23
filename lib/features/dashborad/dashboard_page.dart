import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/finances/presentation/screens/finances_screen.dart';
import 'package:ifb_loan/features/home/presentation/screens/home_screen.dart';
import 'package:ifb_loan/features/profile/presentation/screens/profile_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      bottomNavigationBar: BottomNavyBar(
        showInactiveTitle: true,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        iconSize: 20,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text(
                'Home',
                style: TextStyle(
                    color: currentIndex == 0
                        ? AppColors.primaryDarkColor
                        : AppColors.secondaryTextColor),
              ),
              activeColor: AppColors.primaryDarkColor,
              textAlign: TextAlign.start,
              inactiveColor: AppColors.secondaryTextColor),
          BottomNavyBarItem(
              icon: Icon(Icons.attach_money_outlined),
              title: Text(
                'Finances',
                style: TextStyle(
                    color: currentIndex == 1
                        ? AppColors.primaryDarkColor
                        : AppColors.secondaryTextColor),
              ),
              activeColor: AppColors.primaryDarkColor,
              textAlign: TextAlign.start,
              inactiveColor: AppColors.secondaryTextColor),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                  color: currentIndex == 2
                      ? AppColors.primaryDarkColor
                      : AppColors.secondaryTextColor),
            ),
            activeColor: AppColors.primaryDarkColor,
            inactiveColor: AppColors.secondaryTextColor,
            textAlign: TextAlign.start,
          ),
          // BottomNavyBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   activeColor: Colors.blue,
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
