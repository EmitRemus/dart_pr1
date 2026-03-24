import 'dart:math' as math;

import '../models/margin_input.dart';
import '../models/margin_result.dart';

class MarginCalculatorService {
  MarginResult calculate(MarginInput input) {
    const delta = 0.05;
    final pMin = input.ps - input.ps * delta;
    final pMax = input.ps + input.ps * delta;

    final deltaW1 =
        (integrate(pMin, pMax, input.sig1, input.ps) * 100).round() / 100;
    final w1 = (input.ps * 24 * deltaW1).round();
    final p1 = (w1 * input.b).round();
    final w2 = (input.ps * 24 * (1 - deltaW1)).round();
    final h1 = (w2 * input.b).round();

    final deltaW2 =
        (integrate(pMin, pMax, input.sig2, input.ps) * 100).round() / 100;
    final w3 = (input.ps * 24 * deltaW2).round();
    final p2 = (w3 * input.b).round();
    final w4 = (input.ps * 24 * (1 - deltaW2)).round();
    final h2 = (w4 * input.b).round();

    return MarginResult(
      deltaW1: deltaW1 * 100,
      p1: p1,
      h1: h1,
      net1: p1 - h1,
      deltaW2: deltaW2 * 100,
      p2: p2,
      h2: h2,
      net2: p2 - h2,
    );
  }

  double integrate(double pStart, double pEnd, double sig, double ps) {
    double toIntegrate(double sig, double ps, double p) {
      final dif = p - ps;
      final power = math.pow(dif, 2) / (2 * sig * sig);
      final numerator = math.exp(power.toDouble());
      final denominator = sig * math.sqrt(6.28);
      return numerator / denominator;
    }

    var sum =
        0.5 * toIntegrate(sig, ps, pStart) + 0.5 * toIntegrate(sig, ps, pEnd);
    const iterations = 1000;
    final delta = (pEnd - pStart) / iterations;

    for (var i = 1; i < iterations; i++) {
      sum += toIntegrate(sig, ps, pStart + i * delta);
    }

    sum *= delta;
    return sum;
  }
}