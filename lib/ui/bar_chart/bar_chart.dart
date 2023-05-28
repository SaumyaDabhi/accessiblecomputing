import 'package:fl_chart/fl_chart.dart';
import 'package:floatingbubble/ui/views/charts/chart_options.dart';
import 'package:floatingbubble/ui/views/charts/charts_data.dart';
import 'package:flutter/material.dart';

class BarChartUI extends StatefulWidget {
  final int currentIndex;
  final List<SelectOption> selectedOptions;
  final Function toggleFilterDisplay;
  final bool isFilterEnabled;

  const BarChartUI({
    Key key,
    this.currentIndex,
    this.selectedOptions = const <SelectOption>[],
    this.toggleFilterDisplay,
    this.isFilterEnabled,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartUIState();
}

class BarChartUIState extends State<BarChartUI> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    rawBarGroups = ChartsData.barChartData(widget.currentIndex);

    if (widget.selectedOptions.isNotEmpty) {
      // for (var i = 0; i < rawBarGroups.length; i++) {
      //   var itemPresent =
      //       widget.selectedOptions.firstWhere((element) => element.id == i, orElse: () => null);
      //   if (itemPresent != null) {
      //     showingBarGroups.add(rawBarGroups[i]);
      //   } else {
      //     showingBarGroups.add(BarChartGroupData(
      //       barsSpace: 4,
      //       x: i,
      //       barRods: [
      //         BarChartRodData(
      //           borderRadius: const BorderRadius.all(Radius.zero),
      //           toY: 0,
      //           color: leftBarColor,
      //           width: width,
      //         ),
      //       ],
      //     ));
      //   }
      // }
      for (var selectedOption in widget.selectedOptions) {
        showingBarGroups.add(rawBarGroups[selectedOption.id]);
      }
      showingBarGroups.sort((a, b) => a.x.compareTo(b.x));
    } else {
      showingBarGroups = rawBarGroups;
    }
  }

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;
  int now = DateTime.now().millisecondsSinceEpoch;

  String assignLabels(currentIndex, groupX) {
    if (currentIndex == 0) {
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
    } else if (currentIndex == 1) {
      switch (groupX.toInt()) {
        case 0:
          return 'Mon';
          break;
        case 1:
          return 'Tue';
          break;
        case 2:
          return 'Wed';
          break;
        case 3:
          return 'Thu';
          break;
        case 4:
          return 'Fri';
          break;
        case 5:
          return 'Sat';
          break;
        case 6:
          return 'Sun';
          break;
        default:
          throw Error();
      }
    } else if (currentIndex == 2) {
      switch (groupX.toInt()) {
        case 0:
          return 'Prod A';
          break;
        case 1:
          return 'Prod B';
          break;
        case 2:
          return 'Prod C';
          break;
        case 3:
          return 'Prod D';
          break;
        case 4:
          return 'Prod E';
          break;
        case 5:
          return 'Prod F';
          break;
        case 6:
          return 'Prod G';
          break;
        case 7:
          return 'Prod H';
          break;
        case 8:
          return 'Prod I';
          break;
        case 9:
          return 'Prod J';
          break;
        case 10:
          return 'Prod K';
          break;
        case 11:
          return 'Prod L';
          break;
        default:
          throw Error();
      }
    } else if (currentIndex == 3) {
      switch (groupX.toInt()) {
        case 0:
          return 'NSE 1';
          break;
        case 1:
          return 'NSE 2';
          break;
        case 2:
          return 'NSE 3';
          break;
        case 3:
          return 'NSE 4';
          break;
        case 4:
          return 'NSE 5';
          break;
        case 5:
          return 'NSE 6';
          break;
        case 6:
          return 'NSE 7';
          break;
        case 7:
          return 'NSE 8';
          break;
        case 8:
          return 'NSE 9';
          break;
        case 9:
          return 'NSE 10';
          break;
        default:
          throw Error();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  groupsSpace: widget.selectedOptions.isEmpty ? 5 : 10,
                  barTouchData: BarTouchData(
                    handleBuiltInTouches: true,
                    touchCallback: (FlTouchEvent event, BarTouchResponse touchResponse) {
                      debugPrint('Event :- $event');
                      if (event is FlLongPressEnd && widget.isFilterEnabled) {
                        widget.toggleFilterDisplay();
                      }
                    },
                    // touchCallback: (p0, p1) {
                    //   if (now - lastTap < 1500) {
                    //     lastTap = DateTime.now().millisecondsSinceEpoch;
                    //     debugPrint("Consecutive tap");
                    //     consecutiveTaps++;
                    //     debugPrint("taps = " + consecutiveTaps.toString());
                    //     if (consecutiveTaps >= 10) {
                    //       widget.toggleFilterDisplay();
                    //     }
                    //   } else {
                    //     consecutiveTaps = 0;
                    //   }
                    //   lastTap = now;
                    // },
                    touchTooltipData: BarTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipBgColor: Colors.black,
                      maxContentWidth: 250,
                      getTooltipItem: (group, index, rod, rodIndex) {
                        String weekDay = assignLabels(widget.currentIndex, group.x);

                        return BarTooltipItem(
                          weekDay + '\n',
                          const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 75,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (rod.toY - 1).toString(),
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  alignment: widget.selectedOptions.isEmpty
                      ? BarChartAlignment.spaceEvenly
                      : BarChartAlignment.center,
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
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(value.toString(), style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<List<String>> titles = [
      ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
      ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      [
        "Prod A",
        "Prod B",
        "Prod C",
        "Prod D",
        "Prod E",
        "Prod F",
        "Prod G",
        "Prod H",
        "Prod I",
        "Prod J",
        "Prod K",
        "Prod L"
      ],
      ["NSE 1", "NSE 2", "NSE 3", "NSE 4", "NSE 5", "NSE 6", "NSE 7", "NSE 8", "NSE 9", "NSE 10"],
    ];

    Widget text = Text(
      titles[widget.currentIndex][value.toInt()],
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
        space: 5, //margin top
        child: text,
      ),
    );
  }
}
