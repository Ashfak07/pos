import 'dart:convert';

import 'package:http/http.dart';
import 'package:pos/model/sales_report_model/sales_report_model.dart';
import 'package:http/http.dart' as http;
import 'package:pos/controller/bar_graph_controller/individual_bar.dart';

class BarGraphController {
  List<SalesReportModel> salesReportList = [];
  Future getSalesReport() async {
    var url = 'http://192.168.1.9/pos/salesreport_view.php';
    Response response;
    response = await http.get(Uri.parse(url));
    final List model = jsonDecode(response.body);
    salesReportList = model
        .map<SalesReportModel>((e) => SalesReportModel.fromJson(e))
        .toList();

    // print(salesReportList);
    initializeBarData();
  }

  List<IndividualBar> barData = [];
  void initializeBarData() async {
    barData = await salesReportList
        .map<IndividualBar>((e) =>
            IndividualBar(x: int.parse(e.date), y: int.parse(e.prdtprice)))
        .toList();
    print(barData);
  }
}
