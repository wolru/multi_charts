import 'dart:math' show cos, min, pi, sin;

import 'package:flutter/material.dart';
import 'package:multi_charts/src/common/common_paint_utils.dart';
import 'package:multi_charts/src/radar_chart/utils/radar_chart_draw_utils.dart';

/// Custom Painter class for drawing the chart. Depends on various parameters like
/// [RadarChart.values], [RadarChart.labels], [RadarChart.maxValue], [RadarChart.fillColor],
/// [RadarChart.strokeColor], [RadarChart.legendTextColor], [RadarChart.textScaleFactor], [RadarChart.labelWidth],
/// [RadarChart.maxLinesForLabels], [RadarChart.chartRadiusFactor].
///
/// It also has [dataAnimationPercent] and [outlineAnimationPercent] which defines the
/// animation of the chart data and outlines.
class RadarChartPainter extends CustomPainter {
  final List<double> values;
  final List<Text>? labels;
  final double maxValue;
  final Color fillColor;
  final Color strokeColor;
  final double textScaleFactor;
  final double? labelWidth;
  final int? maxLinesForLabels;
  final double dataAnimationPercent;
  final double chartRadiusFactor;

  RadarChartPainter(
    this.values,
    this.labels,
    this.maxValue,
    this.fillColor,
    this.strokeColor,
    this.textScaleFactor,
    this.labelWidth,
    this.maxLinesForLabels,
    this.dataAnimationPercent,
    this.chartRadiusFactor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final maxValueSize = min(center.dx, center.dy) * chartRadiusFactor;
    final angle = (2 * pi) / values.length;
    if (values.length.isOdd) {
      final adjustPositionY = maxValueSize - sin(pi / 2 - angle / 2) * maxValueSize;
      center = Offset(size.width / 2.0, size.height / 2.0 + adjustPositionY / 2);
    }
    var valuePoints = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      var radius = (values[i] / maxValue) * maxValueSize;
      var x = dataAnimationPercent * radius * cos(angle * i - pi / 2);
      var y = dataAnimationPercent * radius * sin(angle * i - pi / 2);

      valuePoints.add(Offset(x, y) + center);
    }

    var outerPoints = RadarChartDrawUtils.drawChartOutline(
      canvas,
      center,
      angle,
      strokeColor,
      maxValue,
      values.length,
      (min(center.dx, center.dy) * chartRadiusFactor),
    );
    RadarChartDrawUtils.drawGraphData(
      canvas,
      valuePoints,
      fillColor,
      strokeColor,
    );
    RadarChartDrawUtils.drawLabels(
      canvas,
      center,
      labels ?? List.empty(),
      outerPoints,
      CommonPaintUtils.getTextSize(
        size,
        textScaleFactor,
      ),
      labelWidth ?? CommonPaintUtils.getDefaultLabelWidth(size, center, angle),
      maxLinesForLabels ?? CommonPaintUtils.getDefaultMaxLinesForLabels(size),
    );
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    return oldDelegate.dataAnimationPercent != dataAnimationPercent;
  }
}