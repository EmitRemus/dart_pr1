import 'package:flutter/material.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/app_number_field.dart';
import '../../../../core/widgets/result_section.dart';
import '../../../../core/widgets/result_tile.dart';
import '../viewmodels/fuel_calculator_view_model.dart';

class FuelCalculatorPage extends StatefulWidget {
  const FuelCalculatorPage({super.key});

  @override
  State<FuelCalculatorPage> createState() => _FuelCalculatorPageState();
}

class _FuelCalculatorPageState extends State<FuelCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  late final FuelCalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = FuelCalculatorViewModel();
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
              'Fuel Input Parameters',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            AppNumberField(
              controller: _viewModel.carbonController,
              label: 'Carbon (Cᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.hydrogenController,
              label: 'Hydrogen (Hᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.sulfurController,
              label: 'Sulfur (Sᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.nitrogenController,
              label: 'Nitrogen (Nᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.oxygenController,
              label: 'Oxygen (Oᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.wetnessController,
              label: 'Moisture (Wᵖ), %',
            ),
            AppNumberField(
              controller: _viewModel.ashController,
              label: 'Ash (Aᵖ), %',
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
                title: 'Conversion Coefficients',
                children: [
                  ResultTile(
                    label: 'Working mass → dry mass coefficient',
                    value: NumberFormatter.fixed2(result.wetDryCoef),
                  ),
                  ResultTile(
                    label: 'Working mass → combustible mass coefficient',
                    value: NumberFormatter.fixed2(result.wetFireCoef),
                  ),
                ],
              ),
              ResultSection(
                title: 'Dry Mass Composition',
                children: [
                  ResultTile(
                    label: 'Carbon (Cᶜ)',
                    value: '${NumberFormatter.fixed2(result.carbonDry)} %',
                  ),
                  ResultTile(
                    label: 'Hydrogen (Hᶜ)',
                    value: '${NumberFormatter.fixed2(result.hydrogenDry)} %',
                  ),
                  ResultTile(
                    label: 'Sulfur (Sᶜ)',
                    value: '${NumberFormatter.fixed2(result.sulfurDry)} %',
                  ),
                  ResultTile(
                    label: 'Nitrogen (Nᶜ)',
                    value: '${NumberFormatter.fixed2(result.nitrogenDry)} %',
                  ),
                  ResultTile(
                    label: 'Oxygen (Oᶜ)',
                    value: '${NumberFormatter.fixed2(result.oxygenDry)} %',
                  ),
                  ResultTile(
                    label: 'Ash (Aᶜ)',
                    value: '${NumberFormatter.fixed2(result.ashDry)} %',
                  ),
                ],
              ),
              ResultSection(
                title: 'Combustible Mass Composition',
                children: [
                  ResultTile(
                    label: 'Carbon (Cᵍ)',
                    value: '${NumberFormatter.fixed2(result.carbonFire)} %',
                  ),
                  ResultTile(
                    label: 'Hydrogen (Hᵍ)',
                    value: '${NumberFormatter.fixed2(result.hydrogenFire)} %',
                  ),
                  ResultTile(
                    label: 'Sulfur (Sᵍ)',
                    value: '${NumberFormatter.fixed2(result.sulfurFire)} %',
                  ),
                  ResultTile(
                    label: 'Nitrogen (Nᵍ)',
                    value: '${NumberFormatter.fixed2(result.nitrogenFire)} %',
                  ),
                  ResultTile(
                    label: 'Oxygen (Oᵍ)',
                    value: '${NumberFormatter.fixed2(result.oxygenFire)} %',
                  ),
                ],
              ),
              ResultSection(
                title: 'Lower Heating Value',
                children: [
                  ResultTile(
                    label: 'Working mass',
                    value: '${NumberFormatter.fixed3(result.lowBurnTemp)} MJ/kg',
                  ),
                  ResultTile(
                    label: 'Dry mass',
                    value:
                    '${NumberFormatter.fixed3(result.lowBurnDryTemp)} MJ/kg',
                  ),
                  ResultTile(
                    label: 'Combustible mass',
                    value:
                    '${NumberFormatter.fixed3(result.lowBurnFireTemp)} MJ/kg',
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