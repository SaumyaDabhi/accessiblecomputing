import 'package:floatingbubble/constants/constants.dart';
import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  final GraphType currentGraphType;
  final int currentIndex;

  const Summary({
    Key key,
    this.currentGraphType,
    this.currentIndex,
  }) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  List<String> barChartSummaryItems = [
    'As of March 2020, overall sales are at a record high at 10 million dollars followed by the months of May and September at 15 million dollars and 13 million dollars respectively. Overall sales for the year 2020 are 114 million dollars with the average sales at 9.5 million dollars.',
    'Overall sales are at a record high on Sunday at 15 million dollars followed by Tuesday and Saturday at 12 and 10 million dollars respectively. Overall sales for the is 63 million dollars with the average sales at 9 million dollars.',
    'Overall revenue is the highest for Product C amongst all other products at 18 million dollars of the company followed by products A E G and K at 10 15 11 and 12 million dollars respectively. Overall revenue for the products is 107 million dollars with the average revenue at 8.9 million dollars.',
    'Overall revenue is the highest for stock NSE 7 at 15 million dollars followed by NSE 3 NSE 6 and NSE 10 at 11 12 and 13 million dollars respectively. Overall revenue for the NSE stocks is 88 million dollars with the average revenue at 8.8 million dollars.'
  ];

  List<String> lineChartSummaryItems = [
    'The year 2012 contributes to 16% of the overall revenue. There are three peaks that occur in the years 2012, 2014, and 2017 and there is an overall decline in revenue over the last 12 years.',
    'Week 7 has the highest sales at 15 million dollars. There is a decline in sales from week 1 to week 4 and post week 5 there is a steep incline in overall sales upto week 7',
    'The month of March contributes to 17% of the overall sales. There are three peaks that occur in the months of March, May, and September and there is a subsequent decline in these peaks',
    'Qtr* 3  contributes to 17% of the overall revenue. There are two peaks that occur in the quarters of Qtr 3 and Qtr* 3 and there is a subsequent rise in these peaks',
  ];

  String getCurrenGraphSummary() {
    switch (widget.currentGraphType) {
      case GraphType.barChart:
        return barChartSummaryItems[widget.currentIndex];
        break;
      case GraphType.lineChart:
        return lineChartSummaryItems[widget.currentIndex];
        break;
      case GraphType.pieChart:
        return 'About 45% of the population resides in Region A followed by Region B, Region C, and Region D with 25%, 20%, and 10% of the population respectively.';
        break;
      default:
        return barChartSummaryItems[widget.currentIndex];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      child: Text(
        getCurrenGraphSummary(),
      ),
    );
  }
}
