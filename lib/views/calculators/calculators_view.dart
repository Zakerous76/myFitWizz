import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/utilities/bottom_nav_bar.dart';

class CalculatorsView extends StatefulWidget {
  const CalculatorsView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorsViewState createState() => _CalculatorsViewState();
}

class _CalculatorsViewState extends State<CalculatorsView> {
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();
  final _rpeController = TextEditingController();
  double? _oneRepMax;
  double? _rpeWeight;
  int? _rpeReps;

  void calculateOneRepMax() {
    final double weight = double.parse(_weightController.text);
    final int reps = int.parse(_repsController.text);
    // Using Epley formula for calculating 1RM
    setState(() {
      _oneRepMax = weight * (1 + reps / 30);
    });
  }

  void calculateRPE() {
    final double rpe = double.parse(_rpeController.text);
    final double weight = double.parse(_weightController.text);
    final int reps = int.parse(_repsController.text);
    // Assuming RPE scale to weight and reps conversion needs a specific formula or table values
    // For demonstration, let's use a simple inverse relationship for RPE
    setState(() {
      _rpeWeight = weight * (10 / rpe); // Example calculation
      _rpeReps = (10 / rpe * reps).toInt(); // Example calculation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculators')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display for 1RM and RPE
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: calculatorsContainerSizeVar,
                height: calculatorsContainerSizeVar,
                decoration: const BoxDecoration(
                  color: buttonColorVar,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Estimated',
                        style: TextStyle(color: buttonTextColorVar),
                      ),
                    ),
                    const Text(
                      '1 RM',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: buttonTextColorVar,
                      ),
                    ),
                    Text(
                      _oneRepMax?.toStringAsFixed(1) ?? '0',
                      style: const TextStyle(
                        fontSize: calculatorsFontSizeVar * 1.5,
                        fontWeight: FontWeight.bold,
                        color: buttonTextColorVar,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Input fields for weight and reps
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
            ),
            TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Reps'),
            ),
            Padding(
              padding: const EdgeInsets.all(buttonPaddingVar),
              child: ElevatedButton(
                onPressed: calculateOneRepMax,
                child: const Text('Calculate'),
              ),
            ),
            const SizedBox(height: 24),
            // RPE Calculator
            const Text('RPE - REP Calculator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextField(
              controller: _rpeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'RPE'),
            ),
            Padding(
              padding: const EdgeInsets.all(buttonPaddingVar),
              child: ElevatedButton(
                onPressed: calculateRPE,
                child: const Text('Calculate'),
              ),
            ),
            if (_rpeWeight != null && _rpeReps != null)
              Text(
                  'RPE Weight: ${_rpeWeight!.toStringAsFixed(1)} kg\nRPE Reps: $_rpeReps'),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBarWidget(context),
    );
  }
}
