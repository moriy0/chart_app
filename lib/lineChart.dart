import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'lineChartDialog.dart';

class LineChartPage extends StatefulWidget {
  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  List data;
  final valueList = <Widget>[];

  List<charts.Series<LineData, DateTime>> _lineData;

  @override
  void initState() {
    super.initState();
    _lineData = List<charts.Series<LineData, DateTime>>();
    data = [
      [new DateTime(9999, 1, 1), '100'],
      [new DateTime(9999, 1, 2), '80'],
      [new DateTime(9999, 1, 3), '50'],
      [new DateTime(9999, 1, 4), '90']
    ];
  }

  generateData(data) {
    List<LineData> lineData = [];
    for (var i = 0; i < data.length; i++) {
      lineData.add(new LineData(data[i][0], double.parse(data[i][1])));
    }
    _lineData = [];
    _lineData.add(
      charts.Series(
        domainFn: (LineData data, _) => data.date,
        measureFn: (LineData data, _) => data.value,
        id: 'Time spent',
        data: lineData,
        colorFn: (LineData data, _) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
      ),
    );
    return _lineData;
  }

  Future<void> keepFile(data) {
    print('keepImage');
    Uint8List buffer = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return ImageGallerySaver.saveImage(buffer);
  }

  // 現状、機能させられていない
  capture() async {
    var builder = ui.SceneBuilder();
    var scene = RendererBinding.instance.renderView.layer.buildScene(builder);
    var image = await scene.toImage(ui.window.physicalSize.width.toInt(), ui.window.physicalSize.height.toInt());
    scene.dispose();

    var data = await image.toByteData(format: ui.ImageByteFormat.png);
    await keepFile(data);
  }

  @override
  Widget build(BuildContext context) {
    final lineChartDialogKey = GlobalObjectKey<LineChartDialogState>(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: charts.TimeSeriesChart(
            generateData(data),
            animate: true,
            animationDuration: Duration(seconds: 0),
          ),
        ),
      ),
      persistentFooterButtons: [
        FlatButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                // return AwesomeDialog(key: awesomeDialogKey, dataList: data);
                return LineChartDialog(key: lineChartDialogKey);
              },
            ).then((value) {
              var graphDataList = lineChartDialogKey.currentState?.graphDataList;
              if (graphDataList.length != 0) {
                setState(() {
                  data = graphDataList;
                });
              }
            });
          },
          child: Icon(Icons.mode_edit),
        ),
        // FlatButton(
        //   onPressed: () {
        //     capture();
        //   },
        //   child: Icon(Icons.file_download),
        // )
      ],
    );
  }
}

class LineData {
  DateTime date;
  double value;
  LineData(this.date, this.value);
}