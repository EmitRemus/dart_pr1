import 'package:flutter/material.dart';
import '../../../fuel/presentation/views/fuel_calculator_page.dart';
import '../../../fuel_oil/presentation/views/fuel_oil_calculator_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thermal Calculators'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Fuel'),
              Tab(text: 'Fuel Oil'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FuelCalculatorPage(),
            FuelOilCalculatorPage(),
          ],
        ),
      ),
    );
  }
}