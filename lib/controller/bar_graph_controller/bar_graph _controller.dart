import 'dart:convert';

import 'package:http/http.dart';
import 'package:pos/model/sales_report_model/sales_report_model.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/bar_graph_controller/individual_bar.dart';

class BarGraphController {
  List salesReportList = [];
  Future getSalesReport(String date) async {
    var url = 'http://192.168.1.8/pos/salesreport_view.php';
    Response response;
    response = await http.post(Uri.parse(url), body: {'date': date});
    final List model = jsonDecode(response.body);
    salesReportList = model;
    print(salesReportList);
    initializeBarData();
    // print(salesReportList);
  }

  List<IndividualBar> barData = [];
  void initializeBarData() async {
    barData = await salesReportList
        .map<IndividualBar>((e) =>
            IndividualBar(x: int.parse(e['ym']), y: int.parse(e['prdtprice'])))
        .toList();
    print(barData);
  }
}
