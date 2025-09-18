import 'package:flutter/material.dart';
import 'package:retailfleet/screens/price_confirmation.dart';

class TransportSelectionPage extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  
  const TransportSelectionPage({super.key, required this.bookingData});

  @override
  _TransportSelectionPageState createState() => _TransportSelectionPageState();
}

class _TransportSelectionPageState extends State<TransportSelectionPage> with SingleTickerProviderStateMixin {
  String? _selectedTransportMode;
  String? _selectedVehicleType;
  List<Map<String, dynamic>> _availableTransportOptions = [];
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Theme colors matching homeScreen
  final Color primaryColor = Color(0xFFDB7D00);
  final Color primaryDarkColor = Color(0xFF002A42);
  final Color backgroundColor = Color(0xFFEDEDED);
  final Color cardColor = Colors.white;
  final Color cardColorBg = Color(0xFFF0E5D7);
  final Color textPrimaryColor = Color(0xFF002A42);
  final Color textSecondaryColor = Color(0xFF64748B);
  final Color hintColor = Color(0xFF9CA3AF);

  // Transport modes with vehicle options
  final Map<String, List<Map<String, dynamic>>> _transportOptions = {
    'Pikipiki': [
      {
        'type': 'Pikipiki ya Kawaida',
        'capacity': '25 kg',
        'icon': Icons.two_wheeler,
        'basePrice': 3000,
        'description': 'Haraka na rahisi, inafaa bidhaa ndogo',
        'estimatedTime': '15-30 min',
        'features': ['Haraka sana', 'Bei nafuu', 'Mazingira mazuri'],
      },
      {
        'type': 'Pikipiki ya Kubwa',
        'capacity': '40 kg',
        'icon': Icons.motorcycle,
        'basePrice': 4500,
        'description': 'Uwezo mkubwa, inafaa bidhaa za kati',
        'estimatedTime': '20-35 min',
        'features': ['Uwezo mkubwa', 'Usalama zaidi', 'Bei wastani'],
      },
    ],
    'Baiskeli': [
      {
        'type': 'Baiskeli ya Kawaida',
        'capacity': '15 kg',
        'icon': Icons.pedal_bike,
        'basePrice': 2000,
        'description': 'Mazingira safi, bei nafuu, bidhaa ndogo',
        'estimatedTime': '25-45 min',
        'features': ['Bei nafuu sana', 'Mazingira safi', 'Haraka ndogo'],
      },
      {
        'type': 'Baiskeli ya Mizigo',
        'capacity': '35 kg',
        'icon': Icons.pedal_bike,
        'basePrice': 3500,
        'description': 'Uwezo mkubwa wa kubeba, mazingira safi',
        'estimatedTime': '30-50 min',
        'features': ['Uwezo mkubwa', 'Mazingira safi', 'Bei wastani'],
      },
    ],
    'Gari la Abiria': [
      {
        'type': 'Sedan',
        'capacity': '100 kg',
        'icon': Icons.directions_car,
        'basePrice': 8000,
        'description': 'Usalama mkubwa, inafaa bidhaa za thamani',
        'estimatedTime': '20-40 min',
        'features': ['Usalama mkubwa', 'Mazingira salama', 'Uongozaji wa kitaaluma'],
      },
      {
        'type': 'SUV/4WD',
        'capacity': '200 kg',
        'icon': Icons.airport_shuttle,
        'basePrice': 12000,
        'description': 'Uwezo mkubwa, inafaa bidhaa kubwa na nyeti',
        'estimatedTime': '25-45 min',
        'features': ['Uwezo mkubwa sana', 'Bidhaa nyeti', 'Usalama wa hali ya juu'],
      },
    ],
    'Lori la Ndogo': [
      {
        'type': 'Pickup',
        'capacity': '500 kg',
        'icon': Icons.local_shipping,
        'basePrice': 15000,
        'description': 'Mizigo mikubwa, samani za nyumbani',
        'estimatedTime': '30-60 min',
        'features': ['Mizigo mikubwa', 'Samani za nyumbani', 'Bei ya wastani'],
      },
      {
        'type': 'Canter Ndogo',
        'capacity': '1000 kg',
        'icon': Icons.fire_truck,
        'basePrice': 25000,
        'description': 'Mizigo mikubwa sana, biashara kubwa',
        'estimatedTime': '45-90 min',
        'features': ['Uwezo mkubwa sana', 'Biashara kubwa', 'Ufanisi mkubwa'],
      },
    ],
    'Lori la Kubwa': [
      {
        'type': 'Lori la Kati',
        'capacity': '3000 kg',
        'icon': Icons.local_shipping,
        'basePrice': 45000,
        'description': 'Mizigo mikubwa ya biashara, masafa marefu',
        'estimatedTime': '60-120 min',
        'features': ['Biashara kubwa', 'Masafa marefu', 'Uongozi wa kitaaluma'],
      },
      {
        'type': 'Lori la Kubwa',
        'capacity': '5000 kg',
        'icon': Icons.fire_truck,
        'basePrice': 70000,
        'description': 'Mizigo mikubwa sana, kampuni kubwa',
        'estimatedTime': '90-180 min',
        'features': ['Kampuni kubwa', 'Mizigo mikubwa sana', 'Huduma ya hali ya juu'],
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _suggestTransportOptions();
  }

  void _suggestTransportOptions() {
    setState(() => _isLoading = true);
    
    // Simulate API call delay
    Future.delayed(Duration(seconds: 1), () {
      double weight = widget.bookingData['estimatedWeight'] ?? 0;
      double value = widget.bookingData['estimatedValue'] ?? 0;
      bool isFragile = widget.bookingData['isFragile'] ?? false;
      
      List<Map<String, dynamic>> suggested = [];
      
      // Logic to suggest transport based on weight, value, and fragility
      if (weight <= 25 && !isFragile) {
        suggested.addAll(_transportOptions['Pikipiki']!);
        if (weight <= 15) {
          suggested.addAll(_transportOptions['Baiskeli']!);
        }
      }
      
      if (weight <= 100 || isFragile || value > 100000) {
        suggested.addAll(_transportOptions['Gari la Abiria']!);
      }
      
      if (weight > 100 || weight <= 500) {
        suggested.addAll(_transportOptions['Lori la Ndogo']!);
      }
      
      if (weight > 500) {
        suggested.addAll(_transportOptions['Lori la Kubwa']!);
      }
      
      // Sort by price (recommended first)
      suggested.sort((a, b) => a['basePrice'].compareTo(b['basePrice']));
      
      setState(() {
        _availableTransportOptions = suggested;
        _isLoading = false;
      });
      
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Chagua Usafiri',
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
            child: _buildProgressIndicator(3),
          ),
          
          Expanded(
            child: _isLoading 
                ? _buildLoadingWidget()
                : _buildTransportOptions(),
          ),
          
          // Bottom Continue Button
          if (_selectedVehicleType != null)
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
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continueToPriceConfirmation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: primaryColor.withOpacity(0.3),
                  ),
                  child: Text(
                    'Endelea → Thibitisha Bei',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
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
  
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(height: 20),
          Text(
            'Tunatafuta chaguo bora za usafiri...',
            style: TextStyle(
              fontSize: 16,
              color: textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tunachunguza uzito, umbali na thamani ya bidhaa',
            style: TextStyle(
              fontSize: 14,
              color: hintColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTransportOptions() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary card
            _buildSummaryCard(),
            
            SizedBox(height: 25),
            
            Row(
              children: [
                Icon(Icons.local_shipping, color: primaryColor, size: 24),
                SizedBox(width: 8),
                Text(
                  'Chaguo la Usafiri',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textPrimaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8),
            
            Text(
              'Tumependekeza chaguo hizi kulingana na bidhaa yako',
              style: TextStyle(
                fontSize: 16,
                color: textSecondaryColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Transport options
            ..._availableTransportOptions.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> option = entry.value;
              bool isRecommended = index == 0;
              bool isSelected = _selectedVehicleType == option['type'];
              
              return _buildTransportOption(option, isRecommended, isSelected);
            }),
            
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryCard() {
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
          
          SizedBox(height: 15),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Kutoka',
                  '${widget.bookingData['pickupWard']}',
                  Icons.location_on,
                  Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, color: Colors.grey[400]),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Kwenda',
                  '${widget.bookingData['deliveryWard']}',
                  Icons.location_on,
                  Colors.red,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 15),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Bidhaa',
                  '${widget.bookingData['product']}',
                  Icons.inventory,
                  Colors.blue,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildSummaryItem(
                  'Uzito',
                  '${widget.bookingData['estimatedWeight'].toStringAsFixed(1)} kg',
                  Icons.scale,
                  Colors.orange,
                ),
              ),
            ],
          ),
          
          if (widget.bookingData['isFragile']) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Bidhaa Nyeti - Itahitaji utunzaji maalum',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange[800],
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
  
  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimaryColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
  
  Widget _buildTransportOption(Map<String, dynamic> option, bool isRecommended, bool isSelected) {
    double weight = widget.bookingData['estimatedWeight'] ?? 0;
    double basePrice = option['basePrice'].toDouble();
    
    // Calculate price based on weight and distance (simplified)
    double calculatedPrice = _calculatePrice(basePrice, weight);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicleType = option['type'];
          _selectedTransportMode = _getTransportModeFromType(option['type']);
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF0E5D7) : cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with icon and title
            Row(
              children: [
                if (isRecommended)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'IMEPENDEKEZWA',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 24,
                  ),
              ],
            ),
            
            if (isRecommended) SizedBox(height: 12),
            
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primaryColor.withOpacity(0.2)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    option['icon'],
                    size: 32,
                    color: isSelected ? primaryColor : textSecondaryColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option['type'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        option['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: textSecondaryColor,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TSh ${calculatedPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : textPrimaryColor,
                      ),
                    ),
                    Text(
                      option['estimatedTime'],
                      style: TextStyle(
                        fontSize: 14,
                        color: textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Features
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (option['features'] as List<String>).map((feature) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primaryColor.withOpacity(0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? primaryColor.withOpacity(0.3) : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? primaryColor : textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: 12),
            
            // Capacity info
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: textSecondaryColor,
                ),
                SizedBox(width: 6),
                Text(
                  'Uwezo: ${option['capacity']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                if (weight > _getCapacityInKg(option['capacity']))
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Text(
                      'Uzito umezidi',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  double _calculatePrice(double basePrice, double weight) {
    // Simple pricing algorithm - can be made more complex
    double distanceMultiplier = 1.0; // This could be calculated from actual distance
    double weightMultiplier = 1.0 + (weight / 100); // Heavier items cost more
    bool isFragile = widget.bookingData['isFragile'] ?? false;
    double fragileMultiplier = isFragile ? 1.3 : 1.0; // 30% more for fragile items
    
    return basePrice * distanceMultiplier * weightMultiplier * fragileMultiplier;
  }
  
  double _getCapacityInKg(String capacity) {
    // Extract numeric value from capacity string
    String numericPart = capacity.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(numericPart) ?? 0;
  }
  
  String _getTransportModeFromType(String type) {
    for (String mode in _transportOptions.keys) {
      for (Map<String, dynamic> option in _transportOptions[mode]!) {
        if (option['type'] == type) {
          return mode;
        }
      }
    }
    return 'Unknown';
  }
  
  void _continueToPriceConfirmation() {
    if (_selectedVehicleType != null) {
      // Find the selected transport option details
      Map<String, dynamic>? selectedOption;
      for (var option in _availableTransportOptions) {
        if (option['type'] == _selectedVehicleType) {
          selectedOption = option;
          break;
        }
      }
      
      if (selectedOption != null) {
        double weight = widget.bookingData['estimatedWeight'] ?? 0;
        double finalPrice = _calculatePrice(selectedOption['basePrice'].toDouble(), weight);
        
        final updatedBookingData = Map<String, dynamic>.from(widget.bookingData);
        updatedBookingData.addAll({
          'transportMode': _selectedTransportMode,
          'vehicleType': _selectedVehicleType,
          'estimatedTime': selectedOption['estimatedTime'],
          'finalPrice': finalPrice,
          'transportDetails': selectedOption,
        });
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PriceConfirmationPage(bookingData: updatedBookingData),
          ),
        );
      }
    }
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}