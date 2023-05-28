import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartsData {
  static double width = 7;
  static Color leftBarColor = const Color(0xff53fdd7);

  static List<List<int>> coordinatesBarX = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    [0, 1, 2, 3, 4, 5, 6],
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  ];

  static List<List<int>> coordinatesBarY = [
    [10, 5, 18, 4, 15, 8, 6, 7, 13, 8, 9, 11],
    [8, 12, 5, 9, 4, 10, 15],
    [10, 5, 18, 7, 15, 8, 11, 7, 3, 6, 12, 5],
    [10, 5, 11, 7, 5, 12, 15, 7, 3, 13]
  ];

  static List<List<int>> coordinatesLineY = [
    [9, 4, 17, 4, 15, 8, 6, 12, 4, 8, 9, 6],
    [8, 12, 5, 9, 4, 10, 15],
    [10, 5, 18, 7, 15, 8, 11, 7, 3, 6, 12, 5],
    [10, 5, 11, 7, 5, 12, 15, 7, 3, 13]
  ];

  static List<int> pieChartData = [45, 25, 20, 10];

  static List<Color> pieChartColors = [
    const Color(0xff0293ee),
    const Color(0xfff8b250),
    const Color(0xff845bef),
    const Color(0xff13d38e),
    const Color(0xff03bafc),
    const Color(0xfffc3003),
    const Color(0xfff403fc),
  ];

  static List<BarChartGroupData> barChartData(currentIndex) {
    int size = 0;
    if (currentIndex == 0) {
      size = 12;
    } else if (currentIndex == 1) {
      size = 7;
    } else if (currentIndex == 2) {
      size = 12;
    } else if (currentIndex == 3) {
      size = 10;
    }
    return List.generate(size, (index) {
      return BarChartGroupData(
        barsSpace: 4,
        x: coordinatesBarX[currentIndex][index],
        barRods: [
          BarChartRodData(
            borderRadius: const BorderRadius.all(Radius.zero),
            toY: coordinatesBarY[currentIndex][index].toDouble(),
            color: leftBarColor,
            width: width,
          ),
        ],
      );
    });
  }

  static List<FlSpot> lineChartData(currentIndex) {
    int size = 0;
    if (currentIndex == 0) {
      size = 12;
    } else if (currentIndex == 1) {
      size = 7;
    } else if (currentIndex == 2) {
      size = 12;
    } else if (currentIndex == 3) {
      size = 10;
    }
    return List.generate(size, (index) {
      return FlSpot(
        coordinatesBarX[currentIndex][index].toDouble(),
        coordinatesLineY[currentIndex][index].toDouble(),
      );
    });
  }
}
