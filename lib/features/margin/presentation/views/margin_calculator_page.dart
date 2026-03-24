import 'package:flutter/material.dart';

import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/app_number_field.dart';
import '../../../../core/widgets/result_section.dart';
import '../../../../core/widgets/result_tile.dart';
import '../viewmodels/margin_calculator_view_model.dart';

class MarginCalculatorPage extends StatefulWidget {
  const MarginCalculatorPage({super.key});

  @override
  State<MarginCalculatorPage> createState() => _MarginCalculatorPageState();
}

class _MarginCalculatorPageState extends State<MarginCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  late final MarginCalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MarginCalculatorViewModel();
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
              'Input Parameters',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            AppNumberField(
              controller: _viewModel.sig1Controller,
              label: 'σ₁ — standard forecasting system deviation, MW',
            ),
            AppNumberField(
              controller: _viewModel.sig2Controller,
              label: 'σ₂ — improved forecasting system deviation, MW',
            ),
            AppNumberField(
              controller: _viewModel.psController,
              label: 'Pc — average daily power, MW',
            ),
            AppNumberField(
              controller: _viewModel.bController,
              label: 'B — electricity price, UAH/kWh',
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
                title: 'Station with Standard Solar Forecasting System',
                children: [
                  ResultTile(
                    label: 'Share of electricity generated without imbalances',
                    value: '${NumberFormatter.fixed2(result.deltaW1)} %',
                  ),
                  ResultTile(
                    label: 'Plant profit without penalties',
                    value: '${result.p1} thousand UAH',
                  ),
                  ResultTile(
                    label: 'Penalty',
                    value: '${result.h1} thousand UAH',
                  ),
                  ResultTile(
                    label: 'Net plant profit',
                    value: '${result.net1} thousand UAH',
                  ),
                ],
              ),
              ResultSection(
                title: 'Station with Improved Solar Forecasting System',
                children: [
                  ResultTile(
                    label: 'Share of electricity generated without imbalances',
                    value: '${NumberFormatter.fixed2(result.deltaW2)} %',
                  ),
                  ResultTile(
                    label: 'Plant profit without penalties',
                    value: '${result.p2} thousand UAH',
                  ),
                  ResultTile(
                    label: 'Penalty',
                    value: '${result.h2} thousand UAH',
                  ),
                  ResultTile(
                    label: 'Net plant profit',
                    value: '${result.net2} thousand UAH',
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