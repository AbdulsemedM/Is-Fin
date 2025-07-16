import 'package:flutter/material.dart';
import 'package:ifb_loan/features/business_partner/presentation/widget/partner_rating_modal.dart';
import 'package:ifb_loan/features/rate_provider/presentation/screens/rate_provider_screen.dart';

class BusinessPartnersCard extends StatelessWidget {
  final String name;
  final String id;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isRateProvider;
  final bool isViewRatings;

  const BusinessPartnersCard({
    super.key,
    required this.name,
    required this.id,
    required this.onAccept,
    required this.onReject,
    required this.isRateProvider,
    required this.isViewRatings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Accept Icon
          GestureDetector(
            onTap: onAccept,
            child: CircleAvatar(
              backgroundColor: Colors.green[100],
              child: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(width: 12.0),

          // Name and ID
          GestureDetector(
            onTap: () {
              if (isRateProvider) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RateProviderScreen(
                            partnerName: name, phoneNumber: id)));
              }
              if (isViewRatings) {
                PartnerRatingModal.show(
                  context: context,
                  partnerName: name,
                  phoneNumber: id,
                  averageRating: 4.5,
                  totalRatings: 128,
                  ratingDistribution: {
                    5: 65.0, // 65% gave 5 stars
                    4: 20.0, // 20% gave 4 stars
                    3: 10.0, // 10% gave 3 stars
                    2: 3.0, // 3% gave 2 stars
                    1: 2.0, // 2% gave 1 star
                  },
                );
              }
            },
            
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    id,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            
          ),
          const Spacer(),
          // Reject Icon
          GestureDetector(
            onTap: onReject,
            child: CircleAvatar(
              backgroundColor: Colors.red[100],
              child: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
