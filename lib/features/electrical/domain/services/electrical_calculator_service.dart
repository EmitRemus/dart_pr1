import 'dart:math' as math;

import '../models/electrical_input.dart';
import '../models/electrical_result.dart';

class ElectricalCalculatorService {
  ElectricalResult calculate(ElectricalInput input) {
    final cable = chooseCable(
      input.sM,
      input.uNom,
      input.iK,
      input.tF,
    );

    final kz = calculateKz(
      input.sK,
      input.uCn,
      input.uK,
      input.sNomT,
    );

    final stationKz = calculateKZonStation(
      input.l,
      input.uKMax,
      input.uVn,
      input.uNn,
      input.sNomT,
      input.rSn,
      input.xSn,
      input.rSMin,
      input.xSMin,
    );

    return ElectricalResult(
      optimalCableSection: cable[0],
      economicCableSection: cable[1],
      threePhaseShortCircuitCurrent: kz,
      stationKz: stationKz,
    );
  }

  List<double> chooseCable(
      double sM,
      double uNom,
      double iK,
      double tF,
      ) {
    const jEk = 1.4;
    const cT = 92.0;

    var iM = (sM / 2) / (math.sqrt(3) * uNom);
    iM = (iM * 100).round() / 100;

    var iMPa = 2 * iM;
    iMPa = (iMPa * 100).round() / 100;

    var sEk = iM / jEk;
    sEk = (sEk * 100).round() / 100;

    var s = (iK * math.sqrt(tF)) / cT;
    s = (s * 100).round() / 100;

    return [s, sEk];
  }

  double calculateKz(
      double sK,
      double uCn,
      double uK,
      double sNomT,
      ) {
    var xC = math.pow(uCn, 2) / sK;
    xC = (xC * 100).round() / 100;

    var xT = (uK / 100) * (math.pow(uCn, 2) / sNomT);
    xT = (xT * 100).round() / 100;

    var xSum = xC + xT;
    xSum = (xSum * 100).round() / 100;

    var iP0 = uCn / (math.sqrt(3) * xSum);
    iP0 = (iP0 * 100).round() / 100;

    return iP0.toDouble();
  }

  List<List<double>> calculateKZonStation(
      double l,
      double uKMax,
      double uVn,
      double uNn,
      double sNomT,
      double rSn,
      double xSn,
      double rSMin,
      double xSMin,
      ) {
    const r0 = 0.64;
    const x0 = 0.363;

    double roundTo(double value, int precision) {
      final pow = math.pow(10, precision).toDouble();
      return (value * pow).round() / pow;
    }

    final xT = roundTo((uKMax * math.pow(uVn, 2)) / (100 * sNomT), 2);

    final rH = rSn;
    final xH = roundTo(xSn + xT, 2);
    final zH = roundTo(math.sqrt(math.pow(rH, 2) + math.pow(xH, 2)), 2);

    final rHMin = rSMin;
    final xHMin = roundTo(xSMin + xT, 2);
    final zHMin = roundTo(math.sqrt(math.pow(rHMin, 2) + math.pow(xHMin, 2)), 2);

    final iH3 = roundTo((uVn * math.pow(10, 3)) / (math.sqrt(3) * zH), 2);
    final iH2 = roundTo(iH3 * (math.sqrt(3) / 2), 2);

    final iH3Min = roundTo((uVn * math.pow(10, 3)) / (math.sqrt(3) * zHMin), 2);
    final iH2Min = roundTo(iH3Min * (math.sqrt(3) / 2), 2);

    final kPr = roundTo(math.pow(uNn, 2) / math.pow(uVn, 2), 3);

    final rHN = roundTo(rH * kPr, 2);
    final xHN = roundTo(xH * kPr, 2);
    final zHN = roundTo(math.sqrt(math.pow(rHN, 2) + math.pow(xHN, 2)), 2);

    final rHNMin = roundTo(rHMin * kPr, 2);
    final xHNMin = roundTo(xHMin * kPr, 2);
    final zHNMin = roundTo(math.sqrt(math.pow(rHNMin, 2) + math.pow(xHNMin, 2)), 2);

    final iHN3 = roundTo((uNn * math.pow(10, 3)) / (math.sqrt(3) * zHN), 2);
    final iHN2 = roundTo(iHN3 * (math.sqrt(3) / 2), 2);

    final iHN3Min = roundTo((uNn * math.pow(10, 3)) / (math.sqrt(3) * zHNMin), 2);
    final iHN2Min = roundTo(iHN3Min * (math.sqrt(3) / 2), 2);

    final rL = roundTo(l * r0, 2);
    final xL = roundTo(l * x0, 2);

    final rSumN = roundTo(rL + rHN, 2);
    final xSumN = roundTo(xL + xHN, 2);
    final zSumN = roundTo(math.sqrt(math.pow(rSumN, 2) + math.pow(xSumN, 2)), 2);

    final rSumNMin = roundTo(rL + rHNMin, 2);
    final xSumNMin = roundTo(xL + xHNMin, 2);
    final zSumNMin = roundTo(math.sqrt(math.pow(rSumNMin, 2) + math.pow(xSumNMin, 2)), 2);

    final iLN3 = roundTo((uNn * math.pow(10, 3)) / (math.sqrt(3) * zSumN), 2);
    final iLN2 = roundTo(iLN3 * (math.sqrt(3) / 2), 2);

    final iLN3Min = roundTo((uNn * math.pow(10, 3)) / (math.sqrt(3) * zSumNMin), 2);
    final iLN2Min = roundTo(iLN3Min * (math.sqrt(3) / 2), 2);

    return [
      [iH3, iH2, iH3Min, iH2Min],
      [iHN3, iHN2, iHN3Min, iHN2Min],
      [iLN3, iLN2, iLN3Min, iLN2Min],
    ];
  }
}