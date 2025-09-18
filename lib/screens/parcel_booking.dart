import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retailfleet/screens/product_selection.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ParcelBookingPage extends StatefulWidget {
  const ParcelBookingPage({super.key});

  @override
  _ParcelBookingPageState createState() => _ParcelBookingPageState();
}

class _ParcelBookingPageState extends State<ParcelBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _senderNotesController = TextEditingController();

  String? _selectedPickupWard;
  String? _selectedDeliveryWard;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _currentStep = 0; // 0 for pickup, 1 for delivery

  // Map location selection
  LatLng? _selectedPickupLocation;
  LatLng? _selectedDeliveryLocation;
  bool _isSelectingPickupLocation = false;
  bool _isSelectingDeliveryLocation = false;

  // Dar es Salaam wards (sample data)
  final List<String> _wards = [
    'Kariakoo', 'Ilala', 'Kinondoni', 'Temeke', 'Upanga',
    'Msimbazi', 'Mchikichini', 'Gerezani', 'Kivukoni', 'Kisutu',
    'Magomeni', 'Sinza', 'Mikocheni', 'Masaki', 'Oyster Bay',
    'Ada Estate', 'Mbezi', 'Goba', 'Kimara', 'Tabata'
  ];

  // Mock current location (Dar es Salaam coordinates)
  final LatLng _currentLocation = LatLng(-6.7924, 39.2083);
  final MapController _mapController = MapController();

  // Theme colors matching homeScreen
  final Color primaryColor = Color(0xFFDB7D00);
  final Color primaryDarkColor = Color(0xFF002A42);
  final Color backgroundColor = Color(0xFFEDEDED);
  final Color cardColor = Colors.white;
  final Color textPrimaryColor = Color(0xFF002A42);
  final Color textSecondaryColor = Color(0xFF64748B);
  final Color hintColor = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Map background
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentLocation,
              zoom: 13.0,
              onTap: (tapPosition, point) {
                if (_isSelectingPickupLocation) {
                  setState(() {
                    _selectedPickupLocation = point;
                    _isSelectingPickupLocation = false;
                  });
                } else if (_isSelectingDeliveryLocation) {
                  setState(() {
                    _selectedDeliveryLocation = point;
                    _isSelectingDeliveryLocation = false;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.retailfleet',
              ),
              MarkerLayer(
                markers: [
                  if (_selectedPickupLocation != null)
                    Marker(
                      point: _selectedPickupLocation!,
                      width: 40.0,
                      height: 40.0,
                      builder: (ctx) => Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.4),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  if (_selectedDeliveryLocation != null)
                    Marker(
                      point: _selectedDeliveryLocation!,
                      width: 40.0,
                      height: 40.0,
                      builder: (ctx) => Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF10B981).withOpacity(0.4),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  Marker(
                    point: _currentLocation,
                    width: 32.0,
                    height: 32.0,
                    builder: (ctx) => Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryDarkColor.withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: textPrimaryColor, size: 20),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.all(12),
              ),
            ),
          ),

          // Location selection mode indicator
          if (_isSelectingPickupLocation || _isSelectingDeliveryLocation)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, Color(0xFFFF8C00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _isSelectingPickupLocation
                              ? 'Chagua mahali pa kuchukua kwenye ramani'
                              : 'Chagua mahali pa kupeleka kwenye ramani',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Draggable form sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: Offset(0, -8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag handle
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 16, bottom: 8),
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: hintColor,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),

                        // Progress indicator
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: _buildProgressIndicator(1),
                        ),
                        
                        SizedBox(height: 24),
                        
                        // Step content
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: _currentStep == 0 
                              ? _buildPickupStep() 
                              : _buildDeliveryStep(),
                        ),
                        
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPickupStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with icon
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.location_searching,
                color: primaryColor,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mahali pa Kuchukua',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Weka mahali unapotoka',
                    style: TextStyle(
                      fontSize: 16,
                      color: textSecondaryColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        SizedBox(height: 32),
        
        // Map selection button
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _isSelectingPickupLocation = true;
                  _isSelectingDeliveryLocation = false;
                });
              },
              icon: Icon(Icons.map_outlined, color: primaryColor, size: 22),
              label: Text(
                'Chagua kwenye ramani',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18),
                side: BorderSide(color: primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: primaryColor.withOpacity(0.05),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Location selection
        _buildLocationDropdown(
          'Chagua Kata',
          _selectedPickupWard,
          (value) => setState(() => _selectedPickupWard = value),
          Icons.location_city_outlined,
        ),
        
        SizedBox(height: 16),
        
        _buildTextField(
          controller: _pickupController,
          label: 'Anuani kamili (Jengo, Barabara)',
          hint: 'Mfano: Jengo la Uhuru, Barabara ya Samora',
          icon: Icons.home_work_outlined,
          validator: (value) => value?.isEmpty ?? true ? 'Jaza anuani kamili' : null,
        ),
        
        SizedBox(height: 24),
        
        // Date and Time Section
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryDarkColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryDarkColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, color: primaryDarkColor, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Wakati wa Kuchukua',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Container(
                    child: _buildDateTimePicker(
                      'Chagua Tarehe',
                      _selectedDate != null 
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : null,
                      Icons.calendar_today_outlined,
                      () => _selectDate(context),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: _buildDateTimePicker(
                      'Chagua Wakati',
                      _selectedTime != null 
                          ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                          : null,
                      Icons.access_time_outlined,
                      () => _selectTime(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 32),
        
        // Continue button
        SizedBox(
          width: double.infinity,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: _canContinuePickup() ? [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ] : [],
            ),
            child: ElevatedButton(
              onPressed: _canContinuePickup() ? _continueToDelivery : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _canContinuePickup() ? primaryColor : Colors.grey[300],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Endelea kwa Kupeleka',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with icon
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.delivery_dining,
                color: Color(0xFF10B981),
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mahali pa Kupeleka',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Weka mahali unakopeleka',
                    style: TextStyle(
                      fontSize: 16,
                      color: textSecondaryColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        SizedBox(height: 32),
        
        // Map selection button
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _isSelectingDeliveryLocation = true;
                  _isSelectingPickupLocation = false;
                });
              },
              icon: Icon(Icons.map_outlined, color: primaryColor, size: 22),
              label: Text(
                'Chagua kwenye ramani',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18),
                side: BorderSide(color: primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: primaryColor.withOpacity(0.05),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Delivery Location
        _buildLocationDropdown(
          'Chagua Kata',
          _selectedDeliveryWard,
          (value) => setState(() => _selectedDeliveryWard = value),
          Icons.location_city_outlined,
        ),
        
        SizedBox(height: 16),
        
        _buildTextField(
          controller: _deliveryController,
          label: 'Anuani kamili (Jengo, Barabara)',
          hint: 'Mfano: Jengo la Amani, Barabara ya Uhuru',
          icon: Icons.home_work_outlined,
          validator: (value) => value?.isEmpty ?? true ? 'Jaza anuani kamili' : null,
        ),
        
        SizedBox(height: 24),
        
        // Recipient Details Section
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryDarkColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryDarkColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline, color: primaryDarkColor, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Mpokeaji',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _recipientController,
                label: 'Jina la Mpokeaji',
                hint: 'Jina kamili la mtu atakayepokea',
                icon: Icons.person_outline,
                validator: (value) => value?.isEmpty ?? true ? 'Jaza jina la mpokeaji' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Namba ya Simu ya Mpokeaji',
                hint: '0700123456',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Jaza namba ya simu';
                  if (value!.length < 10) return 'Namba ya simu si sahihi';
                  return null;
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: 24),
        
        // Additional Notes
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.note_add_outlined, color: primaryColor, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Maelezo ya Ziada (si lazima)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _senderNotesController,
                label: 'Maelezo maalum',
                hint: 'Kuna kitu maalum ungependa tufahamu?',
                icon: Icons.edit_note_outlined,
                maxLines: 3,
                isRequired: false,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 32),
        
        // Back and Continue buttons
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textSecondaryColor,
                    side: BorderSide(color: Colors.grey[300]!, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Rudi Nyuma',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _canContinueDelivery() ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ] : [],
                ),
                child: ElevatedButton(
                  onPressed: _canContinueDelivery() ? _continueToProductSelection : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canContinueDelivery() ? primaryColor : Colors.grey[300],
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Endelea',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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

  Widget _buildLocationDropdown(String label, String? value, Function(String?) onChanged, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: textSecondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primaryColor, size: 20),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        dropdownColor: cardColor,
        items: _wards.map((ward) => DropdownMenuItem(
          value: ward,
          child: Text(
            ward,
            style: TextStyle(
              color: textPrimaryColor,
              fontSize: 16,
            ),
          ),
        )).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Chagua kata' : null,
        icon: Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 24),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        style: TextStyle(
          color: textPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            color: textSecondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 14,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primaryColor, size: 20),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        validator: isRequired ? validator : null,
      ),
    );
  }

  Widget _buildDateTimePicker(String label, String? value, IconData icon, VoidCallback onTap) {
    bool hasValue = value != null;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasValue ? primaryColor.withOpacity(0.3) : Colors.grey[200]!,
            width: hasValue ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: hasValue ? primaryColor.withOpacity(0.1) : Colors.black.withOpacity(0.05),
              blurRadius: hasValue ? 12 : 8,
              offset: Offset(0, hasValue ? 6 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: hasValue ? primaryColor.withOpacity(0.15) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: hasValue ? primaryColor : textSecondaryColor,
                    size: 18,
                  ),
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
                      SizedBox(height: 4),
                      Text(
                        value ?? 'Chagua ${label.toLowerCase()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: hasValue ? textPrimaryColor : hintColor,
                          fontWeight: hasValue ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textPrimaryColor,
            ),
            dialogBackgroundColor: cardColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textPrimaryColor,
            ),
            dialogBackgroundColor: cardColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  bool _canContinuePickup() {
    return _selectedPickupWard != null && 
           _pickupController.text.isNotEmpty &&
           _selectedDate != null &&
           _selectedTime != null;
  }

  bool _canContinueDelivery() {
    return _selectedDeliveryWard != null &&
           _deliveryController.text.isNotEmpty &&
           _recipientController.text.isNotEmpty &&
           _phoneController.text.length == 10;
  }

  void _continueToDelivery() {
    if (_canContinuePickup()) {
      setState(() {
        _currentStep = 1;
      });
    }
  }

  void _continueToProductSelection() {
    if (_formKey.currentState!.validate() && _canContinueDelivery()) {
      final bookingData = {
        'pickupWard': _selectedPickupWard,
        'pickupAddress': _pickupController.text,
        'deliveryWard': _selectedDeliveryWard,
        'deliveryAddress': _deliveryController.text,
        'recipientName': _recipientController.text,
        'recipientPhone': _phoneController.text,
        'pickupDate': _selectedDate,
        'pickupTime': _selectedTime,
        'senderNotes': _senderNotesController.text,
        'pickupLocation': _selectedPickupLocation,
        'deliveryLocation': _selectedDeliveryLocation,
      };
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductSelectionPage(bookingData: bookingData),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _deliveryController.dispose();
    _recipientController.dispose();
    _phoneController.dispose();
    _senderNotesController.dispose();
    super.dispose();
  }
}

