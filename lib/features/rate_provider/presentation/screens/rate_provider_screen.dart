import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import '../widgets/rating_explanation_widget.dart';
import '../widgets/partner_info_widget.dart';
import '../widgets/rating_stars_widget.dart';
import '../widgets/feedback_input_widget.dart';

class RateProviderScreen extends StatefulWidget {
  final String partnerName;
  final String phoneNumber;

  const RateProviderScreen({
    super.key,
    required this.partnerName,
    required this.phoneNumber,
  });

  @override
  State<RateProviderScreen> createState() => _RateProviderScreenState();
}

class _RateProviderScreenState extends State<RateProviderScreen> {
  double _rating = 0;
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _handleRatingChanged(double rating) {
    setState(() {
      _rating = rating;
    });
  }

  void _handleFeedbackChanged(String feedback) {
    // Handle feedback changes
  }

  void _handleSubmit() {
    // TODO: Implement submission logic
    if (_rating > 0) {
      // Submit rating and feedback
      print('Rating: $_rating');
      print('Feedback: ${_feedbackController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rate Provider',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PartnerInfoWidget(
                partnerName: widget.partnerName,
                phoneNumber: widget.phoneNumber,
              ),
              const SizedBox(height: 24),
              const RatingExplanationWidget(),
              const SizedBox(height: 32),
              RatingStarsWidget(
                rating: _rating,
                onRatingChanged: _handleRatingChanged,
              ),
              const SizedBox(height: 32),
              FeedbackInputWidget(
                controller: _feedbackController,
                onChanged: _handleFeedbackChanged,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _rating > 0 ? _handleSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
