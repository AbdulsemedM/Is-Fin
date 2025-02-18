import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _skipToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                context,
                animationPath: 'assets/animation/animation1.json',
                title: 'Fill your Info, Get Verified',
                description:
                    'Provide your details to complete verification quickly and unlock full access. It\'s simple and secure',
              ),
              _buildPage(
                context,
                animationPath: 'assets/animation/animation2.json',
                title: 'Get your finance fast and hassle-free',
                description:
                    'Apply in minutes and enjoy quick approval with a seamless process designed just for you!',
              ),
              _buildPage(
                context,
                animationPath: 'assets/animation/animation3.json',
                title: 'Empowering Communities, Transforming Lives',
                description:
                    'Making a difference by uplifting individuals and strengthening communities.',
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: _skipToLogin,
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button (Hidden on First Page)
                if (_currentPage > 0)
                  IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  )
                else
                  const SizedBox(width: 48), // Placeholder to align buttons
                // Forward or Navigation Button
                IconButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _skipToLogin(); // Navigate to Login if it's the last page
                    }
                  },
                  icon: Icon(
                    _currentPage < 2
                        ? Icons.arrow_forward_ios
                        : Icons.check_circle, // Check icon on the last page
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required String animationPath,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animationPath, height: 300),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
