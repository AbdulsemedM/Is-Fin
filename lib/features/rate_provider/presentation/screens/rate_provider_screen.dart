import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/rate_provider/bloc/rate_provider_bloc.dart';
import '../widgets/rating_explanation_widget.dart';
import '../widgets/partner_info_widget.dart';
import '../widgets/rating_stars_widget.dart';
import '../widgets/feedback_input_widget.dart';

class RateProviderScreen extends StatefulWidget {
  final String supplierId;
  final String partnerName;
  final String phoneNumber;

  const RateProviderScreen({
    super.key,
    required this.supplierId,
    required this.partnerName,
    required this.phoneNumber,
  });

  @override
  State<RateProviderScreen> createState() => _RateProviderScreenState();
}

class _RateProviderScreenState extends State<RateProviderScreen> {
  double _rating = 0;
  final _feedbackController = TextEditingController();
  bool _isSubmitting = false;

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

  void _handleSubmit() {
    if (_rating <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating before submitting'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_isSubmitting) {
      context.read<RateProviderBloc>().add(
            RateProviderRate(
              supplierId: widget.supplierId,
              rating: _rating,
              comment: _feedbackController.text.trim(),
            ),
          );
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
      body: BlocConsumer<RateProviderBloc, RateProviderState>(
        listener: (context, state) {
          setState(() {
            _isSubmitting = state is RateProviderLoading;
          });

          if (state is RateProviderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          } else if (state is RateProviderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                    onChanged: (_) {}, // We don't need to handle changes
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isSubmitting
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Submitting...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Text(
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
          );
        },
      ),
    );
  }
}
