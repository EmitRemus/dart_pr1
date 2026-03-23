class EmissionInput {
  final String fuelType;
  final double lowBurnTemp;
  final double ashPart;
  final double ashMass;
  final double burnableEjection;
  final double cleaningEfficiency;
  final double solidEmissionWithSulfur;
  final double mass;

  const EmissionInput({
    required this.fuelType,
    required this.lowBurnTemp,
    required this.ashPart,
    required this.ashMass,
    required this.burnableEjection,
    required this.cleaningEfficiency,
    required this.solidEmissionWithSulfur,
    required this.mass,
  });
}