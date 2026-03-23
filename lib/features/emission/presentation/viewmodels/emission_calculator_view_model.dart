import 'package:flutter/material.dart';

import '../../../../core/utils/number_parser.dart';
import '../../domain/models/emission_input.dart';
import '../../domain/models/emission_result.dart';
import '../../domain/services/emission_calculator_service.dart';

class EmissionCalculatorViewModel extends ChangeNotifier {
  final EmissionCalculatorService _service = EmissionCalculatorService();

  final lowBurnTempController = TextEditingController();
  final ashPartController = TextEditingController();
  final ashMassController = TextEditingController();
  final burnableEjectionController = TextEditingController();
  final cleaningEfficiencyController = TextEditingController();
  final solidEmissionWithSulfurController = TextEditingController();
  final massController = TextEditingController();

  String fuelType = 'user';

  EmissionResult? result;

  bool get isUserInput => fuelType == 'user';

  void setFuelType(String value) {
    fuelType = value;

    if (value != 'user') {
      lowBurnTempController.clear();
      ashPartController.clear();
      ashMassController.clear();
      burnableEjectionController.clear();
      cleaningEfficiencyController.clear();
      solidEmissionWithSulfurController.clear();
    }

    notifyListeners();
  }

  void calculate() {
    final input = EmissionInput(
      fuelType: fuelType,
      lowBurnTemp: NumberParser.tryParse(lowBurnTempController.text) ?? 0,
      ashPart: NumberParser.tryParse(ashPartController.text) ?? 0,
      ashMass: NumberParser.tryParse(ashMassController.text) ?? 0,
      burnableEjection: NumberParser.tryParse(burnableEjectionController.text) ?? 0,
      cleaningEfficiency: NumberParser.tryParse(cleaningEfficiencyController.text) ?? 0,
      solidEmissionWithSulfur:
      NumberParser.tryParse(solidEmissionWithSulfurController.text) ?? 0,
      mass: NumberParser.parse(massController.text),
    );

    result = _service.calculate(input);
    notifyListeners();
  }

  void clear() {
    fuelType = 'user';
    lowBurnTempController.clear();
    ashPartController.clear();
    ashMassController.clear();
    burnableEjectionController.clear();
    cleaningEfficiencyController.clear();
    solidEmissionWithSulfurController.clear();
    massController.clear();
    result = null;
    notifyListeners();
  }

  @override
  void dispose() {
    lowBurnTempController.dispose();
    ashPartController.dispose();
    ashMassController.dispose();
    burnableEjectionController.dispose();
    cleaningEfficiencyController.dispose();
    solidEmissionWithSulfurController.dispose();
    massController.dispose();
    super.dispose();
  }
}