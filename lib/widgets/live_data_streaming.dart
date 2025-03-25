import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilimboga/config/size_config.dart';
import 'package:kilimboga/data/models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveDataStreaming extends StatefulWidget {
  const LiveDataStreaming({super.key});

  @override
  State<LiveDataStreaming> createState() => _LiveDataStreamingState();
}

class _LiveDataStreamingState extends State<LiveDataStreaming> {
  List<SensorData> _chartData = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _chartData = getInitialData();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        var randomValue = Random().nextDouble() * 50;

        final newData = List<SensorData>.from(_chartData);
        final newEntry = SensorData(
          DateTime.now(),
          10 + randomValue,
          15 + randomValue,
          20 + randomValue,
          30 + randomValue,
          40 + randomValue,
          25 + randomValue,
          7 + randomValue,
        );

        newData.add(newEntry);

        if (newData.length > 20) {
          newData.removeAt(0);
        }

        _chartData = newData;

      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<SensorData> getInitialData() {
    return [
      SensorData(DateTime.now(), 12, 18, 22, 35, 45, 27, 6.5),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      width: double.infinity,
      height: SizeConfig.blockSizeVertical! * 50,
      child: SfCartesianChart(
        title: const ChartTitle(text: "Real-time Sensor Data"),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const DateTimeAxis(),
        axes: const [
          NumericAxis(
            name: 'phAxis',
            opposedPosition: true,
            title: AxisTitle(text: 'pH Level'),
          ),
        ],
        series: [
          LineSeries<SensorData, DateTime>(
            name: 'Nitrogen',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.nitrogen,
            color: Colors.blue,
          ),
          LineSeries<SensorData, DateTime>(
            name: 'Phosphorus',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.phosphorus,
            color: Colors.green,
          ),
          LineSeries<SensorData, DateTime>(
            name: 'Potassium',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.potassium,
            color: Colors.red,
          ),
          LineSeries<SensorData, DateTime>(
            name: 'Moisture',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.moisture,
            color: Colors.orange,
          ),
          LineSeries<SensorData, DateTime>(
            name: 'Humidity',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.humidity,
            color: Colors.purple,
          ),
          LineSeries<SensorData, DateTime>(
            name: 'Temperature',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.temperature,
            color: Colors.teal,
          ),
          LineSeries<SensorData, DateTime>(
            name: 'pH',
            dataSource: _chartData,
            xValueMapper: (SensorData data, _) => data.time,
            yValueMapper: (SensorData data, _) => data.ph,
            color: Colors.grey,
            yAxisName: 'phAxis',
          ),
        ],
      ),
    );
  }
}
