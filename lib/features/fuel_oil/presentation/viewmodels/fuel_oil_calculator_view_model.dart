import 'package:flutter/material.dart';
import '../../../../core/utils/number_parser.dart';
import '../../domain/models/fuel_oil_input.dart';
import '../../domain/models/fuel_oil_result.dart';
import '../../domain/services/fuel_oil_calculator_service.dart';

class FuelOilCalculatorViewModel extends ChangeNotifier {
  final FuelOilCalculatorService _service = FuelOilCalculatorService();

  final carbonController = TextEditingController();
  final hydrogenController = TextEditingController();
  final sulfurController = TextEditingController();
  final vanadiumController = TextEditingController();
  final oxygenController = TextEditingController();
  final wetnessController = TextEditingController();
  final ashController = TextEditingController();
  final lowBurnFireTempController = TextEditingController();

  FuelOilResult? result;

  void calculate() {
    final input = FuelOilInput(
      carbon: NumberParser.parse(carbonController.text),
      hydrogen: NumberParser.parse(hydrogenController.text),
      sulfur: NumberParser.parse(sulfurController.text),
      vanadium: NumberParser.parse(vanadiumController.text),
      oxygen: NumberParser.parse(oxygenController.text),
      wetness: NumberParser.parse(wetnessController.text),
      ash: NumberParser.parse(ashController.text),
      lowBurnFireTemp: NumberParser.parse(lowBurnFireTempController.text),
    );

    result = _service.calculate(input);
    notifyListeners();
  }

  void clear() {
    carbonController.clear();
    hydrogenController.clear();
    sulfurController.clear();
    vanadiumController.clear();
    oxygenController.clear();
    wetnessController.clear();
    ashController.clear();
    lowBurnFireTempController.clear();
    result = null;
    notifyListeners();
  }

  @override
  void dispose() {
    carbonController.dispose();
    hydrogenController.dispose();
    sulfurController.dispose();
    vanadiumController.dispose();
    oxygenController.dispose();
    wetnessController.dispose();
    ashController.dispose();
    lowBurnFireTempController.dispose();
    super.dispose();
  }
}