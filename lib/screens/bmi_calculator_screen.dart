import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/gender_selector.dart';
import '../widgets/input_field.dart';
import '../widgets/dropdown_field.dart';
import '../widgets/bottom_nav_bar.dart';
import 'bmi_result_screen.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  String _selectedGender = 'male';
  String _selectedGoal = 'Lose Weight';
  int _currentNavIndex = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  final List<String> _goalOptions = [
    'Lose Weight',
    'Maintain Weight',
    'Gain Weight',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _onGenderSelected(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  void _onCalculate() {
    // Get weight and height values
    double? weight = double.tryParse(_weightController.text);
    double? heightCm = double.tryParse(_heightController.text);

    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid weight and height values')),
      );
      return;
    }

    // Convert height from cm to meters
    double heightM = heightCm / 100;

    // Calculate BMI: weight (kg) / height (m)^2
    double bmi = weight / (heightM * heightM);

    // Navigate to result screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIResultScreen(
          bmiValue: bmi,
          userName: _nameController.text.isEmpty ? 'User' : _nameController.text,
          age: int.tryParse(_ageController.text) ?? 25,
          goal: _selectedGoal,
          gender: _selectedGender,
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Header
                      _buildHeader(),
                      const SizedBox(height: 30),
                      // Select your sex
                      Text(
                        AppStrings.selectYourSex,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Gender selector
                      GenderSelector(
                        selectedGender: _selectedGender,
                        onGenderSelected: _onGenderSelected,
                      ),
                      const SizedBox(height: 25),
                      // Name input
                      InputField(
                        label: AppStrings.name,
                        hint: AppStrings.enterYourNameHere,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      // Age input
                      InputField(
                        label: AppStrings.age,
                        hint: AppStrings.enterYourAgeHere,
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      // Weight input
                      InputField(
                        label: AppStrings.weightKg,
                        hint: AppStrings.kg67,
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      // Height input
                      InputField(
                        label: AppStrings.heightCm,
                        hint: AppStrings.cm165,
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 25),
                      // Goal dropdown
                      DropdownField(
                        label: AppStrings.goal,
                        value: _selectedGoal,
                        options: _goalOptions,
                        onChanged: (value) {
                          setState(() {
                            _selectedGoal = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      // Calculate button
                      Center(
                        child: GestureDetector(
                          onTap: _onCalculate,
                          child: Container(
                            width: 321,
                            height: 57,
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.calculate,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom navigation bar
            BottomNavBar(
              currentIndex: _currentNavIndex,
              onTap: _onNavItemTapped,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.bmiCalculator,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        // BMI icon
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppImages.bmiIcon,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
