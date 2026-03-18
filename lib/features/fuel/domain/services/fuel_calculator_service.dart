import '../models/fuel_input.dart';
import '../models/fuel_result.dart';

class FuelCalculatorService {
  FuelResult calculate(FuelInput input) {
    final dryMassCoef = calcDryMassCoef(input.wetness);
    final fireMassCoef = calcFireMassCoef(input.wetness, input.ash);

    final dryValues = calcDryMass(
      input.carbon,
      input.hydrogen,
      input.sulfur,
      input.nitrogen,
      input.oxygen,
      input.ash,
      dryMassCoef,
    );

    final fireValues = calcFireMass(
      input.carbon,
      input.hydrogen,
      input.sulfur,
      input.nitrogen,
      input.oxygen,
      fireMassCoef,
    );

    final lowBurnTempK = calcLowBurnTemp(
      input.carbon,
      input.hydrogen,
      input.oxygen,
      input.sulfur,
      input.wetness,
    ) /
        1000.0;

    final lowBurnDryTemp = calcLowBurnDryTemp(
      lowBurnTempK,
      input.wetness,
      dryMassCoef,
    );

    final lowBurnFireTemp = calcLowBurnFireTemp(
      lowBurnTempK,
      input.wetness,
      fireMassCoef,
    );

    return FuelResult(
      wetDryCoef: dryMassCoef,
      wetFireCoef: fireMassCoef,
      carbonDry: dryValues['carbon_dry']!,
      hydrogenDry: dryValues['hydrogen_dry']!,
      sulfurDry: dryValues['sulfur_dry']!,
      nitrogenDry: dryValues['nitrogen_dry']!,
      oxygenDry: dryValues['oxygen_dry']!,
      ashDry: dryValues['ash_dry']!,
      carbonFire: fireValues['carbon_fire']!,
      hydrogenFire: fireValues['hydrogen_fire']!,
      sulfurFire: fireValues['sulfur_fire']!,
      nitrogenFire: fireValues['nitrogen_fire']!,
      oxygenFire: fireValues['oxygen_fire']!,
      lowBurnTemp: lowBurnTempK,
      lowBurnDryTemp: lowBurnDryTemp,
      lowBurnFireTemp: lowBurnFireTemp,
    );
  }

  double calcDryMassCoef(double wetness) {
    return 100.0 / (100.0 - wetness);
  }

  double calcFireMassCoef(double wetness, double ash) {
    return 100.0 / (100.0 - wetness - ash);
  }

  Map<String, double> calcDryMass(
      double carbon,
      double hydrogen,
      double sulfur,
      double nitrogen,
      double oxygen,
      double ash,
      double dryMassCoef,
      ) {
    return {
      'carbon_dry': carbon * dryMassCoef,
      'hydrogen_dry': hydrogen * dryMassCoef,
      'sulfur_dry': sulfur * dryMassCoef,
      'nitrogen_dry': nitrogen * dryMassCoef,
      'oxygen_dry': oxygen * dryMassCoef,
      'ash_dry': ash * dryMassCoef,
    };
  }

  Map<String, double> calcFireMass(
      double carbon,
      double hydrogen,
      double sulfur,
      double nitrogen,
      double oxygen,
      double fireMassCoef,
      ) {
    return {
      'carbon_fire': carbon * fireMassCoef,
      'hydrogen_fire': hydrogen * fireMassCoef,
      'sulfur_fire': sulfur * fireMassCoef,
      'nitrogen_fire': nitrogen * fireMassCoef,
      'oxygen_fire': oxygen * fireMassCoef,
    };
  }

  double calcLowBurnTemp(
      double carbon,
      double hydrogen,
      double oxygen,
      double sulfur,
      double wetness,
      ) {
    return 339.0 * carbon +
        1030.0 * hydrogen -
        108.8 * (oxygen - sulfur) -
        25.0 * wetness;
  }

  double calcLowBurnDryTemp(
      double lowBurnTemp,
      double wetness,
      double dryMassCoef,
      ) {
    return (lowBurnTemp + 0.025 * wetness) * dryMassCoef;
  }

  double calcLowBurnFireTemp(
      double lowBurnTemp,
      double wetness,
      double fireMassCoef,
      ) {
    return (lowBurnTemp + 0.025 * wetness) * fireMassCoef;
  }
}