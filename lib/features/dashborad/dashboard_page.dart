import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          AppColors.primaryDarkColor, // Change to your preferred color
      statusBarIconBrightness:
          Brightness.light, // For light icons on dark background
      statusBarBrightness: Brightness.dark, // Adjust for iOS
    ));
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
          // BottomNavyBarItem(
          //     icon: Icon(Icons.home_outlined),
          //     title: Text(
          //       'Home',
          //       style: TextStyle(
          //           color: currentIndex == 0
          //               ? AppColors.primaryDarkColor
          //               : AppColors.secondaryTextColor),
          //     ),
          //     activeColor: AppColors.primaryDarkColor,
          //     textAlign: TextAlign.start,
          //     inactiveColor: AppColors.secondaryTextColor),
          // BottomNavyBarItem(
          //     icon: Icon(Icons.attach_money_outlined),
          //     title: Text(
          //       'Finances',
          //       style: TextStyle(
          //           color: currentIndex == 1
          //               ? AppColors.primaryDarkColor
          //               : AppColors.secondaryTextColor),
          //     ),
          //     activeColor: AppColors.primaryDarkColor,
          //     textAlign: TextAlign.start,
          //     inactiveColor: AppColors.secondaryTextColor),
          // BottomNavyBarItem(
          //   icon: Icon(Icons.person),
          //   title: Text(
          //     'Profile',
          //     style: TextStyle(
          //         color: currentIndex == 2
          //             ? AppColors.primaryDarkColor
          //             : AppColors.secondaryTextColor),
          //   ),
          //   activeColor: AppColors.primaryDarkColor,
          //   inactiveColor: AppColors.secondaryTextColor,
          //   textAlign: TextAlign.start,
          // ),
          // // BottomNavyBarItem(
          // //   icon: Icon(Icons.settings),
          // //   title: Text('Settings'),
          // //   activeColor: Colors.blue,
          // //   textAlign: TextAlign.center,
          // // ),
        ],
      ),
    );
  }
}
