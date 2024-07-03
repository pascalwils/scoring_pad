import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pref/pref.dart';

import '../../settings/pref_keys.dart';
import '../app_color_schemes.dart';
import 'score_widget_state.dart';

enum GraphCurveShape {
  curved,
  step,
  straight;

  static GraphCurveShape fromPreferences(BuildContext context) {
    final name = PrefService.of(context).get(graphCurveShapePrefKey);
    return GraphCurveShape.values.firstWhere(
      (e) => e.name == name,
      orElse: () => GraphCurveShape.curved,
    );
  }
}

class ScoreGraphWidget extends StatelessWidget {
  static const gridDashes = [8, 4];

  final List<PlayerScore> scores;
  final AppLocalizations translation;
  final GraphColorScheme graphScheme;
  final List<PlayerColorScheme> playerSchemes;

  const ScoreGraphWidget({
    super.key,
    required this.scores,
    required this.translation,
    required this.graphScheme,
    required this.playerSchemes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 24.0, top: 24.0, bottom: 16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            getDrawingVerticalLine: _getGridVerticalLine,
            getDrawingHorizontalLine: _getGridHorizontalLine,
          ),
          titlesData: _getTitlesData(),
          borderData: _getBorderData(),
          lineBarsData: _getLineBarsData(GraphCurveShape.fromPreferences(context)),
          lineTouchData: lineTouchData,
          minX: 0,
          maxX: scores[0].scores.length.toDouble() - 1.0,
          maxY: _getMaxScore().toDouble(),
          minY: _getMinScore().toDouble(),
        ),
      ),
    );
  }

  FlLine _getGridVerticalLine(double value) {
    return FlLine(color: graphScheme.gridColor, dashArray: gridDashes);
  }

  FlLine _getGridHorizontalLine(double value) {
    var width = 1.0;
    List<int>? dashes = gridDashes;
    if (value == 0.0) {
      width = 2.0;
      dashes = null;
    }
    return FlLine(color: graphScheme.gridColor, strokeWidth: width, dashArray: dashes);
  }

  FlTitlesData _getTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          getTitlesWidget: _leftTitleWidgets,
          showTitles: true,
          reservedSize: 40,
        ),
      ),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text("${value.toInt()}", style: style),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    int index = value.toInt();
    final text = index > 0 ? translation.graphRoundTitle(index) : "";
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 20,
        interval: 1,
        getTitlesWidget: _bottomTitleWidgets,
      );

  FlBorderData _getBorderData() => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: graphScheme.borderColor, width: 2),
          left: BorderSide(color: graphScheme.borderColor, width: 2),
        ),
      );

  List<LineChartBarData> _getLineBarsData(GraphCurveShape shape) {
    List<LineChartBarData> result = List.empty(growable: true);
    for (var it in scores) {
      result.add(LineChartBarData(
        isCurved: shape == GraphCurveShape.curved,
        isStepLineChart: shape == GraphCurveShape.step,
        color: playerSchemes[it.player.colorIndex].base,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: _getSpots(it.scores),
      ));
    }
    return result;
  }

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          getTooltipColor: (it) => graphScheme.tooltipBackground,
          getTooltipItems: _getTooltipItems,
          tooltipMargin: 4.0,
        ),
      );

  List<LineTooltipItem?> _getTooltipItems(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map((e) => _getTooltipItem(e)).toList();
  }

  LineTooltipItem? _getTooltipItem(LineBarSpot touchedSpot) {
    final val = touchedSpot.y.toInt();
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: touchedSpot.bar.color ?? Colors.white,
    );
    return LineTooltipItem("$val", style);
  }

  List<FlSpot> _getSpots(List<int> scores) {
    return scores.asMap().entries.map((it) => FlSpot(it.key.toDouble(), it.value.toDouble())).toList();
  }

  int _getMaxScore() {
    return scores.map((it) => it.scores.reduce(max)).reduce(max);
  }

  int _getMinScore() {
    return scores.map((it) => it.scores.reduce(min)).reduce(min);
  }
}
