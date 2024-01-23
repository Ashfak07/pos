import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos/controller/bar_graph_controller/bar_graph%20_controller.dart';

class RepostScreen extends StatefulWidget {
  RepostScreen({super.key});

  @override
  State<RepostScreen> createState() => _RepostScreenState();
}

class _RepostScreenState extends State<RepostScreen> {
  @override
  void initState() {
    controller.getSalesReport();
    // TODO: implement initState
    super.initState();
  }

  BarGraphController controller = BarGraphController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        child: BarChart(BarChartData(
            maxY: 10000,
            minY: 0,
            barGroups: controller.barData
                .map((e) => BarChartGroupData(x: e.x.toInt(), barRods: [
                      BarChartRodData(toY: double.parse(e.y.toString()))
                    ]))
                .toList())),
      ),
    );
  }
}
