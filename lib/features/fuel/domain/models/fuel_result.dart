class FuelResult {
  final double wetDryCoef;
  final double wetFireCoef;

  final double carbonDry;
  final double hydrogenDry;
  final double sulfurDry;
  final double nitrogenDry;
  final double oxygenDry;
  final double ashDry;

  final double carbonFire;
  final double hydrogenFire;
  final double sulfurFire;
  final double nitrogenFire;
  final double oxygenFire;

  final double lowBurnTemp;
  final double lowBurnDryTemp;
  final double lowBurnFireTemp;

  const FuelResult({
    required this.wetDryCoef,
    required this.wetFireCoef,
    required this.carbonDry,
    required this.hydrogenDry,
    required this.sulfurDry,
    required this.nitrogenDry,
    required this.oxygenDry,
    required this.ashDry,
    required this.carbonFire,
    required this.hydrogenFire,
    required this.sulfurFire,
    required this.nitrogenFire,
    required this.oxygenFire,
    required this.lowBurnTemp,
    required this.lowBurnDryTemp,
    required this.lowBurnFireTemp,
  });
}