import 'package:fl_chart/fl_chart.dart';
import 'package:floatingbubble/ui/views/charts/chart_options.dart';
import 'package:floatingbubble/ui/views/charts/charts_data.dart';
import 'package:flutter/material.dart';

class LineChartUI extends StatefulWidget {
  final int currentIndex;
  final List<SelectOption> selectedOptions;
  final Function toggleFilterDisplay;
  final bool isFilterEnabled;

  const LineChartUI({
    Key key,
    this.currentIndex,
    this.selectedOptions = const <SelectOption>[],
    this.toggleFilterDisplay,
    this.isFilterEnabled,
  }) : super(key: key);

  @override
  _LineChartUIState createState() => _LineChartUIState();
}

class _LineChartUIState extends State<LineChartUI> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> rawSpots = [];
  List<FlSpot> showingSpots = [];

  @override
  void initState() {
    super.initState();

    rawSpots = ChartsData.lineChartData(widget.currentIndex);

    if (widget.selectedOptions.isNotEmpty) {
      for (var selectedOption in widget.selectedOptions) {
        showingSpots.add(rawSpots[selectedOption.id]);
      }
      showingSpots.sort(
        (FlSpot a, FlSpot b) {
          return a.x.compareTo(b.x);
        },
      );
    } else {
      showingSpots = rawSpots;
    }
  }

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  String assignLabels(currentIndex, groupX) {
    if (currentIndex == 0) {
      switch (groupX.toInt()) {
        case 0:
          return '2010';
          break;
        case 1:
          return '2011';
          break;
        case 2:
          return '2012';
          break;
        case 3:
          return '2013';
          break;
        case 4:
          return '2014';
          break;
        case 5:
          return '2015';
          break;
        case 6:
          return '2016';
          break;
        case 7:
          return '2017';
          break;
        case 8:
          return '2018';
          break;
        case 9:
          return '2019';
          break;
        case 10:
          return '2020';
          break;
        case 11:
          return '2021';
          break;
        default:
          throw Error();
      }
    } else if (currentIndex == 1) {
      switch (groupX.toInt()) {
        case 0:
          return 'Week 1';
          break;
        case 1:
          return 'Week 2';
          break;
        case 2:
          return 'Week 3';
          break;
        case 3:
          return 'Week 4';
          break;
        case 4:
          return 'Week 5';
          break;
        case 5:
          return 'Week 6';
          break;
        case 6:
          return 'Week 7';
          break;
        default:
          throw Error();
      }
    } else if (currentIndex == 2) {
      switch (groupX.toInt()) {
        case 0:
          return 'Jan';
          break;
        case 1:
          return 'Feb';
          break;
        case 2:
          return 'Mar';
          break;
        case 3:
          return 'Apr';
          break;
        case 4:
          return 'May';
          break;
        case 5:
          return 'Jun';
          break;
        case 6:
          return 'Jul';
          break;
        case 7:
          return 'Aug';
          break;
        case 8:
          return 'Sep';
          break;
        case 9:
          return 'Oct';
          break;
        case 10:
          return 'Nov';
          break;
        case 11:
          return 'Dec';
          break;
        default:
          throw Error();
      }
    } else if (currentIndex == 3) {
      switch (groupX.toInt()) {
        case 0:
          return 'Qtr 1';
          break;
        case 1:
          return 'Qtr 2';
          break;
        case 2:
          return 'Qtr 3';
          break;
        case 3:
          return 'Qtr 4';
          break;
        case 4:
          return 'Qtr* 1';
          break;
        case 5:
          return 'Qtr* 2';
          break;
        case 6:
          return 'Qtr* 3';
          break;
        case 7:
          return 'Qtr* 4';
          break;
        case 8:
          return 'Qtr^ 1';
          break;
        case 9:
          return 'Qtr^ 2';
          break;
        default:
          throw Error();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    List<List<String>> newTiles = [
      [
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018',
        '2019',
        '2020',
        '2021'
      ],
      ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6', 'Week 7'],
      ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      [
        'Qtr 1',
        'Qtr 2',
        'Qtr 3',
        'Qtr 4',
        'Qtr* 1',
        'Qtr* 2',
        'Qtr* 3',
        'Qtr* 4',
        'Qtr^ 1',
        'Qtr^ 2'
      ]
    ];

    // for (var currentOption in widget.selectedOptions) {
    //   switch (currentOption.name) {
    //     case "Monday":
    //       newTiles.add("Mn");
    //       break;
    //     case "Tuesday":
    //       newTiles.add("Te");
    //       break;
    //     case "Wednesday":
    //       newTiles.add("Wd");
    //       break;
    //     case "Thursday":
    //       newTiles.add("Tu");
    //       break;
    //     case "Friday":
    //       newTiles.add("Fr");
    //       break;
    //     case "Saturday":
    //       newTiles.add("St");
    //       break;
    //     case "Sunday":
    //       newTiles.add("Su");
    //       break;
    //     default:
    //   }
    // }

    Widget text = Text(
      newTiles[widget.currentIndex][value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return RotationTransition(
      turns: const AlwaysStoppedAnimation(-55 / 360),
      child: SideTitleWidget(
        axisSide: meta.axisSide,
        space: 8.0,
        child: text,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      lineTouchData: LineTouchData(
        touchCallback: (FlTouchEvent event, LineTouchResponse touchResponse) {
          debugPrint('Event :- $event');
          if (event is FlLongPressEnd && widget.isFilterEnabled) {
            widget.toggleFilterDisplay();
          }
        },
        // touchCallback: (p0, p1) {
        //   int now = DateTime.now().millisecondsSinceEpoch;
        //   if (now - lastTap < 1000) {
        //     lastTap = DateTime.now().millisecondsSinceEpoch;
        //     debugPrint("Consecutive tap");
        //     consecutiveTaps++;
        //     debugPrint("taps = " + consecutiveTaps.toString());
        //     if (consecutiveTaps >= 6) {
        //       widget.toggleFilterDisplay();
        //     }
        //   } else {
        //     consecutiveTaps = 0;
        //   }
        //   lastTap = now;
        // },
        // getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
        //   return spotIndexes.map((spotIndex) {
        //     return TouchedSpotIndicatorData(
        //       FlLine(color: Colors.blue, strokeWidth: 4),
        //       FlDotData(
        //         getDotPainter: (spot, percent, barData, index) {
        //           if (index % 2 == 0) {
        //             return FlDotCirclePainter(
        //                 radius: 8,
        //                 color: Colors.white,
        //                 strokeWidth: 5,
        //                 strokeColor: Colors.deepOrange);
        //           } else {
        //             return FlDotSquarePainter(
        //               size: 16,
        //               color: Colors.white,
        //               strokeWidth: 5,
        //               strokeColor: Colors.deepOrange,
        //             );
        //           }
        //         },
        //       ),
        //     );
        //   }).toList();
        // },
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.black,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            maxContentWidth: 250,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                String weekDay = assignLabels(widget.currentIndex, flSpot.x.toInt());

                return LineTooltipItem(
                  '$weekDay \n',
                  const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                  children: [
                    TextSpan(
                      text: flSpot.y.toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList();
            }),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: ChartsData.coordinatesBarY[widget.currentIndex].length.toDouble() - 1.0,
      minY: 0,
      maxY: 20,
      lineBarsData: [
        LineChartBarData(
          spots: showingSpots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
