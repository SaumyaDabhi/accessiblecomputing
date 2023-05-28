import 'package:fl_chart/fl_chart.dart';
import 'package:floatingbubble/ui/views/charts/chart_options.dart';
import 'package:floatingbubble/ui/views/charts/charts_data.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';

class PieChartUI extends StatefulWidget {
  final int currentIndex;
  final List<SelectOption> selectedOptions;
  final Function toggleFilterDisplay;
  final bool isFilterEnabled;

  const PieChartUI({
    Key key,
    this.currentIndex,
    this.selectedOptions = const <SelectOption>[],
    this.toggleFilterDisplay,
    this.isFilterEnabled,
  }) : super(key: key);

  @override
  State<PieChartUI> createState() => _PieChartUIState();
}

class _PieChartUIState extends State<PieChartUI> {
  int touchedIndex = -1;

  List<PieChartSectionData> rawSections = [];
  List<PieChartSectionData> showingSections = [];

  @override
  void initState() {
    super.initState();

    rawSections = makeSections();

    if (widget.selectedOptions.isNotEmpty) {
      for (var selectedOption in widget.selectedOptions) {
        showingSections.add(rawSections[selectedOption.id]);
      }
    } else {
      showingSections = rawSections;
    }
  }

  List<Widget> makeIndicators() {}

  List<PieChartSectionData> makeSections() {
    final List<int> data = ChartsData.pieChartData;
    return List.generate(4, (index) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: ChartsData.pieChartColors[index],
        value: data[index].toDouble(),
        title: '${data[index]}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      );
    });
  }

  bool doesElementExist(int index) {
    if (widget.selectedOptions.isEmpty) {
      return true;
    }

    bool doesExist = false;

    for (var selectedOption in widget.selectedOptions) {
      if (index == selectedOption.id) {
        doesExist = true;
      }
    }
    return doesExist;
  }

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, PieTouchResponse touchResponse) {
                        debugPrint('Event :- $event');
                        if (event is FlLongPressEnd && widget.isFilterEnabled) {
                          widget.toggleFilterDisplay();
                        }
                      },
                      // touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      //   int now = DateTime.now().millisecondsSinceEpoch;
                      //   if (now - lastTap < 500) {
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
                      //   setState(() {
                      //     if (!event.isInterestedForInteractions ||
                      //         pieTouchResponse == null ||
                      //         pieTouchResponse.touchedSection == null) {
                      //       touchedIndex = -1;
                      //       return;
                      //     }
                      //     touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                      //   });
                      // },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: ChartsData.pieChartColors[0],
                  text: 'Region A',
                  isSquare: true,
                  isVisible: doesElementExist(0),
                ),
                Indicator(
                  color: ChartsData.pieChartColors[1],
                  text: 'Region B',
                  isSquare: true,
                  isVisible: doesElementExist(1),
                ),
                Indicator(
                  color: ChartsData.pieChartColors[2],
                  text: 'Region C',
                  isSquare: true,
                  isVisible: doesElementExist(2),
                ),
                Indicator(
                  color: ChartsData.pieChartColors[3],
                  text: 'Region D',
                  isSquare: true,
                  isVisible: doesElementExist(3),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }
}
