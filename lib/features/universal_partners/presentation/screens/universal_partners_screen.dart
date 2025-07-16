import 'package:flutter/material.dart';
import '../../models/universal_partner.dart';
import '../widgets/universal_partner_card.dart';
import '../../../business_partner/presentation/widget/partner_rating_modal.dart';

class UniversalPartnersScreen extends StatefulWidget {
  const UniversalPartnersScreen({super.key});

  @override
  State<UniversalPartnersScreen> createState() => _UniversalPartnersScreenState();
}

class _UniversalPartnersScreenState extends State<UniversalPartnersScreen> {
  late List<UniversalPartner> partners;

  @override
  void initState() {
    super.initState();
    partners = UniversalPartner.getDummyPartners();
  }

  void _handleToggleAdd(String partnerId) {
    setState(() {
      partners = partners.map((partner) {
        if (partner.id == partnerId) {
          return UniversalPartner(
            id: partner.id,
            name: partner.name,
            phoneNumber: partner.phoneNumber,
            rating: partner.rating,
            sector: partner.sector,
            address: partner.address,
            isAdded: !partner.isAdded,
            totalRatings: partner.totalRatings,
          );
        }
        return partner;
      }).toList();
    });
  }

  void _showRatingModal(UniversalPartner partner) {
    PartnerRatingModal.show(
      context: context,
      partnerName: partner.name,
      phoneNumber: partner.phoneNumber,
      averageRating: partner.rating,
      totalRatings: partner.totalRatings,
      ratingDistribution: {
        5: 65.0,
        4: 20.0,
        3: 10.0,
        2: 3.0,
        1: 2.0,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Universal Partners',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: partners.length,
        itemBuilder: (context, index) {
          final partner = partners[index];
          return UniversalPartnerCard(
            partner: partner,
            onToggleAdd: () => _handleToggleAdd(partner.id),
            onTap: () => _showRatingModal(partner),
          );
        },
      ),
    );
  }
}
