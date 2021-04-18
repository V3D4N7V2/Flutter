//BT19CSE004
//Vedant Ghuge
//CSE A 4th Sem
//Debug Apk Drive Link : https://drive.google.com/drive/folders/16nqWIzLQpaatuxCFYESM7EkmIFnBEtoA?usp=sharing

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BT19CSE004',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //double xA = 0, yA = 0, zA = 0, xG = 0, yG = 0, zG = 0;
  double x = 0, y = 0, z = 0;

  // var _sensors = <String>['accelerometer', 'gyroscope'];
  var _sensors = ['accelerometer', 'gyroscope'];
  String _selectedSensor; // _sensors[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent eventA) {
      if (_selectedSensor == 'accelerometer')
        setState(() {
          x = eventA.x;
          y = eventA.y;
          z = eventA.z;
          // x = xA;
          // y = yA;
          // z = zA;
        });
    }); //get the sensor data and set then to the data types

    gyroscopeEvents.listen((GyroscopeEvent eventG) {
      if (_selectedSensor == 'gyroscope')
        setState(() {
          x = eventG.x;
          y = eventG.y;
          z = eventG.z;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Sensor Library (BT19CSE004)"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Select the sensor from the dropdown list",
                  style:
                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
              ),
              DropdownButton<String>(
                value: _selectedSensor,
                onChanged: (val) {
                  setState(() {
                    // updating the state
                    _selectedSensor = val;

                    // if (_selectedSensor == 'accelerometer') {
                    //   // do something here
                    //   x = xA;
                    //   y = yA;
                    //   z = zA;
                    // }

                    // if (_selectedSensor == 'gyroscope') {
                    //   // do something here
                    //   x = xG;
                    //   y = yG;
                    //   z = zG;
                    // }
                  });
                },
                items: _sensors.map((String elem) {
                  return DropdownMenuItem<String>(
                    value: elem,
                    child: Text(elem),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Table(
                border: TableBorder.all(
                    width: 2.0,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "X axis: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            //x.toStringAsFixed(), //trim the asis value to 2 digit after decimal point
                            x.toStringAsFixed(
                                5), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Y axis: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            y.toStringAsFixed(
                                5), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Z axis: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            z.toStringAsFixed(
                                5), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
