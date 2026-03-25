import 'package:flutter/material.dart';
import '../../../electrical/presentation/views/electrical_calculator_page.dart';
import '../../../emission/presentation/views/emission_calculator_page.dart';
import '../../../fuel/presentation/views/fuel_calculator_page.dart';
import '../../../fuel_oil/presentation/views/fuel_oil_calculator_page.dart';
import '../../../margin/presentation/views/margin_calculator_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thermal Calculators'),
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Fuel'),
              Tab(text: 'Fuel Oil'),
              Tab(text: 'Emission'),
              Tab(text: 'Margin'),
              Tab(text: 'Electrical'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FuelCalculatorPage(),
            FuelOilCalculatorPage(),
            EmissionCalculatorPage(),
            MarginCalculatorPage(),
            ElectricalCalculatorPage(),
          ],
        ),
      ),
    );
  }
}