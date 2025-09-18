import 'package:flutter/material.dart';
import 'package:retailfleet/screens/trackingPage.dart';

class PriceConfirmationPage extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const PriceConfirmationPage({super.key, required this.bookingData});

  @override
  _PriceConfirmationPageState createState() => _PriceConfirmationPageState();
}

class _PriceConfirmationPageState extends State<PriceConfirmationPage> 
    with TickerProviderStateMixin {
  String _selectedPaymentMethod = 'M-Pesa';
  bool _isConfirming = false;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  // Theme colors matching homeScreen
  final Color primaryColor = Color(0xFFDB7D00);
  final Color primaryDarkColor = Color(0xFF002A42);
  final Color backgroundColor = Color(0xFFEDEDED);
  final Color cardColor = Colors.white;
  final Color textPrimaryColor = Color(0xFF002A42);
  final Color textSecondaryColor = Color(0xFF64748B);
  final Color hintColor = Color(0xFF9CA3AF);

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'M-Pesa',
      'icon': Icons.phone_android,
      'description': 'Lipa kwa M-Pesa',
      'color': Colors.green,
    },
    {
      'name': 'Tigo Pesa',
      'icon': Icons.phone_android,
      'description': 'Lipa kwa Tigo Pesa',
      'color': Colors.blue,
    },
    {
      'name': 'Airtel Money',
      'icon': Icons.phone_android,
      'description': 'Lipa kwa Airtel Money',
      'color': Colors.red,
    },
    {
      'name': 'Fedha Taslimu',
      'icon': Icons.payments,
      'description': 'Lipa kwa mkono',
      'color': Colors.orange,
    },
  ];

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _slideController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double finalPrice = widget.bookingData['finalPrice'] ?? 0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cardColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textPrimaryColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Thibitisha Malipo',
          style: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: EdgeInsets.all(20),
            child: _buildProgressIndicator(4),
          ),

          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price display with animation
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: _buildPriceCard(finalPrice),
                    ),

                    SizedBox(height: 25),

                    // Order summary
                    _buildOrderSummary(),

                    SizedBox(height: 25),

                    // Payment method selection
                    _buildPaymentMethodSelection(),

                    SizedBox(height: 25),

                    // Price breakdown
                    _buildPriceBreakdown(),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Confirm Button
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Terms and conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: textSecondaryColor),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Kwa kubofya "Thibitisha", unakubali masharti yetu ya huduma',
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondaryColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isConfirming ? null : _confirmBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: primaryColor.withOpacity(0.3),
                    ),
                    child: _isConfirming
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Inathibitisha...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Thibitisha Agizo - TSh ${finalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: primaryColor, size: 24),
              SizedBox(width: 8),
              Text(
                'Njia ya Malipo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          ..._paymentMethods.map((method) {
            bool isSelected = _selectedPaymentMethod == method['name'];

            return GestureDetector(
              onTap: () => setState(() => _selectedPaymentMethod = method['name']),
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? method['color'].withOpacity(0.1) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? method['color'] : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: method['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        method['icon'],
                        color: method['color'],
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? method['color'] : textPrimaryColor,
                            ),
                          ),
                          Text(
                            method['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: method['color'],
                        size: 24,
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    double basePrice = widget.bookingData['transportDetails']['basePrice'].toDouble();
    double weight = widget.bookingData['estimatedWeight'] ?? 0;
    bool isFragile = widget.bookingData['isFragile'] ?? false;
    double finalPrice = widget.bookingData['finalPrice'] ?? 0;

    double weightExtra = (weight > 10) ? (weight - 10) * 50 : 0;
    double fragileExtra = isFragile ? basePrice * 0.3 : 0;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Muktadha wa Bei',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
          ),

          SizedBox(height: 16),

          _buildPriceBreakdownRow('Bei ya Msingi', 'TSh ${basePrice.toStringAsFixed(0)}'),

          if (weightExtra > 0)
            _buildPriceBreakdownRow('Ongezeko la Uzito', 'TSh ${weightExtra.toStringAsFixed(0)}'),

          if (fragileExtra > 0)
            _buildPriceBreakdownRow('Ada ya Bidhaa Nyeti', 'TSh ${fragileExtra.toStringAsFixed(0)}'),

          Divider(height: 24, color: Colors.grey[300]),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jumla',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              Text(
                'TSh ${finalPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdownRow(String label, String amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: textSecondaryColor,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    List<String> months = [
      'Jan', 'Feb', 'Mac', 'Apr', 'Mei', 'Jun',
      'Jul', 'Ago', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _confirmBooking() async {
    setState(() => _isConfirming = true);

    // Simulate booking confirmation process
    await Future.delayed(Duration(seconds: 2));

    // Generate booking ID
    String bookingId = 'USF${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

    setState(() => _isConfirming = false);

    // Show success dialog
    _showSuccessDialog(bookingId);
  }

  void _showSuccessDialog(String bookingId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon with animation
                TweenAnimationBuilder(
                  duration: Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 24),

                Text(
                  'Agizo Limethibitishwa!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12),

                Text(
                  'Namba ya Agizo: $bookingId',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                Text(
                  'Dereva atakupigia simu kwa dakika 5-10 kuthibitisha mahali pa kuchukua.',
                  style: TextStyle(
                    fontSize: 14,
                    color: textSecondaryColor,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Go back to home screen by popping all routes
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textSecondaryColor,
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Rudi Nyumbani',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          _showTrackingScreen(bookingId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Fuatilia',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryDarkColor, Color(0xFF003A5C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryDarkColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProgressStep(1, 'Mahali', currentStep >= 1),
          Expanded(child: _buildProgressLine(currentStep >= 2)),
          _buildProgressStep(2, 'Bidhaa', currentStep >= 2),
          Expanded(child: _buildProgressLine(currentStep >= 3)),
          _buildProgressStep(3, 'Usafiri', currentStep >= 3),
          Expanded(child: _buildProgressLine(currentStep >= 4)),
          _buildProgressStep(4, 'Malipo', currentStep >= 4),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
            boxShadow: isActive ? [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ] : [],
          ),
          child: Center(
            child: isActive 
                ? Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    step.toString(),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? primaryColor : Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Container(
      height: 3,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  Widget _buildPriceCard(double price) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            Color(0xFFFF8C00),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Jumla ya Malipo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'TSh ${price.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Wakati wa Kufika: ${widget.bookingData['estimatedTime'] ?? '30-60 min'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Muhtasari wa Agizo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
          ),

          SizedBox(height: 16),

          _buildSummaryRow('Kutoka', '${widget.bookingData['pickupWard']}, ${widget.bookingData['pickupAddress']}', Icons.location_on),
          _buildSummaryRow('Kwenda', '${widget.bookingData['deliveryWard']}, ${widget.bookingData['deliveryAddress']}', Icons.flag),
          _buildSummaryRow('Mpokeaji', '${widget.bookingData['recipientName']} - ${widget.bookingData['recipientPhone']}', Icons.person),
          _buildSummaryRow('Bidhaa', '${widget.bookingData['product']} (${widget.bookingData['quantity']} vipimo)', Icons.inventory),
          _buildSummaryRow('Usafiri', '${widget.bookingData['vehicleType']}', Icons.local_shipping),

          if (widget.bookingData['pickupDate'] != null && widget.bookingData['pickupTime'] != null) ...[
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Wakati wa Kuchukua: ${_formatDate(widget.bookingData['pickupDate'])} saa ${_formatTime(widget.bookingData['pickupTime'])}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: primaryColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTrackingScreen(String bookingId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TrackingPage(bookingId: bookingId),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }
}