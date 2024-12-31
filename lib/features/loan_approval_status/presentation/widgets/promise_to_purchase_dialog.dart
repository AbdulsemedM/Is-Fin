import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromiseToPurchaseDialog extends StatefulWidget {
  final String agreementText;

  const PromiseToPurchaseDialog({
    super.key,
    required this.agreementText,
  });

  @override
  State<PromiseToPurchaseDialog> createState() =>
      _PromiseToPurchaseDialogState();
}

class _PromiseToPurchaseDialogState extends State<PromiseToPurchaseDialog> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        // Check if we are at the bottom
        _isAtBottom = _scrollController.offset >=
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1, // 90% of screen width
        height: MediaQuery.of(context).size.height * 1, // 85% of screen height
        child: Column(
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Promise to Purchase Agreement".tr,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            // Agreement Text
            Expanded(
              child: Stack(
                children: [
                  // Scrollable Content
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.agreementText,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // Downward Arrow
                  if (!_isAtBottom)
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        onPressed: _scrollToBottom,
                        child: const Icon(Icons.arrow_downward,
                            color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Dismiss dialog
                    },
                    child: Text("Cancel".tr),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Agreement confirmed
                    },
                    child: Text("Agree".tr),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
