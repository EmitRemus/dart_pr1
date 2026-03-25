class ElectricalResult {
  final double optimalCableSection;
  final double economicCableSection;
  final double threePhaseShortCircuitCurrent;
  final List<List<double>> stationKz;

  const ElectricalResult({
    required this.optimalCableSection,
    required this.economicCableSection,
    required this.threePhaseShortCircuitCurrent,
    required this.stationKz,
  });
}