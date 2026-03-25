import 'package:flutter/material.dart';

import '../../../../core/utils/number_parser.dart';
import '../../domain/models/electrical_input.dart';
import '../../domain/models/electrical_result.dart';
import '../../domain/services/electrical_calculator_service.dart';

class ElectricalCalculatorViewModel extends ChangeNotifier {
  final ElectricalCalculatorService _service = ElectricalCalculatorService();

  final sMController = TextEditingController();
  final uNomController = TextEditingController();
  final iKController = TextEditingController();
  final tFController = TextEditingController();

  final sKController = TextEditingController();
  final uCnController = TextEditingController();
  final uKController = TextEditingController();
  final sNomTController = TextEditingController();

  final lController = TextEditingController();
  final uKMaxController = TextEditingController();
  final uVnController = TextEditingController();
  final uNnController = TextEditingController();
  final rSnController = TextEditingController();
  final xSnController = TextEditingController();
  final rSMinController = TextEditingController();
  final xSMinController = TextEditingController();

  ElectricalResult? result;

  void fillControlExample() {
    uNomController.text = '10';
    iKController.text = '2.5';
    tFController.text = '2.5';
    sMController.text = '1300';

    sKController.text = '200';
    uCnController.text = '10.5';
    uKController.text = '10.5';
    sNomTController.text = '6.3';

    lController.text = '12.37';
    uKMaxController.text = '11.1';
    uVnController.text = '10';
    uNnController.text = '0.4';
    rSnController.text = '8.01';
    xSnController.text = '6.8';
    rSMinController.text = '8.22';
    xSMinController.text = '7.18';

    notifyListeners();
  }

  void calculate() {
    final input = ElectricalInput(
      sM: NumberParser.parse(sMController.text),
      uNom: NumberParser.parse(uNomController.text),
      iK: NumberParser.parse(iKController.text),
      tF: NumberParser.parse(tFController.text),
      sK: NumberParser.parse(sKController.text),
      uCn: NumberParser.parse(uCnController.text),
      uK: NumberParser.parse(uKController.text),
      sNomT: NumberParser.parse(sNomTController.text),
      l: NumberParser.parse(lController.text),
      uKMax: NumberParser.parse(uKMaxController.text),
      uVn: NumberParser.parse(uVnController.text),
      uNn: NumberParser.parse(uNnController.text),
      rSn: NumberParser.parse(rSnController.text),
      xSn: NumberParser.parse(xSnController.text),
      rSMin: NumberParser.parse(rSMinController.text),
      xSMin: NumberParser.parse(xSMinController.text),
    );

    result = _service.calculate(input);
    notifyListeners();
  }

  void clear() {
    sMController.clear();
    uNomController.clear();
    iKController.clear();
    tFController.clear();

    sKController.clear();
    uCnController.clear();
    uKController.clear();
    sNomTController.clear();

    lController.clear();
    uKMaxController.clear();
    uVnController.clear();
    uNnController.clear();
    rSnController.clear();
    xSnController.clear();
    rSMinController.clear();
    xSMinController.clear();

    result = null;
    notifyListeners();
  }

  @override
  void dispose() {
    sMController.dispose();
    uNomController.dispose();
    iKController.dispose();
    tFController.dispose();
    sKController.dispose();
    uCnController.dispose();
    uKController.dispose();
    sNomTController.dispose();
    lController.dispose();
    uKMaxController.dispose();
    uVnController.dispose();
    uNnController.dispose();
    rSnController.dispose();
    xSnController.dispose();
    rSMinController.dispose();
    xSMinController.dispose();
    super.dispose();
  }
}