import 'package:flutter/material.dart';

// This page displays the terms and conditions with a theme
// that matches the provided orders_page.dart.
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The main scaffold for the page, using the same background color.
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),
      // The app bar mirrors the design of the My Bookings page.
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Color(0xFF002A42),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // Custom leading widget to style the back button
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 190, 189, 189).withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF002A42)),
              onPressed: () {
                // This command handles going back to the previous page
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      // A scrollable body to accommodate the long text.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Title and last updated date, styled to match the theme.
            Text(
              'TERMS AND CONDITIONS',
              style: TextStyle(
                fontSize: 26,
                color: const Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated August 15, 2025',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            // Main content section, with headings and body text.
            Text(
              'AGREEMENT TO OUR LEGAL TERMS',
              style: TextStyle(
                fontSize: 19,
                color: const Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We are Smart Cargo ("Company," "we," "us," "our") operating the mobile application Smart Cargo (the "App"), as well as any other related products and services that refer or link to these legal terms (the "Legal Terms") (collectively, the "Services").',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You can contact us by email at diomclee@gmail.com or by mail to Dar es salaam, Tanzania.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text:
                        'These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity ("you"), and Smart Cargo, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. ',
                  ),
                  TextSpan(
                    text:
                        'IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFDB7D00),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We will provide you with prior notice of any scheduled changes to the Services you are using. The modified Legal Terms will become effective upon posting or notifying you by email, as stated in the email message. By continuing to use the Services after the effective date of any changes, you agree to be bound by the modified terms.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The Services are intended for users who are at least 13 years of age. All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Services. If you are a minor, you must have your parent or guardian read and agree to these Legal Terms prior to you using the Services.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We recommend that you print a copy of these Legal Terms for your records.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // Table of Contents section.
            Text(
              'TABLE OF CONTENTS',
              style: TextStyle(
                fontSize: 19,
                color: const Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTocItem(
                '1. OUR SERVICES'),
            _buildTocItem(
                '2. INTELLECTUAL PROPERTY RIGHTS'),
            _buildTocItem(
                '3. USER REPRESENTATIONS'),
            _buildTocItem(
                '4. USER REGISTRATION'),
            _buildTocItem(
                '5. PURCHASES AND PAYMENT'),
            _buildTocItem(
                '6. SUBSCRIPTIONS'),
            _buildTocItem(
                '7. POLICY'),
            _buildTocItem(
                '8. PROHIBITED ACTIVITIES'),
            _buildTocItem(
                '9. USER GENERATED CONTRIBUTIONS'),
            _buildTocItem(
                '10. CONTRIBUTION LICENSE'),
            _buildTocItem(
                '11. GUIDELINES FOR REVIEWS'),
            _buildTocItem(
                '12. MOBILE APPLICATION LICENSE'),
            _buildTocItem(
                '13. SERVICES MANAGEMENT'),
            _buildTocItem(
                '14. PRIVACY POLICY'),
            _buildTocItem(
                '15. COPYRIGHT INFRINGEMENTS'),
            _buildTocItem(
                '16. TERM AND TERMINATION'),
            _buildTocItem(
                '17. MODIFICATIONS AND INTERRUPTIONS'),
            _buildTocItem(
                '18. GOVERNING LAW'),
            _buildTocItem(
                '19. DISPUTE RESOLUTION'),
            _buildTocItem(
                '20. CORRECTIONS'),
            _buildTocItem(
                '21. DISCLAIMER'),
            _buildTocItem(
                '22. LIMITATIONS OF LIABILITY'),
            _buildTocItem(
                '23. INDEMNIFICATION'),
            _buildTocItem(
                '24. USER DATA'),
            _buildTocItem(
                '25. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES'),
            _buildTocItem(
                '26. MISCELLANEOUS'),
            _buildTocItem(
                '27. CONTACT US'),
            const SizedBox(height: 24),
            // First section of the content.
            Text(
              '1. OUR SERVICES',
              style: TextStyle(
                fontSize: 19,
                color: const Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The information provided when using the Services is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Services from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '2. INTELLECTUAL PROPERTY RIGHTS',
              style: TextStyle(
                fontSize: 19,
                color: const Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Our intellectual property',
              style: TextStyle(
                fontSize: 17,
                color: const Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We are the owner or the licensee of all intellectual property rights in our Services, including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics in the Services (collectively, the "Content"), as well as the trademarks, service marks, and logos contained therein (the "Marks").',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Our Content and Marks are protected by copyright and trademark laws (and various other intellectual property rights and unfair competition laws) and treaties around the world.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The Content and Marks are provided in or through the Services "AS IS" for your personal, non-commercial use or internal business purpose only.',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A helper method to build the Table of Contents list items.
  Widget _buildTocItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFDB7D00),
          fontSize: 15,
        ),
      ),
    );
  }
}