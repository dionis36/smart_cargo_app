import 'package:flutter/material.dart';
import 'package:retailfleet/langs/localization_keys.dart';
import 'package:retailfleet/screens/mainScreen.dart';
import 'package:retailfleet/screens/terms_conditions_page.dart';
import 'package:easy_localization/easy_localization.dart';

// Reusable PlaceholderPage for dummy navigation targets,
// styled to match orders_page.dart.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    Key? key,
    required this.title,
    required this.iconData,
    required this.description,
    required this.badgeText,
    required this.gradientColors,
    required this.badgeColor,
  }) : super(key: key);

  final Color badgeColor;
  final String badgeText;
  final String description;
  final List<Color> gradientColors;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6), // Consistent light background
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF002A42), // Dark blue text
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white, // White app bar background
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(color: Color(0xFF002A42)), // Dark blue back icon
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors, // Dynamic gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.3), // Shadow from first gradient color
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                iconData, // Dynamic icon
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                color: Color(0xFF002A42),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1), // Dynamic badge color with opacity
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  color: badgeColor, // Dynamic badge text color
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLanguageSelectionVisible = false;
  // Use `late` to declare the variable so it can be initialized later
  late String _selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize _selectedLanguage here based on the current locale
    final currentLocale = context.locale.languageCode;
    if (currentLocale == 'en') {
      _selectedLanguage = 'English';
    } else if (currentLocale == 'sw') {
      _selectedLanguage = 'Swahili';
    } else {
      _selectedLanguage = 'English'; // Fallback to English
    }
  }

  // Builds the custom app bar for the profile page
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 189, 189).withOpacity(0.3), // Slightly transparent white for the button background
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Color(0xFF002A42)),
            ),
          ),
          SizedBox(width: 8,),
          Text(
            LocalizationKeys.profile.tr(), // Use the localization key
            style: const TextStyle(
              color: Color(0xFF002A42),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Builds the profile picture and name section
  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Color(0xFFDB7D00), // White background for the profile image border effect
          child: CircleAvatar(
            radius: 56,
            backgroundColor: Color(0xFFDB7D00), // Slightly smaller radius to show the white border
            // You can replace this with an AssetImage if you have a profile image asset:
            // backgroundImage: AssetImage('lib/images/profile_avatar.png'),
            child: Icon(Icons.person, size: 80, color: const Color(0xFF002A42)), // Orange person icon from app theme
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'User Wan', // Profile name, can be changed to a dynamic value if available
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002A42), // Dark blue from app theme
          ),
        ),
        // Removed 'UI/UX Designer' as per request
      ],
    );
  }

  // Builds the container holding all the profile options
  Widget _buildProfileOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Subtle shadow for depth
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionTile(
            Icons.edit,
            LocalizationKeys.editProfile, // Use the localization key
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaceholderPage(
                    title: 'Edit Profile',
                    iconData: Icons.edit,
                    description: 'Manage your personal information and account settings.',
                    badgeText: 'Coming Soon',
                    gradientColors: [Color(0xFF002A42), Color(0xFF003A5C)], // Blue gradient
                    badgeColor: Color(0xFF002A42),
                  ),
                ),
              );
            },
          ),
          _buildOptionTile(
            Icons.history,
            LocalizationKeys.orderHistory, // Use the localization key
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaceholderPage(
                    title: 'Order History',
                    iconData: Icons.receipt_long_outlined,
                    description: 'Track and manage all your deliveries\nin one convenient place',
                    badgeText: 'Coming Soon',
                    gradientColors: [Color(0xFFDB7D00), Color(0xFFFF8C00)], // Orange gradient
                    badgeColor: Color(0xFFDB7D00),
                  ),
                ),
              );
            },
          ),
          _buildOptionTile(
            Icons.notifications,
            LocalizationKeys.notifications, // Use the localization key
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaceholderPage(
                    title: 'Notifications',
                    iconData: Icons.notifications_outlined,
                    description: 'View your alerts and updates related to your orders and account.',
                    badgeText: 'Coming Soon',
                    gradientColors: [Color(0xFFDB7D00), Color(0xFFFF8C00)],
                    badgeColor: Color(0xFFDB7D00),
                  ),
                ),
              );
            },
          ),
          _buildOptionTile(
            Icons.location_on,
            LocalizationKeys.pickupInformation, // Use the localization key
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaceholderPage(
                    title: 'Pick Up Information',
                    iconData: Icons.location_on_outlined,
                    description: 'Manage your preferred pickup locations and details.',
                    badgeText: 'Coming Soon',
                    gradientColors: [Color(0xFF002A42), Color(0xFF003A5C)],
                    badgeColor: Color(0xFF002A42),
                  ),
                ),
              );
            },
          ),
          _buildOptionTile(
            Icons.security,
            LocalizationKeys.privacySecurity, // Use the localization key
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaceholderPage(
                    title: 'Privacy & Security',
                    iconData: Icons.security,
                    description: 'Adjust your privacy settings and review security measures.',
                    badgeText: 'Coming Soon',
                    gradientColors: [Color(0xFF002A42), Color(0xFF003A5C)],
                    badgeColor: Color(0xFF002A42),
                  ),
                ),
              );
            },
          ),
          // terms and conditions
          _buildOptionTile(
            Icons.policy,
            LocalizationKeys.termsConditions, // Use the localization key
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndConditionsPage(),
                ),
              );
            },
          ),
          // Language selection option with expansion
          _buildLanguageSelectionTile(),
        ],
      ),
    );
  }

  // Helper function to build a single profile option tile
  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFDB7D00).withOpacity(0.1), // Orange accent from home_page with opacity
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFFDB7D00), size: 20), // Orange icon
      ),
      title: Text(
        title.tr(), // Call .tr() on the title string
        style: const TextStyle(
          color: Color(0xFF002A42), // Dark blue from app theme
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF9CA3AF), size: 16), // Gray arrow
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  // Builds the "Select Language" tile and its expanding content
  Widget _buildLanguageSelectionTile() {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFDB7D00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.language, color: Color(0xFFDB7D00), size: 20),
          ),
          title: Text(
            LocalizationKeys.selectLanguage.tr(), // Localize 'Select Language'
            style: const TextStyle(
              color: Color(0xFF002A42),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            _isLanguageSelectionVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, // Change icon based on expansion
            color: const Color(0xFF9CA3AF),
            size: 24,
          ),
          onTap: () {
            setState(() {
              _isLanguageSelectionVisible = !_isLanguageSelectionVisible; // Toggle visibility
            });
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
        // The expanding section for language options
        Visibility(
          visible: _isLanguageSelectionVisible,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                _buildLanguageButton('English'), // Button for English
                const SizedBox(height: 10),
                _buildLanguageButton('Swahili'), // Button for Swahili
                const SizedBox(height: 20),
                _buildConfirmChangesButton(), // Button to confirm language selection
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to build a language selection button
  Widget _buildLanguageButton(String language) {
    bool isSelected = _selectedLanguage == language;
    String flagAssetPath = ''; // Add a variable to hold the flag's asset path

    // Map the language to its corresponding flag asset
    if (language == 'English') {
      flagAssetPath = 'lib/images/english.png'; // Make sure to use the correct path
    } else if (language == 'Swahili') {
      flagAssetPath = 'lib/images/swahili.png'; // Make sure to use the correct path
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDB7D00) : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFFDB7D00) : Colors.grey.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min, // Use min size to wrap content
            children: [
              // Display the flag image
              Image.asset(
                flagAssetPath,
                width: 24, // Adjust size as needed
                height: 24,
              ),
              const SizedBox(width: 8), // Spacing between flag and text
              Text(
                language,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF002A42),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the "Confirm Changes" button
  Widget _buildConfirmChangesButton() {
    return GestureDetector(
      onTap: () {
        // Set the locale based on the selected language without country codes
        if (_selectedLanguage == 'English') {
          context.setLocale(const Locale('en'));
        } else if (_selectedLanguage == 'Swahili') {
          context.setLocale(const Locale('sw'));
        }
        _showConfirmationDialog(); // Now show the confirmation dialog
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF002A42), Color(0xFF003A5C)], // Dark blue gradient from app theme
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF002A42).withOpacity(0.3), // Shadow for the button
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            LocalizationKeys.confirmChanges.tr(), // Localize 'Confirm Changes'
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  // Shows a professional confirmation dialog using AlertDialog
void _showConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Color(0xFF10B981), size: 28),
            const SizedBox(width: 10),
            Text(
              LocalizationKeys.languageUpdated.tr(), // Correctly localized
              style: const TextStyle(color: Color(0xFF002A42), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          // Correctly localize and pass the language name as an argument
          LocalizationKeys.confirmationMessage.tr(args: [_selectedLanguage]),
          style: const TextStyle(color: Color(0xFF64748B)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _isLanguageSelectionVisible = false;
              });
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFFDB7D00), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED), // Light background consistent with home_page
      body: Stack(
        children: [
          // Top curved background section (uses app's dark blue gradient)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250, // Height of the background
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildAppBar(context), // Custom AppBar with back button and title
                  _buildProfileHeader(), // Profile picture and name
                  const SizedBox(height: 20),
                  _buildProfileOptions(), // List of interactive profile options
                  const SizedBox(height: 20), // Space before bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}