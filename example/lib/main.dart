import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Radar Chart Example"),
        ),
        body: Column(children: [
          Container(
            width: 450,
            height: 450,
            color: Colors.amber,
            //Radar Chart
            child: RadarChart(
              values: [1, 2, 4, 7, 9, 0, 6],
              labels: [
                Text(
                  '1',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  '2',
                  style: TextStyle(color: Colors.blue),
                ),
                Text('3'),
                Text('4'),
                Text('5'),
                Text('6'),
                Text('7'),
              ],
              maxValue: 10,
              fillColor: Colors.blue,
              chartRadiusFactor: 0.9,
            ),
          ),
          //Pie Chart
          // PieChart(
          //   values: [15, 10, 30, 25, 20],
          //   labels: ["Label1", "Label2", "Label3", "Label4", "Label5"],
          //   sliceFillColors: [
          //     Colors.blueAccent,
          //     Colors.greenAccent,
          //     Colors.pink,
          //     Colors.orange,
          //     Colors.red,
          //   ],
          //   animationDuration: Duration(milliseconds: 1500),
          //   legendPosition: LegendPosition.Right,
          // ),
        ]),
      ),
    );
  }
}