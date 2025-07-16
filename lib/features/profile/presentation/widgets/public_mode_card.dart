import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class PublicModeCard extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;

  const PublicModeCard({
    Key? key,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PublicModeCard> createState() => _PublicModeCardState();
}

class _PublicModeCardState extends State<PublicModeCard> {
  late bool _isPublicMode;

  @override
  void initState() {
    super.initState();
    _isPublicMode = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _isPublicMode ? Icons.public : Icons.privacy_tip,
                color: AppColors.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    _isPublicMode ? 'Public Mode' : 'Private Mode',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDarkColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Switch to public mode for better visibility',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _isPublicMode,
              onChanged: (value) {
                setState(() {
                  _isPublicMode = value;
                });
                widget.onChanged(value);
              },
              activeColor: AppColors.primaryColor,
              activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
