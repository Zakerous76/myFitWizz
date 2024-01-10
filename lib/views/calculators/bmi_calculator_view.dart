import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/utilities/bottom_nav_bar.dart';

class BMICalculatorView extends StatefulWidget {
  const BMICalculatorView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMICalculatorViewState createState() => _BMICalculatorViewState();
}

class _BMICalculatorViewState extends State<BMICalculatorView> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double? _bmi;
  String _bmiCategory = '';

  void calculateBMI() {
    final double weight = double.parse(_weightController.text);
    final double height =
        double.parse(_heightController.text) / 100; // Convert to meters
    setState(() {
      _bmi = weight / (height * height);
      _bmiCategory = getBMICategory(_bmi!);
    });
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Body Mass Index (BMI)',
        ),
      ),
      body: Padding(
        padding: scaffoldPaddingVar,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(buttonPaddingVar),
                    child: Text(
                      _bmiCategory,
                      style: const TextStyle(
                          color: darkModeTextColorVar,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: calculatorsContainerSizeVar,
                    height: calculatorsContainerSizeVar,
                    decoration: const BoxDecoration(
                      color: buttonColorVar,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _bmi?.toStringAsFixed(1) ?? '-',
                        style: const TextStyle(
                            fontSize: calculatorsFontSizeVar,
                            fontWeight: FontWeight.bold,
                            color: buttonTextColorVar),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  ),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(buttonPaddingVar),
                    child: ElevatedButton(
                      onPressed: calculateBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColorVar,
                      ),
                      child: const Text(
                        'Go',
                        style: TextStyle(
                          color: buttonTextColorVar,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "BMI: Body Mass Index",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    bmiDescriptionVar,
                    style: TextStyle(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBarWidget(context),
    );
  }
}
