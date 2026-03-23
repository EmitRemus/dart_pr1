import 'dart:math' as math;

import '../models/emission_input.dart';
import '../models/emission_result.dart';

class EmissionCalculatorService {
  EmissionResult calculate(EmissionInput input) {
    switch (input.fuelType) {
      case 'coal':
        return calculateCoal(input.mass);
      case 'mazut':
        return calculateMazut(input.mass);
      case 'gas':
        return calculateGas(input.mass);
      case 'user':
      default:
        return calculateUserInput(
          input.lowBurnTemp,
          input.ashPart,
          input.ashMass,
          input.burnableEjection,
          input.cleaningEfficiency,
          input.solidEmissionWithSulfur,
          input.mass,
        );
    }
  }

  EmissionResult calculateCoal(double mass) {
    const lowBurnTemp = 20.47;
    const ashPart = 0.8;
    const ashMass = 25.2;
    const burnableEjection = 1.5;
    const cleaningEfficiency = 0.985;
    const solidEmissionWithSulfur = 0.0;

    final emission = calculateEmission(
      lowBurnTemp,
      ashPart,
      ashMass,
      burnableEjection,
      cleaningEfficiency,
      solidEmissionWithSulfur,
    );

    final ejection = calculateEjection(emission, lowBurnTemp, mass);

    return EmissionResult(
      emission: emission,
      ejection: ejection,
    );
  }

  EmissionResult calculateMazut(double mass) {
    const lowBurnTemp = 39.48;
    const ashPart = 1.0;
    const ashMass = 0.15;
    const burnableEjection = 0.0;
    const cleaningEfficiency = 0.985;
    const solidEmissionWithSulfur = 0.0;

    final emission = calculateEmission(
      lowBurnTemp,
      ashPart,
      ashMass,
      burnableEjection,
      cleaningEfficiency,
      solidEmissionWithSulfur,
    );

    final ejection = calculateEjection(emission, lowBurnTemp, mass);

    return EmissionResult(
      emission: emission,
      ejection: ejection,
    );
  }

  EmissionResult calculateGas(double mass) {
    const lowBurnTemp = 33.08;
    const ashPart = 0.0;
    const ashMass = 0.0;
    const burnableEjection = 0.0;
    const cleaningEfficiency = 0.985;
    const solidEmissionWithSulfur = 0.0;

    final emission = calculateEmission(
      lowBurnTemp,
      ashPart,
      ashMass,
      burnableEjection,
      cleaningEfficiency,
      solidEmissionWithSulfur,
    );

    final ejection = calculateEjection(emission, lowBurnTemp, mass);

    return EmissionResult(
      emission: emission,
      ejection: ejection,
    );
  }

  EmissionResult calculateUserInput(
      double lowBurnTemp,
      double ashPart,
      double ashMass,
      double burnableEjection,
      double cleaningEfficiency,
      double solidEmissionWithSulfur,
      double mass,
      ) {
    final emission = calculateEmission(
      lowBurnTemp,
      ashPart,
      ashMass,
      burnableEjection,
      cleaningEfficiency,
      solidEmissionWithSulfur,
    );

    final ejection = calculateEjection(emission, lowBurnTemp, mass);

    return EmissionResult(
      emission: emission,
      ejection: ejection,
    );
  }

  double calculateEmission(
      double lowBurnTemp,
      double ashPart,
      double ashMass,
      double burnableEjection,
      double cleaningEfficiency,
      double solidEmissionWithSulfur,
      ) {
    return (math.pow(10, 6) / lowBurnTemp) *
        ashPart *
        (ashMass / (100 - burnableEjection)) *
        (1 - cleaningEfficiency) +
        solidEmissionWithSulfur;
  }

  double calculateEjection(
      double emission,
      double lowBurnTemp,
      double mass,
      ) {
    return math.pow(10, -6) * emission * lowBurnTemp * mass;
  }
}