import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final Widget iconContainer; // Accepts any widget for the icon container
  final String description;
  final VoidCallback onGetStarted;
  final Color cardColor; // Accepts a color for the entire card background

  const ExpandableCard({
    super.key,
    required this.title,
    required this.iconContainer,
    required this.description,
    required this.onGetStarted,
    this.cardColor = Colors.orange, // Default color if none is provided
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenConfig.screenWidth * 0.6,
      height: _isExpanded ? null : ScreenConfig.screenHeight * 0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: widget.cardColor, // Set card background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  widget.iconContainer, // Display custom icon container
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _isExpanded
                    ? widget.description
                    : '${widget.description.substring(0, 80)}...',
                style: const TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(_isExpanded ? 'Collapse' : 'Expand'),
              ),
              // if (_isExpanded)
              //   ElevatedButton(
              //     onPressed: widget.onGetStarted,
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.black,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: const Text('Get Started'),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
