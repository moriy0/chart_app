import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pieChart.dart';
import 'barChart.dart';
import 'lineChart.dart';

void main() {
  runApp(MyApp(
    title: 'Flutter Demo',
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var mainThemeColor = Colors.blue;

  changeThemeColor(color) {
    if (color != mainThemeColor) {
      setState(() {
        mainThemeColor = color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: mainThemeColor,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.blue);
                        },
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.green);
                        },
                        color: Colors.green,
                        shape: CircleBorder(),
                      ),
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.orange);
                        },
                        color: Colors.orange,
                        shape: CircleBorder(),
                      ),
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.brown);
                        },
                        color: Colors.brown,
                        shape: CircleBorder(),
                      ),
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.red);
                        },
                        color: Colors.red,
                        shape: CircleBorder(),
                      ),
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.pink);
                        },
                        color: Colors.pink,
                        shape: CircleBorder(),
                      ),
                      FlatButton(
                        minWidth: 50,
                        onPressed: () {
                          changeThemeColor(Colors.purple);
                        },
                        color: Colors.purple,
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                ),
                SelectChartsButton()
              ],
            ),
          ),
        ));
  }
}

class SelectChartsButton extends StatefulWidget {
  @override
  _SelectChatsButtonState createState() => _SelectChatsButtonState();
}

class _SelectChatsButtonState extends State<SelectChartsButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NextPage(),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.pie_chart), Text('円グラフ')],
          ),
          // child: const Text('円グラフ'),
          style: OutlinedButton.styleFrom(minimumSize: Size(200, 100)),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BarChartPage()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.bar_chart), Text('棒グラフ')],
          ),
          style: OutlinedButton.styleFrom(minimumSize: Size(200, 100)),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LineChartPage()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.show_chart), Text('折れ線グラフ')],
          ),
          style: OutlinedButton.styleFrom(minimumSize: Size(200, 100)),
        )
      ],
    );
  }
}
