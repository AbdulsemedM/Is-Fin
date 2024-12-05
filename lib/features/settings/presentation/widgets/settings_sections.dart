import 'package:flutter/material.dart';
import 'package:ifb_loan/features/settings/presentation/widgets/settings_helpers.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Profile'),
        SettingsTile(
          icon: Icons.person_outline,
          title: 'Edit Profile',
          onTap: () {
            // Navigate to edit profile
          },
        ),
        SettingsTile(
          icon: Icons.language,
          title: 'Language',
          subtitle: 'English',
          onTap: () {
            // Show language picker
          },
        ),
      ],
    );
  }
}

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Preferences'),
        SettingsTile(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // Handle notification toggle
            },
          ),
        ),
        SettingsTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // Handle theme toggle
            },
          ),
        ),
      ],
    );
  }
}

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Security'),
        SettingsTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {
            // Navigate to change password
          },
        ),
        SettingsTile(
          icon: Icons.fingerprint,
          title: 'Biometric Authentication',
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // Handle biometric toggle
            },
          ),
        ),
      ],
    );
  }
}

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Support'),
        SettingsTile(
          icon: Icons.help_outline,
          title: 'Help Center',
          onTap: () {
            // Navigate to help center
          },
        ),
        SettingsTile(
          icon: Icons.contact_support_outlined,
          title: 'Contact Us',
          onTap: () {
            // Navigate to contact page
          },
        ),
        SettingsTile(
          icon: Icons.star_outline,
          title: 'Rate App',
          onTap: () {
            // Open app store rating
          },
        ),
      ],
    );
  }
}

class LegalSection extends StatelessWidget {
  const LegalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Legal'),
        SettingsTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () {
            // Navigate to privacy policy
          },
        ),
        SettingsTile(
          icon: Icons.description_outlined,
          title: 'Terms of Service',
          onTap: () {
            // Navigate to terms
          },
        ),
      ],
    );
  }
}

class SignOutSection extends StatelessWidget {
  const SignOutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Account'),
        SettingsTile(
          icon: Icons.logout,
          title: 'Sign Out',
          textColor: Colors.red,
          onTap: () async {
            final confirmed = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('Are you sure you want to sign out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            );
            print(confirmed);
            // if (confirmed == true) {
            //   await UserManager().logout();
            //   // Navigate to login screen
            // }
          },
        ),
      ],
    );
  }
}
