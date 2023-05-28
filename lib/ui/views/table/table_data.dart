import 'package:floatingbubble/constants/constants.dart';
import 'package:flutter/material.dart';

class TableData {
  static String graphColumXLabel = 'Xaxis';
  static String graphColumYLabel = 'Yaxis';

  static List<String> barGraphCaption = [
    'March has the highest sales',
    'Sun has the highest sales',
    'Prod C has the highest Revenue',
    'NSE 7 has the highest Revenue',
  ];
  static List<String> lineGraphCaption = [
    '2012 has the highest Revenue',
    'Sun has the highest sales',
    'March has the highest sales',
    'Qtr* 3 has the highest Revenue',
  ];
  static String pieChartCaption = 'Majority class is Region A';

  static List<String> barLineGraphScale = [
    'Xaxis = Years\nYaxis = Revenue in Millions',
    'Xaxis = Weeks\nYaxis = Sales in Millions',
    'Xaxis = Month\nYaxis = Sales in Millions',
    'Xaxis = NSE Stocks\nYaxis = Revenue in Millions'
  ];

  static List<String> lineGraphScale = [
    'X axis = Month\nY axis = Sales in Millions',
    'Xaxis = Days\nYaxis = Sales in Millions',
    'Xaxis = Products of a Company\nYaxis = Revenue in Millions',
    'Xaxis = Quarters for 2 and a half years\nYaxis = Revenue in Millions'
  ];
  static String pieGraphScale =
      'Percentage Distribution\nXvalue = Demograph\nYvalue = Percentage Population ';

  static String pieColumXLabel = 'Xvalue';
  static String pieColumYLabel = 'Yvalue';

  static List<List<String>> labelXBarGraph = [
    ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    [
      'Prod A',
      'Prod B',
      'Prod C',
      'Prod D',
      'Prod E',
      'Prod F',
      'Prod G',
      'Prod H',
      'Prod I',
      'Prod J',
      'Prod K',
      'Prod L'
    ],
    ['NSE 1', 'NSE 2', 'NSE 3', 'NSE 4', 'NSE 5', 'NSE 6', 'NSE 7', 'NSE 8', 'NSE 9', 'NSE 10']
  ];

  static List<List<String>> labelYBarGraph = [
    ['10', '5', '18', '4', '15', '8', '6', '7', '13', '8', '9', '11'],
    ['8', '12', '5', '9', '4', '10', '15'],
    ['10', '5', '18', '7', '15', '8', '11', '7', '3', '6', '12', '5'],
    ['10', '5', '11', '7', '5', '12', '15', '7', '3', '13']
  ];

  static List<List<String>> labelXLineGraph = [
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
    ['Qtr 1', 'Qtr 2', 'Qtr 3', 'Qtr 4', 'Qtr* 1', 'Qtr* 2', 'Qtr* 3', 'Qtr* 4', 'Qtr^ 1', 'Qtr^ 2']
  ];

  static List<List<String>> labelYLineGraph = [
    ['9', '4', "17", '4', '15', '8', '6', '12', '4', '8', '9', '6'],
    ['8', '12', '5', '9', '4', '10', '15'],
    ['10', '5', '18', '7', '15', '8', '11', '7', '3', '6', '12', '5'],
    ['10', '5', '11', '7', '5', '12', '15', '7', '3', '13']
  ];

  static List<String> labelXPie = ['Region A', 'Region B', 'Region C', 'Region D'];
  static List<String> labelYPie = ['45%', '25%', '20%', '10%'];

  static List<TableRow> getTableRowsGraoh(GraphType graphType, currentIndex) {
    var currentLabelsX = graphType == GraphType.barChart ? labelXBarGraph : labelXLineGraph;
    var currentLabelsY = graphType == GraphType.barChart ? labelYBarGraph : labelYLineGraph;

    List<TableRow> tableRowsGraph = [
      TableRow(
        children: [
          Column(
            children: [
              Text(graphColumXLabel),
            ],
          ),
          Column(
            children: [
              Text(graphColumYLabel),
            ],
          ),
        ],
      ),
    ];

    for (var index = 0; index < currentLabelsX[currentIndex].length; index++) {
      tableRowsGraph.add(
        TableRow(
          children: [
            Column(
              children: [
                Text(currentLabelsX[currentIndex][index]),
              ],
            ),
            Column(
              children: [
                Text(currentLabelsY[currentIndex][index]),
              ],
            ),
          ],
        ),
      );
    }
    return tableRowsGraph;
  }

  static List<TableRow> getTableRowsPie() {
    List<TableRow> tableRowsPieChart = [
      TableRow(
        children: [
          Column(
            children: [
              Text(pieColumXLabel),
            ],
          ),
          Column(
            children: [
              Text(pieColumYLabel),
            ],
          ),
        ],
      ),
    ];

    for (var index = 0; index < labelXPie.length; index++) {
      tableRowsPieChart.add(
        TableRow(
          children: [
            Column(
              children: [
                Text(labelXPie[index]),
              ],
            ),
            Column(
              children: [
                Text(labelYPie[index]),
              ],
            ),
          ],
        ),
      );
    }
    return tableRowsPieChart;
  }
}
