import 'dart:math';
import 'package:flutter/material.dart';

const List<Widget> sex = <Widget>[
  Text('Male'),
  Text('Female')
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terpiez',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart-Lung Calculator'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              // Heart button
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HeartCalculator()),
                  );
                },
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 2,
                  color: const Color.fromARGB(255, 238, 134, 132),
                  child: const Center(
                    child: Text(
                      "Heart",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Lung button
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LungCalculator()),
                  );
                },
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 2,
                  color: Colors.blue.shade300,
                  child: const Center(
                    child: Text(
                      "Lung",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


class HeartCalculator extends StatefulWidget {
  const HeartCalculator({super.key});

  @override
  State<HeartCalculator> createState() => _HeartCalculatorState();
}

class _HeartCalculatorState extends State<HeartCalculator> {
  // Donor Controllers
  final TextEditingController donorAgeController = TextEditingController();
  final TextEditingController donorWeightController = TextEditingController();
  final TextEditingController donorHeightController = TextEditingController();

  // Recipient Controllers
  final TextEditingController recipientAgeController = TextEditingController();
  final TextEditingController recipientWeightController = TextEditingController();
  final TextEditingController recipientHeightController = TextEditingController();

  // Toggles for gender selection
  final List<bool> _selectedSexDonor = <bool>[true, false];
  final List<bool> _selectedSexRecipient = <bool>[true, false];
  bool vertical = false;

  // Separate unit toggles for donor inputs
  // For weight: index 0 = kg, index 1 = lbs. Default to kg.
  final List<bool> _selectedDonorWeightUnit = [true, false];
  // For height: index 0 = cm, index 1 = in. Default to cm.
  final List<bool> _selectedDonorHeightUnit = [true, false];

  // Separate unit toggles for recipient inputs
  final List<bool> _selectedRecipientWeightUnit = [true, false];
  final List<bool> _selectedRecipientHeightUnit = [true, false];

  // A helper method to build larger ToggleButtons for units.
  Widget buildUnitToggle({
    required List<bool> isSelected,
    required ValueChanged<int> onPressed,
    required List<String> labels,
  }) {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onPressed,
      constraints: const BoxConstraints(minWidth: 70, minHeight: 50),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.white,
      fillColor: Theme.of(context).primaryColor,
      children: labels
          .map((label) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(label, style: const TextStyle(fontSize: 18)),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Donor Section
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Donor', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    ToggleButtons(
                      direction: vertical ? Axis.vertical : Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedSexDonor.length; i++) {
                            _selectedSexDonor[i] = (i == index);
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
                      isSelected: _selectedSexDonor,
                      children: sex,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Donor Age
                Row(
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Age', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: donorAgeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'years',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Donor Weight with unit toggle
                Row(
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Weight', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: donorWeightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'value',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    buildUnitToggle(
                      isSelected: _selectedDonorWeightUnit,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedDonorWeightUnit.length; i++) {
                            _selectedDonorWeightUnit[i] = (i == index);
                          }
                        });
                      },
                      labels: const ['kg', 'lbs'],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Donor Height with unit toggle
                Row(
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Height', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: donorHeightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'value',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    buildUnitToggle(
                      isSelected: _selectedDonorHeightUnit,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedDonorHeightUnit.length; i++) {
                            _selectedDonorHeightUnit[i] = (i == index);
                          }
                        });
                      },
                      labels: const ['cm', 'in'],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Recipient Section
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Recipient', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    ToggleButtons(
                      direction: vertical ? Axis.vertical : Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedSexRecipient.length; i++) {
                            _selectedSexRecipient[i] = (i == index);
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
                      isSelected: _selectedSexRecipient,
                      children: sex,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Recipient Age
                Row(
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Age', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: recipientAgeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'years',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Recipient Weight with unit toggle
                Row(
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Weight', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: recipientWeightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'value',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    buildUnitToggle(
                      isSelected: _selectedRecipientWeightUnit,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedRecipientWeightUnit.length; i++) {
                            _selectedRecipientWeightUnit[i] = (i == index);
                          }
                        });
                      },
                      labels: const ['kg', 'lbs'],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Recipient Height with unit toggle
                Row(
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Height', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: recipientHeightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'value',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    buildUnitToggle(
                      isSelected: _selectedRecipientHeightUnit,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedRecipientHeightUnit.length; i++) {
                            _selectedRecipientHeightUnit[i] = (i == index);
                          }
                        });
                      },
                      labels: const ['cm', 'in'],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Calculate Button with Input Validation and Unit Conversion
                InkWell(
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    child: const Center(child: Text("Calculate!")),
                  ),
                  onTap: () {
                    // Validate that none of the fields are empty.
                    if (donorAgeController.text.trim().isEmpty ||
                        donorWeightController.text.trim().isEmpty ||
                        donorHeightController.text.trim().isEmpty ||
                        recipientAgeController.text.trim().isEmpty ||
                        recipientWeightController.text.trim().isEmpty ||
                        recipientHeightController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all required fields."),
                        ),
                      );
                      return;
                    }

                    // Read raw values.
                    final donorAgeStr = donorAgeController.text;
                    final donorWeightStr = donorWeightController.text;
                    final donorHeightStr = donorHeightController.text;
                    final recipientAgeStr = recipientAgeController.text;
                    final recipientWeightStr = recipientWeightController.text;
                    final recipientHeightStr = recipientHeightController.text;

                    // Parse age values.
                    final int donorAgeInt = int.tryParse(donorAgeStr) ?? 0;
                    final int recipientAgeInt = int.tryParse(recipientAgeStr) ?? 0;

                    // Parse weight and height inputs as double.
                    double donorWeightInput = double.tryParse(donorWeightStr) ?? 0;
                    double donorHeightInput = double.tryParse(donorHeightStr) ?? 0;
                    double recipientWeightInput = double.tryParse(recipientWeightStr) ?? 0;
                    double recipientHeightInput = double.tryParse(recipientHeightStr) ?? 0;

                    // Convert donor weight if needed (lbs to kg).
                    if (_selectedDonorWeightUnit[1]) {
                      donorWeightInput *= 0.453592;
                    }
                    // Convert donor height if needed (in to cm).
                    if (_selectedDonorHeightUnit[1]) {
                      donorHeightInput *= 2.54;
                    }
                    // Convert recipient weight if needed.
                    if (_selectedRecipientWeightUnit[1]) {
                      recipientWeightInput *= 0.453592;
                    }
                    // Convert recipient height if needed.
                    if (_selectedRecipientHeightUnit[1]) {
                      recipientHeightInput *= 2.54;
                    }

                    // Round the converted values and convert to int.
                    final int donorWeightInt = donorWeightInput.round();
                    final int donorHeightInt = donorHeightInput.round();
                    final int recipientWeightInt = recipientWeightInput.round();
                    final int recipientHeightInt = recipientHeightInput.round();

                    // Determine gender selection.
                    String donorSex = _selectedSexDonor[0] ? "Male" : "Female";
                    String recipientSex = _selectedSexRecipient[0] ? "Male" : "Female";

                    // Navigate to the Results screen with the input values.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeartResults(
                          donorAge: donorAgeInt,
                          donorWeight: donorWeightInt,
                          donorHeight: donorHeightInt,
                          recipientAge: recipientAgeInt,
                          recipientWeight: recipientWeightInt,
                          recipientHeight: recipientHeightInt,
                          donorSex: donorSex,
                          recipientSex: recipientSex,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class LungCalculator extends StatefulWidget {
  const LungCalculator({super.key});

  @override
  State<LungCalculator> createState() => _LungCalculatorState();
}

class _LungCalculatorState extends State<LungCalculator> {
  // Text Editing Controllers
  final TextEditingController donorHeightController = TextEditingController();
  final TextEditingController recipientHeightController = TextEditingController();

  // ToggleButtons for sex selection
  final List<bool> _selectedSexDonor = [true, false];
  final List<bool> _selectedSexRecipient = [true, false];

  // ToggleButtons for height units: index 0 = cm, index 1 = in. Default is cm.
  final List<bool> _selectedDonorHeightUnit = [true, false];
  final List<bool> _selectedRecipientHeightUnit = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lung Calculator')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Donor Sex Toggle
                Row(
                  children: [
                    const Text('Donor Sex: ', style: TextStyle(fontSize: 16)),
                    ToggleButtons(
                      isSelected: _selectedSexDonor,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedSexDonor.length; i++) {
                            _selectedSexDonor[i] = (i == index);
                          }
                        });
                      },
                      children: const [Text('Male'), Text('Female')],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Donor Height Input with Unit Toggle
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text('Donor Height:', style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: donorHeightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter height',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ToggleButtons(
                      isSelected: _selectedDonorHeightUnit,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedDonorHeightUnit.length; i++) {
                            _selectedDonorHeightUnit[i] = (i == index);
                          }
                        });
                      },
                      children: const [Text('cm'), Text('in')],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Recipient Sex Toggle
                Row(
                  children: [
                    const Text('Recipient Sex: ', style: TextStyle(fontSize: 16)),
                    ToggleButtons(
                      isSelected: _selectedSexRecipient,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedSexRecipient.length; i++) {
                            _selectedSexRecipient[i] = (i == index);
                          }
                        });
                      },
                      children: const [Text('Male'), Text('Female')],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Recipient Height Input with Unit Toggle
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text('Recipient Height:', style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: recipientHeightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter height',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ToggleButtons(
                      isSelected: _selectedRecipientHeightUnit,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedRecipientHeightUnit.length; i++) {
                            _selectedRecipientHeightUnit[i] = (i == index);
                          }
                        });
                      },
                      children: const [Text('cm'), Text('in')],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Calculate Button with Input Validation and Unit Conversion
                ElevatedButton(
                  onPressed: () {
                    // Validate inputs
                    if (donorHeightController.text.trim().isEmpty ||
                        recipientHeightController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all required fields."),
                        ),
                      );
                      return;
                    }
                    // Read raw input values
                    final donorHeightStr = donorHeightController.text;
                    final recipientHeightStr = recipientHeightController.text;
                    
                    // Parse height values
                    double donorHeightInput = double.tryParse(donorHeightStr) ?? 0;
                    double recipientHeightInput = double.tryParse(recipientHeightStr) ?? 0;
                    
                    // Convert donor height if unit is inches to centimeters.
                    if (_selectedDonorHeightUnit[1]) {
                      donorHeightInput *= 2.54;
                    }
                    // Convert recipient height if unit is inches to centimeters.
                    if (_selectedRecipientHeightUnit[1]) {
                      recipientHeightInput *= 2.54;
                    }
                    
                    final int donorHeightInt = donorHeightInput.round();
                    final int recipientHeightInt = recipientHeightInput.round();
                    
                    // Determine sex selections
                    final String donorSex = _selectedSexDonor[0] ? "Male" : "Female";
                    final String recipientSex = _selectedSexRecipient[0] ? "Male" : "Female";
                    
                    // Navigate to LungResults with the converted height values
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LungResults(
                          donorHeight: donorHeightInt,
                          donorSex: donorSex,
                          recipientHeight: recipientHeightInt,
                          recipientSex: recipientSex,
                        ),
                      ),
                    );
                  },
                  child: const Text('Calculate!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
                         




class HeartResults extends StatelessWidget {
  final int donorAge;
  final int donorWeight;
  final int donorHeight; // in cm
  final int recipientAge;
  final int recipientWeight;
  final int recipientHeight; // in cm
  final String donorSex;     // "Male" or "Female"
  final String recipientSex; // "Male" or "Female"

  const HeartResults({
    Key? key,
    required this.donorAge,
    required this.donorWeight,
    required this.donorHeight,
    required this.recipientAge,
    required this.recipientWeight,
    required this.recipientHeight,
    required this.donorSex,
    required this.recipientSex,
  }) : super(key: key);

  /// Predicted Left Ventricular Mass (g)
  double predictedLeftVentricularMass({
    required int weight,
    required int heightCm,
    required String sex,
  }) {
    final double heightM = heightCm / 100.0;
    final double a = (sex == "Male") ? 8.25 : 6.82;
    return a * pow(heightM, 0.54).toDouble() * pow(weight, 0.61).toDouble();
  }

  /// Predicted Right Ventricular Mass (g)
  double predictedRightVentricularMass({
    required int age,
    required int weight,
    required int heightCm,
    required String sex,
  }) {
    final double heightM = heightCm / 100.0;
    final double a = (sex == "Male") ? 11.25 : 10.59;
    final double ageFactor = pow(age, -0.32).toDouble();
    return a * ageFactor * pow(heightM, 1.135).toDouble() * pow(weight, 0.315).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate donor values
    final double donorLVM = predictedLeftVentricularMass(
      weight: donorWeight,
      heightCm: donorHeight,
      sex: donorSex,
    );
    final double donorRVM = predictedRightVentricularMass(
      age: donorAge,
      weight: donorWeight,
      heightCm: donorHeight,
      sex: donorSex,
    );
    final double donorPHM = donorLVM + donorRVM;

    // Calculate recipient values
    final double recipientLVM = predictedLeftVentricularMass(
      weight: recipientWeight,
      heightCm: recipientHeight,
      sex: recipientSex,
    );
    final double recipientRVM = predictedRightVentricularMass(
      age: recipientAge,
      weight: recipientWeight,
      heightCm: recipientHeight,
      sex: recipientSex,
    );
    final double recipientPHM = recipientLVM + recipientRVM;

    // Calculate ratio: ((recipientPHM - donorPHM) / recipientPHM) * 100
    double ratio = 0.0;
    if (recipientPHM != 0.0) {
      ratio = ((recipientPHM - donorPHM) / recipientPHM) * 100.0;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Heart Results')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Donor Information
                const Text(
                  'Donor Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('Age: $donorAge', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text('Weight: $donorWeight kg', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text('Height: $donorHeight cm', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text('Sex: $donorSex', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Recipient Information
                const Text(
                  'Recipient Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('Age: $recipientAge', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text('Weight: $recipientWeight kg', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text('Height: $recipientHeight cm', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text('Sex: $recipientSex', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Calculated Results
                const Text(
                  'Calculated Results',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Text('Donor Left Ventricular Mass: ${donorLVM.toStringAsFixed(2)} g',
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                Text('Donor Right Ventricular Mass: ${donorRVM.toStringAsFixed(2)} g',
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                Text('Donor Predicted Heart Mass: ${donorPHM.toStringAsFixed(2)} g',
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('Recipient Left Ventricular Mass: ${recipientLVM.toStringAsFixed(2)} g',
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                Text('Recipient Right Ventricular Mass: ${recipientRVM.toStringAsFixed(2)} g',
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                Text('Recipient Predicted Heart Mass: ${recipientPHM.toStringAsFixed(2)} g',
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Text(
                  'pHM Ratio: ${ratio.toStringAsFixed(2)}%',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Button to go back to the homepage
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to Homepage by clearing the stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                      (route) => false,
                    );
                  },
                  child: const Text('Enter New Patient Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class LungResults extends StatelessWidget {
  final int donorHeight;    // in cm
  final String donorSex;    // "Male" or "Female"
  final int recipientHeight; // in cm
  final String recipientSex; // "Male" or "Female"

  const LungResults({
    Key? key,
    required this.donorHeight,
    required this.donorSex,
    required this.recipientHeight,
    required this.recipientSex,
  }) : super(key: key);

  /// Predicted Total Lung Capacity (pTLC)
  /// For Men: pTLC = (7.99 * height in m) - 7.08
  /// For Women: pTLC = (6.60 * height in m) - 5.79
  double predictedTLC({
    required int heightCm,
    required String sex,
  }) {
    final double heightM = heightCm / 100.0;
    if (sex == "Male") {
      return 7.99 * heightM - 7.08;
    } else {
      return 6.60 * heightM - 5.79;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double donorPTLC = predictedTLC(heightCm: donorHeight, sex: donorSex);
    final double recipientPTLC = predictedTLC(heightCm: recipientHeight, sex: recipientSex);

    double ratio = 0.0;
    if (recipientPTLC != 0.0) {
      ratio = donorPTLC / recipientPTLC;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Lung Results')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Donor Information
                const Text(
                  'Donor Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          'Height: $donorHeight cm',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Sex: $donorSex',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Recipient Information
                const Text(
                  'Recipient Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          'Height: $recipientHeight cm',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Sex: $recipientSex',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Calculated Results
                const Text(
                  'Calculated Results',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Text(
                  'Donor pTLC: ${donorPTLC.toStringAsFixed(2)} L',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Recipient pTLC: ${recipientPTLC.toStringAsFixed(2)} L',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'pTLC Ratio (Donor/Recipient): ${ratio.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Insert the image before the button
                Image.asset('assets/images/relativerisk.jpeg'),
                const SizedBox(height: 30),
                // Button to go back to the homepage
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                      (route) => false,
                    );
                  },
                  child: const Text('Enter New Patient Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

