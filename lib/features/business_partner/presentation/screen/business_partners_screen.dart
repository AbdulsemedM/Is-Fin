import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/add_bisiness_partner_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/widget/business_partners_card.dart';

class BusinessPartnersScreen extends StatefulWidget {
  const BusinessPartnersScreen({super.key});

  @override
  State<BusinessPartnersScreen> createState() => _BusinessPartnersScreenState();
}

class _BusinessPartnersScreenState extends State<BusinessPartnersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddBisinessPartnerScreen()));
        },
        child: const CircleAvatar(
          backgroundColor: AppColors.primaryDarkColor,
          radius: 30,
          child: Icon(
            size: 35,
            Icons.add_outlined,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Business Partners",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BusinessPartnersCard(
                name: "XYZ Import Export",
                id: "0946514836",
                onAccept: () {},
                onReject: () {}),
            BusinessPartnersCard(
                name: "ABC General Trading",
                id: "0946514836",
                onAccept: () {},
                onReject: () {}),
            BusinessPartnersCard(
                name: "MBC Electronic Trading",
                id: "0946514836",
                onAccept: () {},
                onReject: () {}),
          ],
        ),
      ),
    );
  }
}
