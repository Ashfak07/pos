import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
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
    controller.getSalesReport(selectedDate.toString());
    // TODO: implement initState
    super.initState();
  }

  DateTime? selectedDate = DateTime.now();
  String year = DateFormat('yyyy').format(DateTime.now());
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> monthsName = [
    '',
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  // List<String> amount = [
  //   "1k",
  //   "2k",
  //   "3k",
  //   "4k",
  //   "5k",
  //   "6k",
  //   "7k",
  //   "8k",
  //   "9k",
  //   "10k",
  // ];

  BarGraphController controller = BarGraphController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Report'),
        ),
        backgroundColor: Color.fromARGB(255, 255, 253, 253),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  selectYear(context);
                  setState(() {
                    controller.getSalesReport(selectedDate.toString());
                  });
                },
                child: Text(year)),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Color.fromARGB(255, 11, 9, 22),
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarChart(BarChartData(
                        barTouchData: BarTouchData(enabled: true),
                        maxY: 10000,
                        gridData: FlGridData(
                            drawHorizontalLine: true, drawVerticalLine: false),
                        borderData: FlBorderData(
                            show: false,
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                                axisNameWidget: Text(
                                  'Months',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 156, 153, 153)),
                                ),
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: ((value, meta) {
                                      return Text(
                                        monthsName[value.toInt()],
                                        style: TextStyle(color: Colors.black),
                                      );
                                    }))),
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
                                        // color: Color.fromARGB(255, 101, 97, 97),
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      gradient: LinearGradient(colors: [
                                        const Color(0xff23b6e6),
                                        const Color(0xff02d39a),
                                      ]),
                                      toY: double.parse(e.y.toString()),
                                    )
                                  ],
                                ))
                            .toList())),
                  ),
                ),
              ),
            ),
            Center(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        controller.getSalesReport(selectedDate.toString());
                      });
                    },
                    child: Icon(Icons.refresh))),
            Text('Tap here to refresh'),
          ],
        )
        // : Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Center(
        //           child: InkWell(
        //               onTap: () {
        //                 setState(() {});
        //               },
        //               child: Icon(Icons.refresh))),
        //       Text('Tap here to refresh'),
        //       Text(formattedDate)
        //     ],
        //   )

        );
  }

  // Widget getBottomTitle(double value, TitleMeta meta) {
  //   BarGraphController controller = BarGraphController();
  //   Widget? text;
  //   controller.barData.map((e) => text = Text(e.x.toString()));

  //   return SideTitleWidget(child: text!, axisSide: meta.axisSide);
  // }

  selectYear(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('select year'),
            content: SizedBox(
              height: 300,
              width: 300,
              child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 10, 1),
                  lastDate: DateTime(2060),
                  selectedDate: selectedDate,
                  onChanged: (DateTime dateTime) {
                    setState(() {
                      selectedDate = dateTime;
                      year = dateTime.year.toString();
                      controller.getSalesReport(selectedDate.toString());
                    });
                    Navigator.pop(context);
                  }),
            ),
          );
        });
  }
}
