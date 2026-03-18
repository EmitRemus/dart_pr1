import 'package:flutter/material.dart';
import '../../domain/models/fuel_input.dart';
import '../../domain/models/fuel_result.dart';
import '../../domain/services/fuel_calculator_service.dart';
import '../../../../core/utils/number_parser.dart';

class FuelCalculatorViewModel extends ChangeNotifier {
  final FuelCalculatorService _service = FuelCalculatorService();

  final carbonController = TextEditingController();
  final hydrogenController = TextEditingController();
  final sulfurController = TextEditingController();
  final nitrogenController = TextEditingController();
  final oxygenController = TextEditingController();
  final wetnessController = TextEditingController();
  final ashController = TextEditingController();

  FuelResult? result;

  void calculate() {
    final input = FuelInput(
      carbon: NumberParser.parse(carbonController.text),
      hydrogen: NumberParser.parse(hydrogenController.text),
      sulfur: NumberParser.parse(sulfurController.text),
      nitrogen: NumberParser.parse(nitrogenController.text),
      oxygen: NumberParser.parse(oxygenController.text),
      wetness: NumberParser.parse(wetnessController.text),
      ash: NumberParser.parse(ashController.text),
    );

    result = _service.calculate(input);
    notifyListeners();
  }

  void clear() {
    carbonController.clear();
    hydrogenController.clear();
    sulfurController.clear();
    nitrogenController.clear();
    oxygenController.clear();
    wetnessController.clear();
    ashController.clear();
    result = null;
    notifyListeners();
  }

  @override
  void dispose() {
    carbonController.dispose();
    hydrogenController.dispose();
    sulfurController.dispose();
    nitrogenController.dispose();
    oxygenController.dispose();
    wetnessController.dispose();
    ashController.dispose();
    super.dispose();
  }
}