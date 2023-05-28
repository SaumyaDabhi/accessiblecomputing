import 'package:floatingbubble/constants/constants.dart';
import 'package:floatingbubble/ui/bar_chart/bar_chart.dart';
import 'package:floatingbubble/ui/views/charts/chart_options.dart';
import 'package:floatingbubble/ui/line_chart/line_chart.dart';
import 'package:floatingbubble/ui/pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  final List<SelectOption> selectedOptions;
  final GraphType graphType;
  final int currentIndex;
  final Function toggleFilterDisplay;
  final bool isFilterEnabled;

  const Charts({
    Key key,
    this.selectedOptions,
    this.graphType,
    this.currentIndex,
    this.toggleFilterDisplay,
    this.isFilterEnabled = false,
  }) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    StatefulWidget questionsComponent;

    switch (widget.graphType) {
      case GraphType.barChart:
        questionsComponent = BarChartUI(
          currentIndex: widget.currentIndex,
          selectedOptions: widget.selectedOptions,
          toggleFilterDisplay: widget.toggleFilterDisplay,
          isFilterEnabled: widget.isFilterEnabled,
        );
        break;
      case GraphType.lineChart:
        questionsComponent = LineChartUI(
          currentIndex: widget.currentIndex,
          selectedOptions: widget.selectedOptions,
          toggleFilterDisplay: widget.toggleFilterDisplay,
          isFilterEnabled: widget.isFilterEnabled,
        );
        break;
      case GraphType.pieChart:
        questionsComponent = PieChartUI(
          currentIndex: widget.currentIndex,
          selectedOptions: widget.selectedOptions,
          toggleFilterDisplay: widget.toggleFilterDisplay,
          isFilterEnabled: widget.isFilterEnabled,
        );
        break;
      default:
    }
    return questionsComponent;

    // return ListView(
    //   primary: false,
    //   shrinkWrap: true,
    //   children: [
    //     BarChartUI(
    //       selectedOptions: widget.selectedOptions,
    //     ),
    //     LineChartUI(
    //       selectedOptions: widget.selectedOptions,
    //     ),
    //     PieChartUI(
    //       selectedOptions: widget.selectedOptions,
    //     )
    //   ],
    // );
  }
}
