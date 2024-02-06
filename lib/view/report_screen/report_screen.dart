import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
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

  DateTime selectedDate = DateTime.now();
  late String formattedDate = DateFormat('MMM/dd/yy').format(DateTime.now());
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate as DateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('MMM/dd/yy').format(selectedDate);
      });
    }
  }

  BarGraphController controller = BarGraphController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Report'),
        ),
        backgroundColor: Color.fromARGB(255, 255, 253, 253),
        body: controller.salesReportList.isNotEmpty
            ? Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(formattedDate.toString())),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: BarChart(BarChartData(
                          maxY: 10000,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                              // bottomTitles: AxisTitles(
                              //     sideTitles: SideTitles(
                              //         showTitles: true, getTitlesWidget: getBottomTitle))
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false))),
                          minY: 0,
                          barGroups: controller.barData
                              .map((e) => BarChartGroupData(
                                      x: int.parse(e.x.toString()),
                                      barRods: [
                                        BarChartRodData(
                                          width: 25,
                                          backDrawRodData:
                                              BackgroundBarChartRodData(
                                            show: true,
                                            toY: 10000,
                                            color: Color.fromARGB(
                                                255, 215, 212, 212),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color.fromARGB(
                                              255, 36, 36, 36),
                                          toY: double.parse(e.y.toString()),
                                        )
                                      ]))
                              .toList())),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Icon(Icons.refresh))),
                  Text('Tap here to refresh')
                ],
              ));
  }
}

// Widget getBottomTitle(double value, TitleMeta meta) {
//   BarGraphController controller = BarGraphController();
//   Widget? text;
//   controller.barData.map((e) => text = Text(e.x));

//   return SideTitleWidget(child: text!, axisSide: meta.axisSide);
// }
