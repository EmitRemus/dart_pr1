class ElectricalInput {
  final double sM;
  final double uNom;
  final double iK;
  final double tF;

  final double sK;
  final double uCn;
  final double uK;
  final double sNomT;

  final double l;
  final double uKMax;
  final double uVn;
  final double uNn;
  final double rSn;
  final double xSn;
  final double rSMin;
  final double xSMin;

  const ElectricalInput({
    required this.sM,
    required this.uNom,
    required this.iK,
    required this.tF,
    required this.sK,
    required this.uCn,
    required this.uK,
    required this.sNomT,
    required this.l,
    required this.uKMax,
    required this.uVn,
    required this.uNn,
    required this.rSn,
    required this.xSn,
    required this.rSMin,
    required this.xSMin,
  });
}