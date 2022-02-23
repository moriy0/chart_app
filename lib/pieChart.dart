import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'pieChartDialog.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List data;
  final valueList = <Widget>[];

  List<charts.Series<PieData, String>> _pieData;

  @override
  void initState() {
    super.initState();
    _pieData = List<charts.Series<PieData, String>>();
    data = [
      ['none', '100']
    ];
  }

  generateData(data) {
    List<PieData> pieData = [];
    for (var i = 0; i < data.length; i++) {
      pieData.add(new PieData(data[i][0], double.parse(data[i][1])));
    }
    _pieData = [];
    _pieData.add(
      charts.Series(
        domainFn: (PieData data, _) => data.activity,
        measureFn: (PieData data, _) => data.time,
        id: 'Time spent',
        data: pieData,
        labelAccessorFn: (PieData row, _) => '${row.activity}',
        colorFn: (PieData data, _) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
      ),
    );
    return _pieData;
  }

  @override
  Widget build(BuildContext context) {
    final pieChartDialogKey = GlobalObjectKey<PieChartDialogState>(context);

    return Scaffold(
      body: Center(
        child: charts.PieChart(
          generateData(data),
          animate: true,
          animationDuration: Duration(seconds: 0),
          defaultRenderer: new charts.ArcRendererConfig(
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside)
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        FlatButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                // return PieChartDialog(key: pieChartDialogKey, dataList: data);
                return PieChartDialog(key: pieChartDialogKey);
              },
            ).then((value) {
              var graphDataList = pieChartDialogKey.currentState?.graphDataList;
              if (graphDataList.length != 0) {
                setState(() {
                  data = graphDataList;
                });
              }
            });
          },
          child: Icon(Icons.mode_edit),
        )
      ],
    );
  }
}

class PieData {
  String activity;
  double time;
  PieData(this.activity, this.time);
}