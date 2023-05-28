import 'package:floatingbubble/constants/constants.dart';
import 'package:floatingbubble/ui/views/table/table_data.dart';
import 'package:floatingbubble/utils/spaces.dart';
import 'package:flutter/material.dart';

class TableView extends StatefulWidget {
  final GraphType currentGraphType;
  final int currentIndex;
  const TableView({
    Key key,
    this.currentGraphType,
    this.currentIndex,
  }) : super(key: key);

  @override
  State<TableView> createState() => _TableState();
}

class _TableState extends State<TableView> {
  @override
  Widget build(BuildContext context) {
    String getCurrentCaption() {
      switch (widget.currentGraphType) {
        case GraphType.barChart:
          return TableData.barGraphCaption[widget.currentIndex];
          break;
        case GraphType.lineChart:
          return TableData.lineGraphCaption[widget.currentIndex];
          break;
        case GraphType.pieChart:
          return TableData.pieChartCaption;
          break;
        default:
          return TableData.barGraphCaption[widget.currentIndex];
          break;
      }
    }

    String getCurrentScale() {
      switch (widget.currentGraphType) {
        case GraphType.barChart:
          return TableData.barLineGraphScale[widget.currentIndex];
          break;
        case GraphType.lineChart:
          return TableData.barLineGraphScale[widget.currentIndex];
          break;
        case GraphType.pieChart:
          return TableData.pieGraphScale;
          break;
        default:
          return TableData.barLineGraphScale[widget.currentIndex];
          break;
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(120.0),
              border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 2,
              ),
              children: (widget.currentGraphType == GraphType.barChart ||
                      widget.currentGraphType == GraphType.lineChart)
                  ? TableData.getTableRowsGraoh(widget.currentGraphType, widget.currentIndex)
                  : TableData.getTableRowsPie(),
            ),
          ),
          Text(
            getCurrentCaption(),
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),

          /// Vertical Spacing
          SpaceH10(),

          Text(
            getCurrentScale(),
          ),
        ],
      ),
    );
  }
}
