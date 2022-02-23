import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'barChartDialog.dart';

class BarChartPage extends StatefulWidget {
  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  List data;
  final valueList = <Widget>[];

  List<charts.Series<BarData, String>> _barData;

  @override
  void initState() {
    super.initState();
    _barData = List<charts.Series<BarData, String>>();
    data = [
      ['none', '100']
    ];
  }

  generateData(data) {
    List<BarData> pieData = [];
    for (var i = 0; i < data.length; i++) {
      pieData.add(new BarData(data[i][0], double.parse(data[i][1])));
    }
    _barData = [];
    _barData.add(
      charts.Series(
        domainFn: (BarData data, _) => data.activity,
        measureFn: (BarData data, _) => data.time,
        id: 'Time spent',
        data: pieData,
        labelAccessorFn: (BarData row, _) => '${row.activity}',
        colorFn: (BarData data, _) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
      ),
    );
    return _barData;
  }

  @override
  Widget build(BuildContext context) {
    final barChartDialogKey = GlobalObjectKey<BarChartDialogState>(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: charts.BarChart(
            generateData(data),
            animate: true,
            animationDuration: Duration(seconds: 0),
            domainAxis: new charts.OrdinalAxisSpec(
                renderSpec: new charts.SmallTickRendererSpec(
                    labelRotation: 45,
                    labelStyle: new charts.TextStyleSpec(
                        fontSize: 16
                    )
                )
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        FlatButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return BarChartDialog(key: barChartDialogKey);
              },
            ).then((value) {
              var graphDataList = barChartDialogKey.currentState?.graphDataList;
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

class BarData {
  String activity;
  double time;
  BarData(this.activity, this.time);
}