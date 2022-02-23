import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarChartDialog extends StatefulWidget {
  BarChartDialog({
    Key key,
  }): super(key: key);

  @override
  BarChartDialogState createState() => BarChartDialogState();
}

class BarChartDialogState extends State<BarChartDialog> {
  List graphDataList = [];

  List get getGraphDataList => graphDataList;

  List<TextEditingController> itemController = List.generate(15, (i) => TextEditingController());
  List<TextEditingController> valueController = List.generate(15, (i) => TextEditingController());

  final inputList = <Widget>[];
  var ngText = '';

  @override
  void initState() {
    super.initState();
  }

  checkDataList(dataList) {
    var isFormatCheck = false;
    var ngIndex = [];
    for (var i = 0; i < dataList.length; i++) {
      var inputItem = dataList[i][0];
      var inputValue = dataList[i][1];
      if (inputItem.length == 0) {
        isFormatCheck = true;
        ngIndex.add(i + 1);
        continue;
      }

      if (int.tryParse(inputValue) is !int) {
        isFormatCheck = true;
        ngIndex.add(i + 1);
        continue;
      }
    }
    return {
      'isNG': isFormatCheck,
      'ngIndex': ngIndex
    };
  }

  listToString(list) {
    return list.map<String>((value) => value.toString()).join(',');
  }

  buildValueList() {
    final valueList = <Widget>[];
    valueList.add(
        SimpleDialogOption(
          child: Column(
            children: [
              Column(
                children: inputList,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('追加'),
                      onPressed: () {
                        setState(() {
                          if (inputList.length == 15) {
                            return;
                          }

                          inputList.add(
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: itemController[inputList.length],
                                      decoration: InputDecoration(hintText: '項目名'),
                                    ),
                                  ),
                                  Text(
                                    '：',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: valueController[inputList.length],
                                      decoration: InputDecoration(hintText: '値(割合)'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  )
                                ],
                              )
                          );
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text('削除'),
                      onPressed: () {
                        setState(() {
                          inputList.removeLast();
                        });
                      },
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('OK'),
                onPressed: () {
                  var updateGraphDataList = [];
                  inputList.asMap().forEach((key, value) {
                    var oneDataList = [itemController[key].text, valueController[key].text];
                    updateGraphDataList.add(oneDataList);
                    var checkResult = checkDataList(updateGraphDataList);
                    if (checkResult['isNG']) {
                      var ngIndex = checkResult['ngIndex'];
                      setState(() {
                        ngText = ' ' + listToString(ngIndex) + ' のフォーマットが正しくありません';
                      });
                      return;
                    } else {
                      setState(() {
                        ngText = '';
                        graphDataList = updateGraphDataList;
                      });
                    }
                  });
                },
              )
            ],
          ),
        )
    );
    return valueList;
  }

  buildInitialValue() {
    List valueList = [];
    for (var i = 0; i < 15; i++) {
      if ((graphDataList.length - 1) == i) {
        valueList.add(
            [graphDataList[i][0], graphDataList[i][1]]
        );
      } else {
        valueList.add(
            ['', '']
        );
      }
    }
    return valueList;
  }

  @override
  Widget build(BuildContext context) {
    var inputColumn = Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: itemController[0],
            decoration: InputDecoration(hintText: '項目名'),
          ),
        ),
        Text(
          '：',
          style: TextStyle(fontSize: 18),
        ),
        Flexible(
          child: TextFormField(
            controller: valueController[0],
            decoration: InputDecoration(hintText: '値(割合)'),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );

    if (inputList.length == 0) {
      inputList.add(inputColumn);
    }

    return SimpleDialog(
      title: Text('入力値$ngText'),
      children: buildValueList(),
    );
  }
}