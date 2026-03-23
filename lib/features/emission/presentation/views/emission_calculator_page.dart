import 'package:flutter/material.dart';

import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/app_number_field.dart';
import '../../../../core/widgets/result_section.dart';
import '../../../../core/widgets/result_tile.dart';
import '../viewmodels/emission_calculator_view_model.dart';

class EmissionCalculatorPage extends StatefulWidget {
  const EmissionCalculatorPage({super.key});

  @override
  State<EmissionCalculatorPage> createState() => _EmissionCalculatorPageState();
}

class _EmissionCalculatorPageState extends State<EmissionCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  late final EmissionCalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = EmissionCalculatorViewModel();
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
    final isUserInput = _viewModel.isUserInput;

    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Emission Input Parameters',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _viewModel.fuelType,
              decoration: const InputDecoration(
                labelText: 'Fuel Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'user',
                  child: Text('Custom input'),
                ),
                DropdownMenuItem(
                  value: 'coal',
                  child: Text('Donetsk gas coal (GR)'),
                ),
                DropdownMenuItem(
                  value: 'mazut',
                  child: Text('High-sulfur fuel oil grade 40'),
                ),
                DropdownMenuItem(
                  value: 'gas',
                  child: Text('Natural gas (Urengoy–Uzhhorod)'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _viewModel.setFuelType(value);
                });
              },
            ),

            const SizedBox(height: 14),

            if (isUserInput) ...[
              AppNumberField(
                controller: _viewModel.lowBurnTempController,
                label: 'Lower heating value (Qri), MJ/kg',
              ),
              AppNumberField(
                controller: _viewModel.ashPartController,
                label: 'Fly ash fraction (aesc)',
              ),
              AppNumberField(
                controller: _viewModel.ashMassController,
                label: 'Ash content in working mass (Ar), %',
              ),
              AppNumberField(
                controller: _viewModel.burnableEjectionController,
                label: 'Combustible content in solid emissions, %',
              ),
              AppNumberField(
                controller: _viewModel.cleaningEfficiencyController,
                label: 'Gas cleaning efficiency (ηzu)',
              ),
              AppNumberField(
                controller: _viewModel.solidEmissionWithSulfurController,
                label: 'Solid emission with sulfur interaction (ktvS), g/GJ',
              ),
            ],

            AppNumberField(
              controller: _viewModel.massController,
              label: 'Fuel mass, t',
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
                title: 'Calculated Indicators',
                children: [
                  ResultTile(
                    label: 'Solid particle emission factor (ktv)',
                    value: '${NumberFormatter.fixed2(result.emission)} g/GJ',
                  ),
                  ResultTile(
                    label: 'Gross emission (Etv)',
                    value: '${NumberFormatter.fixed2(result.ejection)} t',
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