import 'package:flutter/material.dart';
import 'infinity_loading_indicator.dart';
import 'app_colors.dart';

class InfinityLoadingDemo extends StatelessWidget {
  const InfinityLoadingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinity Loading Indicator Demo'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.bgColor,
              AppColors.bg1,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Main showcase
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Infinity Loading Indicator',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Inspired by IconScout Design',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const InfinityLoadingIndicator(
                      size: 100.0,
                      duration: Duration(milliseconds: 2000),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Different sizes
              const Text(
                'Different Sizes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      InfinityLoadingIndicator(size: 50.0),
                      SizedBox(height: 8),
                      Text('Small', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      InfinityLoadingIndicator(size: 80.0),
                      SizedBox(height: 8),
                      Text('Medium', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      InfinityLoadingIndicator(size: 120.0),
                      SizedBox(height: 8),
                      Text('Large', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Different colors
              const Text(
                'Different Color Themes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      InfinityLoadingIndicator(
                        size: 70.0,
                        primaryColor: Colors.purple,
                        secondaryColor: Colors.pink,
                      ),
                      SizedBox(height: 8),
                      Text('Purple', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      InfinityLoadingIndicator(
                        size: 70.0,
                        primaryColor: Colors.green,
                        secondaryColor: Colors.lightGreen,
                      ),
                      SizedBox(height: 8),
                      Text('Green', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      InfinityLoadingIndicator(
                        size: 70.0,
                        primaryColor: Colors.orange,
                        secondaryColor: Colors.yellow,
                      ),
                      SizedBox(height: 8),
                      Text('Orange', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Different speeds
              const Text(
                'Different Animation Speeds',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      InfinityLoadingIndicator(
                        size: 60.0,
                        duration: Duration(milliseconds: 1000),
                      ),
                      SizedBox(height: 8),
                      Text('Fast', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      InfinityLoadingIndicator(
                        size: 60.0,
                        duration: Duration(milliseconds: 2000),
                      ),
                      SizedBox(height: 8),
                      Text('Normal', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    children: [
                      InfinityLoadingIndicator(
                        size: 60.0,
                        duration: Duration(milliseconds: 3500),
                      ),
                      SizedBox(height: 8),
                      Text('Slow', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Usage example
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Loading in progress...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const InfinityLoadingIndicator(
                      size: 80.0,
                      duration: Duration(milliseconds: 2200),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Please wait while we process your request. This may take a few moments.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Code example
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Usage Example:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'const InfinityLoadingIndicator(\n'
                      '  size: 80.0,\n'
                      '  primaryColor: Colors.blue,\n'
                      '  secondaryColor: Colors.cyan,\n'
                      '  duration: Duration(milliseconds: 2000),\n'
                      ')',
                      style: TextStyle(
                        color: Color(0xFFD4D4D4),
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
