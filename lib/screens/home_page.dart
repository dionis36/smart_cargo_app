import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:retailfleet/screens/parcel_booking.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      drawer: _buildDrawer(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section with Blur Container
              Container(
                decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // A darker, less transparent shadow
                    blurRadius: 10,
                    spreadRadius: -5, // A negative value "pinches" the shadow inwards
                    offset: Offset(0, 10), // Moves the shadow down, creating a larger gap at the top
                  ),
                ],
              ),
                child: Stack(
                  children: [
                    // Background Image with rounded bottom corners
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: AssetImage('lib/images/homeBg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    // Subtle Gradient Overlay (lighter to keep image visible)
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                    
                    // Header with Menu and Date
                    Positioned(
                      top: 16,
                      left: 20,
                      right: 20,
                      child: Row(
                        children: [
                          Builder(
                            builder: (context) => GestureDetector(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'date_sunday'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Blur Container with Brand Info - Full width with rounded top corners
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delivery_dining,
                                      color: Color(0xFFDB7D00),
                                      size: 50,
                                    ),
                                    SizedBox(width: 16,),
                                    Text(
                                      'smart_cargo'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'fastest_delivery_description'.tr(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.95),
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Track Package Section
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    
                    // Quick Track Widget
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF002A42), Color(0xFF003A5C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF002A42).withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFDB7D00).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.track_changes,
                                  color: Color(0xFFDB7D00),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'track_your_package'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'enter_tracking_number'.tr(),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'enter_receipt_number'.tr(),
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF002A42),
                                  size: 20,
                                ),
                                suffixIcon: Container(
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDB7D00),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // SizedBox(height: 22),
                    
                    // Statistics Row
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: _buildStatCard('Active Orders', '12', Icons.local_shipping),
                    //     ),
                    //     SizedBox(width: 16),
                    //     Expanded(
                    //       child: _buildStatCard('Delivered', '145', Icons.check_circle),
                    //     ),
                    //     SizedBox(width: 16),
                    //     Expanded(
                    //       child: _buildStatCard('Pending', '3', Icons.pending),
                    //     ),
                    //   ],
                    // ),
                    
                    SizedBox(height: 32),
                    
                    // Recent Deliveries Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'recent_deliveries'.tr(),
                          style: TextStyle(
                            color: Color(0xFF002A42),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to full tracking history
                          },
                          child: Text(
                            'view_all'.tr(),
                            style: TextStyle(
                              color: Color(0xFFDB7D00),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Tracking Cards with Images
                    _buildTrackingCard(
                      trackingNumber: 'JO0141831780',
                      status: 'order_in_search'.tr(),
                      statusColor: Color(0xFFDB7D00),
                      destination: 'kinondoni_dar'.tr(),
                      timeAgo: 'hours_ago_2'.tr(),
                      imagePath: 'lib/images/package1.jpg',
                    ),
                    
                    SizedBox(height: 12),
                    
                    _buildTrackingCard(
                      trackingNumber: 'JO0141541740',
                      status: 'in_delivery'.tr(),
                      statusColor: Color(0xFFF59E0B),
                      destination: 'ilala_dar'.tr(),
                      timeAgo: 'hours_ago_4'.tr(),
                      imagePath: 'lib/images/package1.jpg',
                    ),
                    
                    SizedBox(height: 12),
                    
                    _buildTrackingCard(
                      trackingNumber: 'JO0141862620',
                      status: 'delivered'.tr(),
                      statusColor: Color(0xFF10B981),
                      destination: 'temeke_dar'.tr(),
                      timeAgo: 'day_ago_1'.tr(),
                      imagePath: 'lib/images/package1.jpg',
                    ),
                    
                    SizedBox(height: 30), // Space for floating button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildStatCard(String title, String value, IconData icon) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             color: Color(0xFF002A42).withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Icon(
  //             icon,
  //             color: Color(0xFF002A42),
  //             size: 24,
  //           ),
  //         ),
  //         SizedBox(height: 12),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             color: Color(0xFF002A42),
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           title,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: Color(0xFF64748B),
  //             fontSize: 12,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTrackingCard({
    required String trackingNumber,
    required String status,
    required Color statusColor,
    required String destination,
    required String timeAgo,
    required String imagePath,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Package Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SizedBox(width: 16),
          
          // Package Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trackingNumber,
                  style: TextStyle(
                    color: Color(0xFF002A42),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        destination,
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          
          // Arrow Icon
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFDB7D00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFDB7D00),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF002A42),
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: EdgeInsets.all(24),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [Color(0xFF002A42), Color(0xFF003A5C)],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //   ),
              // ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     colors: [Color(0xFFDB7D00), Color(0xFFFF8C00)],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //   ),
                    //   shape: BoxShape.circle,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Color(0xFFDB7D00).withOpacity(0.3),
                    //       blurRadius: 20,
                    //       offset: Offset(0, 8),
                    //     ),
                    //   ],
                    // ),
                    child: Center(
                      child: Icon(
                        Icons.delivery_dining,
                        color: Color(0xFFDB7D00),
                        size: 70,
                      ),
                    ),
                  ),
                  Text(
                    'smart_cargo'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'delivery_excellence'.tr(),
                    style: TextStyle(
                      color: Color(0xFFDB7D00),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(Icons.home, 'home'.tr(), () => Navigator.pop(context)),
                  _buildDrawerItem(Icons.receipt_long, 'my_orders'.tr(), () {}),
                  _buildDrawerItem(Icons.track_changes, 'track_package'.tr(), () {}),
                  _buildDrawerItem(Icons.payment, 'payment_methods'.tr(), () {}),
                  _buildDrawerItem(Icons.local_shipping, 'delivery_history'.tr(), () {}),
                  _buildDrawerItem(Icons.support_agent, 'customer_support'.tr(), () {}),
                  _buildDrawerItem(Icons.settings, 'settings'.tr(), () {}),
                  _buildDrawerItem(Icons.info_outline, 'about_smart_cargo'.tr(), () {}),
                  
                  SizedBox(height: 20),
                  
                  Divider(
                    color: Colors.white.withOpacity(0.2),
                    indent: 24,
                    endIndent: 24,
                  ),
                  
                  SizedBox(height: 10),
                  
                  _buildDrawerItem(Icons.logout, 'logout'.tr(), () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFDB7D00).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon, 
          color: Color(0xFFDB7D00),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDB7D00).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SizedBox(
        width: 150,
        height: 60,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParcelBookingPage()),
            );
          },
          backgroundColor: Color(0xFFDB7D00),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'request'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 12),
              Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}