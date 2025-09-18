import 'package:flutter/material.dart';
import 'package:retailfleet/screens/transport_selection.dart';

class ProductSelectionPage extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  
  const ProductSelectionPage({super.key, required this.bookingData});

  @override
  _ProductSelectionPageState createState() => _ProductSelectionPageState();
}

class _ProductSelectionPageState extends State<ProductSelectionPage> {
  String? _selectedCategory;
  String? _selectedProduct;
  int _quantity = 1;
  double _estimatedWeight = 0;
  double _estimatedValue = 0;
  bool _isFragile = false;
  bool _isCustomProduct = false;
  
  final TextEditingController _customProductController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _customWeightController = TextEditingController();
  final TextEditingController _customValueController = TextEditingController();

  // Theme colors matching homeScreen
  final Color primaryColor = Color(0xFFDB7D00);
  final Color primaryDarkColor = Color(0xFF002A42);
  final Color backgroundColor = Color(0xFFEDEDED);
  final Color cardColor = Colors.white;
  final Color cardColorBg = Color(0xFFF0E5D7);
  final Color textPrimaryColor = Color(0xFF002A42);
  final Color textSecondaryColor = Color(0xFF64748B);
  final Color hintColor = Color(0xFF9CA3AF);

  // Product categories with detailed subcategories
  final Map<String, Map<String, Map<String, dynamic>>> _productCategories = {
    'Chakula na Vinywaji': {
      'Mazao': {'weight': 1.0, 'baseValue': 5000, 'fragile': false, 'icon': Icons.eco},
      'Mboga na Matunda': {'weight': 0.5, 'baseValue': 3000, 'fragile': true, 'icon': Icons.local_grocery_store},
      'Nyama na Samaki': {'weight': 2.0, 'baseValue': 15000, 'fragile': true, 'icon': Icons.set_meal},
      'Maziwa na Bidhaa zake': {'weight': 1.0, 'baseValue': 8000, 'fragile': true, 'icon': Icons.local_drink},
      'Mkate na Keki': {'weight': 0.8, 'baseValue': 4000, 'fragile': true, 'icon': Icons.cake},
      'Vinywaji': {'weight': 1.5, 'baseValue': 6000, 'fragile': true, 'icon': Icons.local_bar},
      'Viungo vya Kupikia': {'weight': 0.3, 'baseValue': 2000, 'fragile': false, 'icon': Icons.restaurant},
    },
    'Vifaa vya Umeme': {
      'Simu na Kompyuta': {'weight': 0.5, 'baseValue': 500000, 'fragile': true, 'icon': Icons.smartphone},
      'Televizheni': {'weight': 15.0, 'baseValue': 800000, 'fragile': true, 'icon': Icons.tv},
      'Jokofu': {'weight': 50.0, 'baseValue': 1200000, 'fragile': true, 'icon': Icons.kitchen},
      'Redio na Spika': {'weight': 3.0, 'baseValue': 150000, 'fragile': true, 'icon': Icons.radio},
      'Vifaa vya Jikoni': {'weight': 5.0, 'baseValue': 100000, 'fragile': true, 'icon': Icons.microwave},
      'Betri na Charger': {'weight': 0.2, 'baseValue': 25000, 'fragile': false, 'icon': Icons.battery_charging_full},
    },
    'Nguo na Vazi': {
      'Nguo za Watu Wazima': {'weight': 2.0, 'baseValue': 50000, 'fragile': false, 'icon': Icons.checkroom},
      'Nguo za Watoto': {'weight': 0.5, 'baseValue': 25000, 'fragile': false, 'icon': Icons.child_friendly},
      'Viatu': {'weight': 1.5, 'baseValue': 80000, 'fragile': false, 'icon': Icons.grass},
      'Miwani na Vinyago': {'weight': 0.3, 'baseValue': 30000, 'fragile': true, 'icon': Icons.watch},
      'Kofia na Miwani': {'weight': 0.2, 'baseValue': 15000, 'fragile': true, 'icon': Icons.face},
      'Mikanda na Begi': {'weight': 1.0, 'baseValue': 45000, 'fragile': false, 'icon': Icons.work},
    },
    'Samani za Nyumbani': {
      'Viti na Meza': {'weight': 20.0, 'baseValue': 200000, 'fragile': false, 'icon': Icons.chair},
      'Vitanda na Mattress': {'weight': 35.0, 'baseValue': 400000, 'fragile': false, 'icon': Icons.bed},
      'Kabati na Shelf': {'weight': 40.0, 'baseValue': 300000, 'fragile': false, 'icon': Icons.storage},
      'Mapazia na Carpet': {'weight': 5.0, 'baseValue': 100000, 'fragile': false, 'icon': Icons.texture},
      'Vifaa vya Jikoni': {'weight': 3.0, 'baseValue': 50000, 'fragile': true, 'icon': Icons.kitchen_outlined},
      'Miwani na Vyombo': {'weight': 2.0, 'baseValue': 30000, 'fragile': true, 'icon': Icons.local_dining},
    },
    'Vitabu na Hati': {
      'Vitabu vya Masomo': {'weight': 1.5, 'baseValue': 20000, 'fragile': false, 'icon': Icons.menu_book},
      'Magazeti na Jarida': {'weight': 0.5, 'baseValue': 5000, 'fragile': false, 'icon': Icons.newspaper},
      'Hati za Ofisi': {'weight': 0.2, 'baseValue': 10000, 'fragile': false, 'icon': Icons.description},
      'Picha na Album': {'weight': 1.0, 'baseValue': 15000, 'fragile': true, 'icon': Icons.photo_album},
      'Karatasi za Biashara': {'weight': 0.3, 'baseValue': 8000, 'fragile': false, 'icon': Icons.business},
    },
    'Dawa na Vifaa vya Afya': {
      'Dawa za Hospitali': {'weight': 0.5, 'baseValue': 50000, 'fragile': true, 'icon': Icons.medication},
      'Vifaa vya Kwanza': {'weight': 1.0, 'baseValue': 30000, 'fragile': false, 'icon': Icons.medical_services},
      'Vipimo vya Damu': {'weight': 0.3, 'baseValue': 100000, 'fragile': true, 'icon': Icons.monitor_heart},
      'Miwani ya Kusoma': {'weight': 0.2, 'baseValue': 80000, 'fragile': true, 'icon': Icons.visibility},
      'Vifaa vya Uongozi': {'weight': 2.0, 'baseValue': 150000, 'fragile': true, 'icon': Icons.accessibility},
    },
    'Bidhaa za Uongozi': {
      'Sabuni na Shampoo': {'weight': 0.5, 'baseValue': 10000, 'fragile': true, 'icon': Icons.soap},
      'Marashi na Perfume': {'weight': 0.3, 'baseValue': 50000, 'fragile': true, 'icon': Icons.spa},
      'Rangi za Uso': {'weight': 0.2, 'baseValue': 30000, 'fragile': true, 'icon': Icons.face_retouching_natural},
      'Vifaa vya Nywele': {'weight': 0.8, 'baseValue': 25000, 'fragile': false, 'icon': Icons.content_cut},
      'Dawa za Meno': {'weight': 0.2, 'baseValue': 8000, 'fragile': false, 'icon': Icons.medical_information},
    },
    'Vifaa vya Kazi': {
      'Zana za Ujenzi': {'weight': 5.0, 'baseValue': 80000, 'fragile': false, 'icon': Icons.construction},
      'Vifaa vya Ofisi': {'weight': 2.0, 'baseValue': 40000, 'fragile': true, 'icon': Icons.business_center},
      'Mashine za Kushona': {'weight': 15.0, 'baseValue': 300000, 'fragile': true, 'icon': Icons.precision_manufacturing},
      'Vifaa vya Kilimo': {'weight': 8.0, 'baseValue': 120000, 'fragile': false, 'icon': Icons.agriculture},
      'Zana za Fundi': {'weight': 3.0, 'baseValue': 60000, 'fragile': false, 'icon': Icons.handyman},
    },
    'Vifaa vya Michezo': {
      'Mpira na Vifaa vyake': {'weight': 1.0, 'baseValue': 30000, 'fragile': false, 'icon': Icons.sports_soccer},
      'Vifaa vya Gym': {'weight': 10.0, 'baseValue': 150000, 'fragile': false, 'icon': Icons.fitness_center},
      'Baiskeli na Parts': {'weight': 20.0, 'baseValue': 400000, 'fragile': false, 'icon': Icons.pedal_bike},
      'Vifaa vya Swimming': {'weight': 1.5, 'baseValue': 25000, 'fragile': false, 'icon': Icons.pool},
      'Michezo ya Indoor': {'weight': 2.0, 'baseValue': 50000, 'fragile': true, 'icon': Icons.sports_esports},
    },
    'Bidhaa Nyingine': {
      'Bidhaa Mtambuka': {'weight': 1.0, 'baseValue': 25000, 'fragile': false, 'icon': Icons.category, 'custom': true},
    },
  };

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
          'Chagua Bidhaa',
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
            child: _buildProgressIndicator(2),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Chagua Aina ya Bidhaa',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  Text(
                    'Chagua aina ya bidhaa unayotaka kusafirisha',
                    style: TextStyle(
                      fontSize: 16,
                      color: textSecondaryColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: 25),
                  
                  // Category Selection
                  Text(
                    'Aina ya Bidhaa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textPrimaryColor,
                    ),
                  ),
                  
                  SizedBox(height: 15),
                  
                  _buildCategoryList(),
                  
                  if (_selectedCategory != null) ...[
                    SizedBox(height: 30),
                    
                    Text(
                      'Chagua Bidhaa Mahususi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textPrimaryColor,
                      ),
                    ),
                    
                    SizedBox(height: 15),
                    
                    _buildProductList(),
                    
                    if (_isCustomProduct) _buildCustomProductForm(),
                    
                    if (_selectedProduct != null && !_isCustomProduct) ...[
                      SizedBox(height: 25),
                      _buildProductDetails(),
                    ],
                  ],
                  
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          
          // Bottom Continue Button
          if (_selectedProduct != null)
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
                  onPressed: _continueToTransportSelection,
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
                    'Endelea → Chagua Usafiri',
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
  
  Widget _buildCategoryList() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _productCategories.length,
        itemBuilder: (context, index) {
          String category = _productCategories.keys.elementAt(index);
          bool isSelected = _selectedCategory == category;
          
          return Container(
            width: 150,
            margin: EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  _selectedProduct = null;
                  _isCustomProduct = false;
                  _estimatedWeight = 0;
                  _estimatedValue = 0;
                  _isFragile = false;
                });
              },
              child: Card(
                color: isSelected ? cardColorBg : cardColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(category),
                        size: 28,
                        color: isSelected ? primaryColor : textSecondaryColor,
                      ),
                      SizedBox(height: 8),
                      Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primaryColor : textPrimaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildProductList() {
    if (_selectedCategory == null) return SizedBox.shrink();
    
    Map<String, Map<String, dynamic>> products = _productCategories[_selectedCategory]!;
    
    return Column(
      children: [
        ...products.entries.map((entry) {
          String productName = entry.key;
          Map<String, dynamic> productData = entry.value;
          bool isSelected = _selectedProduct == productName && !_isCustomProduct;
          bool isCustomOption = productData['custom'] == true;
          
          return GestureDetector(
            onTap: () {
              if (isCustomOption) {
                setState(() {
                  _isCustomProduct = true;
                  _selectedProduct = 'Bidhaa Mtambuka';
                  _estimatedWeight = 1.0;
                  _estimatedValue = 25000;
                  _isFragile = false;
                });
              } else {
                setState(() {
                  _selectedProduct = productName;
                  _isCustomProduct = false;
                  _estimatedWeight = productData['weight'].toDouble();
                  _estimatedValue = productData['baseValue'].toDouble();
                  _isFragile = productData['fragile'];
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? cardColorBg : cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withOpacity(0.2)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      productData['icon'],
                      size: 24,
                      color: isSelected ? primaryColor : textSecondaryColor,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            _buildProductTag(
                              '${productData['weight']} kg',
                              Icons.scale,
                              Colors.blue,
                            ),
                            SizedBox(width: 8),
                            if (productData['fragile'])
                              _buildProductTag(
                                'Nyeti',
                                Icons.warning,
                                Colors.orange,
                              ),
                            if (isCustomOption)
                              _buildProductTag(
                                'Weka mwenyewe',
                                Icons.edit,
                                primaryColor,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
  
  Widget _buildCustomProductForm() {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
            'Weka Maelezo ya Bidhaa Yako',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildTextField(
            controller: _customProductController,
            label: 'Jina la Bidhaa',
            hint: 'Weka jina la bidhaa yako',
            icon: Icons.inventory,
            onChanged: (value) {
              setState(() {
                _selectedProduct = value.isNotEmpty ? value : 'Bidhaa Mtambuka';
              });
            },
          ),
          
          SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _customWeightController,
                  label: 'Uzito (kg)',
                  hint: '0.0',
                  icon: Icons.scale,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _estimatedWeight = double.tryParse(value) ?? 1.0;
                      });
                    }
                  },
                ),
              ),
              
              SizedBox(width: 16),
              
              Expanded(
                child: _buildTextField(
                  controller: _customValueController,
                  label: 'Thamani (TSh)',
                  hint: '0',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _estimatedValue = double.tryParse(value) ?? 25000;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                SizedBox(width: 12),
                Text(
                  'Bidhaa ni Nyeti',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textPrimaryColor,
                  ),
                ),
                Spacer(),
                Switch(
                  value: _isFragile,
                  onChanged: (value) {
                    setState(() {
                      _isFragile = value;
                    });
                  },
                  activeColor: primaryColor,
                  activeTrackColor: primaryColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildProductDetails(),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
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
        onChanged: onChanged,
      ),
    );
  }
  
  Widget _buildProductTag(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProductDetails() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Taarifa za Bidhaa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Quantity selector
          Row(
            children: [
              Text(
                'Idadi:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textPrimaryColor,
                ),
              ),
              SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                      icon: Icon(Icons.remove, size: 20, color: _quantity > 1 ? primaryColor : Colors.grey),
                      padding: EdgeInsets.all(8),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textPrimaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _quantity < 10 ? () => setState(() => _quantity++) : null,
                      icon: Icon(Icons.add, size: 20, color: _quantity < 10 ? primaryColor : Colors.grey),
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // Weight and value display
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  'Uzito wa Jumla',
                  '${(_estimatedWeight * _quantity).toStringAsFixed(1)} kg',
                  Icons.scale,
                  Colors.blue,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildDetailCard(
                  'Thamani (Kadiri)',
                  'TSh ${(_estimatedValue * _quantity).toStringAsFixed(0)}',
                  Icons.attach_money,
                  Colors.green,
                ),
              ),
            ],
          ),
          
          if (_isFragile) ...[
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Bidhaa hii ni nyeti na itahitaji utunzaji maalum',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: 20),
          
          // Custom description
          Text(
            'Maelezo ya Ziada (si lazima)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textPrimaryColor,
            ),
          ),
          
          SizedBox(height: 8),
          
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Kuna kitu maalum kuhusu bidhaa hii?',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color),
              SizedBox(width: 8),
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
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Chakula na Vinywaji': return Icons.restaurant;
      case 'Vifaa vya Umeme': return Icons.electrical_services;
      case 'Nguo na Vazi': return Icons.checkroom;
      case 'Samani za Nyumbani': return Icons.home;
      case 'Vitabu na Hati': return Icons.menu_book;
      case 'Dawa na Vifaa vya Afya': return Icons.medical_services;
      case 'Bidhaa za Uongozi': return Icons.spa;
      case 'Vifaa vya Kazi': return Icons.work;
      case 'Vifaa vya Michezo': return Icons.sports_soccer;
      case 'Bidhaa Nyingine': return Icons.add_circle_outline;
      default: return Icons.category;
    }
  }
  
  void _continueToTransportSelection() {
    final updatedBookingData = Map<String, dynamic>.from(widget.bookingData);
    updatedBookingData.addAll({
      'category': _selectedCategory,
      'product': _selectedProduct,
      'quantity': _quantity,
      'estimatedWeight': _estimatedWeight * _quantity,
      'estimatedValue': _estimatedValue * _quantity,
      'isFragile': _isFragile,
      'productDescription': _descriptionController.text,
      'isCustomProduct': _isCustomProduct,
    });
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransportSelectionPage(bookingData: updatedBookingData),
      ),
    );
  }
  
  @override
  void dispose() {
    _customProductController.dispose();
    _descriptionController.dispose();
    _customWeightController.dispose();
    _customValueController.dispose();
    super.dispose();
  }
}