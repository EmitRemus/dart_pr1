import 'package:flutter/material.dart';

import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/app_number_field.dart';
import '../../../../core/widgets/result_section.dart';
import '../../../../core/widgets/result_tile.dart';
import '../viewmodels/electrical_calculator_view_model.dart';

class ElectricalCalculatorPage extends StatefulWidget {
  const ElectricalCalculatorPage({super.key});

  @override
  State<ElectricalCalculatorPage> createState() => _ElectricalCalculatorPageState();
}

class _ElectricalCalculatorPageState extends State<ElectricalCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  late final ElectricalCalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ElectricalCalculatorViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _viewModel.calculate();
    });
  }

  void _clear() {
    setState(() {
      _viewModel.clear();
    });
  }

  void _fillExample() {
    setState(() {
      _viewModel.fillControlExample();
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _viewModel.result;

    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Input Parameters',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const Text(
              'Cable Cross-Section',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            AppNumberField(
              controller: _viewModel.sMController,
              label: 'Sm — calculated load, kVA',
            ),
            AppNumberField(
              controller: _viewModel.uNomController,
              label: 'Unom — enterprise internal supply voltage, kV',
            ),
            AppNumberField(
              controller: _viewModel.iKController,
              label: 'Ik — short-circuit current, kA',
            ),
            AppNumberField(
              controller: _viewModel.tFController,
              label: 'tf — fictitious switch-off time, s',
            ),

            const SizedBox(height: 8),
            const Text(
              'Three-Phase Short-Circuit Current',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            AppNumberField(
              controller: _viewModel.sKController,
              label: 'Sk — short-circuit power, MVA',
            ),
            AppNumberField(
              controller: _viewModel.uCnController,
              label: 'Ucn — average nominal voltage at fault point, kV',
            ),
            AppNumberField(
              controller: _viewModel.uKController,
              label: 'Uk% — transformer short-circuit voltage, %',
            ),
            AppNumberField(
              controller: _viewModel.sNomTController,
              label: 'Snom.t — transformer nominal power, MVA',
            ),

            const SizedBox(height: 8),
            const Text(
              'Currents for the Highest-Resistance Section',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            AppNumberField(
              controller: _viewModel.lController,
              label: 'l — network section length, km',
            ),
            AppNumberField(
              controller: _viewModel.uKMaxController,
              label: 'Uk.max — maximum transformer short-circuit voltage, %',
            ),
            AppNumberField(
              controller: _viewModel.uVnController,
              label: 'Uvn — average nominal high-side voltage, kV',
            ),
            AppNumberField(
              controller: _viewModel.uNnController,
              label: 'Unn — low-side voltage, kV',
            ),
            AppNumberField(
              controller: _viewModel.rSnController,
              label: 'Rsn — active resistance in normal mode, Ω',
            ),
            AppNumberField(
              controller: _viewModel.xSnController,
              label: 'Xsn — reactive resistance in normal mode, Ω',
            ),
            AppNumberField(
              controller: _viewModel.rSMinController,
              label: 'Rs.min — active resistance in minimum mode, Ω',
            ),
            AppNumberField(
              controller: _viewModel.xSMinController,
              label: 'Xs.min — reactive resistance in minimum mode, Ω',
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _calculate,
                    child: const Text('Calculate'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clear,
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _fillExample,
              child: const Text('Fill control example'),
            ),

            const SizedBox(height: 24),

            const Text(
              'Results',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            if (result == null)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Enter the input values and tap Calculate.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            else ...[
              ResultSection(
                title: 'Cable Selection',
                children: [
                  ResultTile(
                    label: 'Optimal cable cross-section',
                    value: '${NumberFormatter.fixed2(result.optimalCableSection)} mm²',
                  ),
                  ResultTile(
                    label: 'Economic cable cross-section',
                    value: '${NumberFormatter.fixed2(result.economicCableSection)} mm²',
                  ),
                ],
              ),
              ResultSection(
                title: 'Three-Phase Short-Circuit Current',
                children: [
                  ResultTile(
                    label: 'Initial RMS value of three-phase short-circuit current',
                    value:
                    '${NumberFormatter.fixed2(result.threePhaseShortCircuitCurrent)} kA',
                  ),
                ],
              ),
              ResultSection(
                title: '10 kV Busbars',
                children: [
                  ResultTile(
                    label: 'Three-phase SC current, normal mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[0][0])} A',
                  ),
                  ResultTile(
                    label: 'Two-phase SC current, normal mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[0][1])} A',
                  ),
                  ResultTile(
                    label: 'Three-phase SC current, minimum mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[0][2])} A',
                  ),
                  ResultTile(
                    label: 'Two-phase SC current, minimum mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[0][3])} A',
                  ),
                ],
              ),
              ResultSection(
                title: 'Reduced to 0.4 kV Busbars',
                children: [
                  ResultTile(
                    label: 'Three-phase SC current, normal mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[1][0])} A',
                  ),
                  ResultTile(
                    label: 'Two-phase SC current, normal mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[1][1])} A',
                  ),
                  ResultTile(
                    label: 'Three-phase SC current, minimum mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[1][2])} A',
                  ),
                  ResultTile(
                    label: 'Two-phase SC current, minimum mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[1][3])} A',
                  ),
                ],
              ),
              ResultSection(
                title: 'Highest-Resistance Section',
                children: [
                  ResultTile(
                    label: 'Three-phase SC current, normal mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[2][0])} A',
                  ),
                  ResultTile(
                    label: 'Two-phase SC current, normal mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[2][1])} A',
                  ),
                  ResultTile(
                    label: 'Three-phase SC current, minimum mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[2][2])} A',
                  ),
                  ResultTile(
                    label: 'Two-phase SC current, minimum mode',
                    value: '${NumberFormatter.fixed2(result.stationKz[2][3])} A',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}