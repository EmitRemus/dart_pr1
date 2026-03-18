import 'package:flutter/material.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/app_number_field.dart';
import '../../../../core/widgets/result_section.dart';
import '../../../../core/widgets/result_tile.dart';
import '../viewmodels/fuel_oil_calculator_view_model.dart';

class FuelOilCalculatorPage extends StatefulWidget {
  const FuelOilCalculatorPage({super.key});

  @override
  State<FuelOilCalculatorPage> createState() =>
      _FuelOilCalculatorPageState();
}

class _FuelOilCalculatorPageState extends State<FuelOilCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  late final FuelOilCalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = FuelOilCalculatorViewModel();
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
              'Fuel Oil Input Parameters',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            AppNumberField(
              controller: _viewModel.carbonController,
              label: 'Carbon (Cᵍ), %',
            ),
            AppNumberField(
              controller: _viewModel.hydrogenController,
              label: 'Hydrogen (Hᵍ), %',
            ),
            AppNumberField(
              controller: _viewModel.sulfurController,
              label: 'Sulfur (Sᵍ), %',
            ),
            AppNumberField(
              controller: _viewModel.vanadiumController,
              label: 'Vanadium (V), mg/kg',
            ),
            AppNumberField(
              controller: _viewModel.oxygenController,
              label: 'Oxygen (Oᵍ), %',
            ),
            AppNumberField(
              controller: _viewModel.wetnessController,
              label: 'Moisture of working mass (Wᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.ashController,
              label: 'Ash content of dry mass (Aᶜ), %',
            ),
            AppNumberField(
              controller: _viewModel.lowBurnFireTempController,
              label: 'Lower heating value of combustible mass, MJ/kg',
              helperText:
              'This field is kept to match the original task input. In the current formula set it does not affect the result.',
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
                title: 'Working Mass Composition',
                children: [
                  ResultTile(
                    label: 'Carbon (Cʷ)',
                    value: '${NumberFormatter.fixed2(result.carbonWork)} %',
                  ),
                  ResultTile(
                    label: 'Hydrogen (Hʷ)',
                    value: '${NumberFormatter.fixed2(result.hydrogenWork)} %',
                  ),
                  ResultTile(
                    label: 'Sulfur (Sʷ)',
                    value: '${NumberFormatter.fixed2(result.sulfurWork)} %',
                  ),
                  ResultTile(
                    label: 'Oxygen (Oʷ)',
                    value: '${NumberFormatter.fixed2(result.oxygenWork)} %',
                  ),
                  ResultTile(
                    label: 'Ash (Aʷ)',
                    value: '${NumberFormatter.fixed2(result.ashWork)} %',
                  ),
                  ResultTile(
                    label: 'Vanadium (Vʷ)',
                    value: '${NumberFormatter.fixed2(result.vanadiumWork)} mg/kg',
                  ),
                ],
              ),
              ResultSection(
                title: 'Lower Heating Value',
                children: [
                  ResultTile(
                    label: 'Working mass lower heating value',
                    value:
                    '${NumberFormatter.fixed3(result.burnWorkTemp)} MJ/kg',
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