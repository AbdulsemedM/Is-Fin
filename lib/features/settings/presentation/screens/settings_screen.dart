import 'package:flutter/material.dart';
import 'package:ifb_loan/features/settings/presentation/widgets/settings_sections.dart';
// import 'package:ifb_loan/app/utils/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        children: const [
          ProfileSection(),
          PreferencesSection(),
          SecuritySection(),
          SupportSection(),
          LegalSection(),
          SignOutSection(),
        ],
      ),
    );
  }
}
