import 'package:flutter/material.dart';

import '../../../../core/utils/number_parser.dart';
import '../../domain/models/margin_input.dart';
import '../../domain/models/margin_result.dart';
import '../../domain/services/margin_calculator_service.dart';

class MarginCalculatorViewModel extends ChangeNotifier {
  final MarginCalculatorService _service = MarginCalculatorService();

  final sig1Controller = TextEditingController();
  final sig2Controller = TextEditingController();
  final psController = TextEditingController();
  final bController = TextEditingController();

  MarginResult? result;

  void calculate() {
    final input = MarginInput(
      sig1: NumberParser.parse(sig1Controller.text),
      sig2: NumberParser.parse(sig2Controller.text),
      ps: NumberParser.parse(psController.text),
      b: NumberParser.parse(bController.text),
    );

    result = _service.calculate(input);
    notifyListeners();
  }

  void clear() {
    sig1Controller.clear();
    sig2Controller.clear();
    psController.clear();
    bController.clear();
    result = null;
    notifyListeners();
  }

  @override
  void dispose() {
    sig1Controller.dispose();
    sig2Controller.dispose();
    psController.dispose();
    bController.dispose();
    super.dispose();
  }
}