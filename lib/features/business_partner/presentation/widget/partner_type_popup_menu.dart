import 'package:flutter/material.dart';

class PartnerTypeOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  PartnerTypeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}

class PartnerTypePopupMenu extends StatelessWidget {
  final List<PartnerTypeOption> options;
  final VoidCallback onDismiss;

  const PartnerTypePopupMenu({
    super.key,
    required this.options,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Semi-transparent background
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            // Menu content
            Positioned(
              bottom: 100,
              right: 16,
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Choose Partner Type',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Divider(height: 1),
                    ...options
                        .map((option) => _buildOptionItem(context, option))
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, PartnerTypeOption option) {
    return InkWell(
      onTap: () {
        onDismiss();
        option.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                option.icon,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required VoidCallback onUniversalSelected,
    required VoidCallback onLocalSelected,
  }) {
    final options = [
      PartnerTypeOption(
        title: 'Universal Partner',
        subtitle: 'Partner available for all',
        icon: Icons.public,
        onTap: onUniversalSelected,
      ),
      PartnerTypeOption(
        title: 'Local Partner',
        subtitle: 'Partner available only by phone number',
        icon: Icons.location_on,
        onTap: onLocalSelected,
      ),
    ];

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => PartnerTypePopupMenu(
        options: options,
        onDismiss: () => Navigator.pop(context),
      ),
    );
  }
}
