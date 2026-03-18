import '../models/fuel_oil_input.dart';
import '../models/fuel_oil_result.dart';

class FuelOilCalculatorService {
  FuelOilResult calculate(FuelOilInput input) {
    final ashWork = input.ash * ((100 - input.wetness) / 100);
    final vanadiumWork = input.vanadium * ((100 - input.wetness) / 100);

    final fireToWorkMassCoef = calcFireToWorkMassCoef(input.wetness, ashWork);

    final workMass = calcWorkMass(
      input.carbon,
      input.hydrogen,
      input.sulfur,
      input.oxygen,
      fireToWorkMassCoef,
    );

    final burnWorkTemp = calcBurnWorkTemp(input.wetness, ashWork);

    return FuelOilResult(
      ashWork: ashWork,
      vanadiumWork: vanadiumWork,
      carbonWork: workMass['carbon_work']!,
      hydrogenWork: workMass['hydrogen_work']!,
      sulfurWork: workMass['sulfur_work']!,
      oxygenWork: workMass['oxygen_work']!,
      burnWorkTemp: burnWorkTemp,
    );
  }

  Map<String, double> calcWorkMass(
      double carbonFire,
      double hydrogenFire,
      double sulfurFire,
      double oxygenFire,
      double fireToWorkMassCoef,
      ) {
    return {
      'carbon_work': carbonFire * fireToWorkMassCoef,
      'hydrogen_work': hydrogenFire * fireToWorkMassCoef,
      'sulfur_work': sulfurFire * fireToWorkMassCoef,
      'oxygen_work': oxygenFire * fireToWorkMassCoef,
    };
  }

  double calcFireToWorkMassCoef(double wetness, double ash) {
    return (100 - wetness - ash) / 100;
  }

  double calcBurnWorkTemp(double wetness, double ashWork) {
    return ((100 - wetness - ashWork) / 100) - 0.025 * wetness;
  }
}