import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos/model/facturemodel/facture.dart';
import 'package:pos/model/product_view_model/product_view_model.dart';
import 'package:pos/model/sales_report_model/sales_report_model.dart';

class ProductcheckoutController with ChangeNotifier {
  ProductviewModel? model;
  List<ProductviewModel> checkoutprdt = [];

  //getproduct by barcode
  Future getCheckoutproduct(String code) async {
    var url = 'http://192.168.1.9/pos/checkout_product_view.php';
    var response = await http.post(Uri.parse(url), body: {"prdtcode": code});
    final List jsondata = jsonDecode(response.body);
    jsondata.forEach((element) {
      checkoutprdt.add(ProductviewModel.fromJson(element));

      totalBillAmount();
      notifyListeners();
    });
  }

//clean bascket
  clearBascket() {
    totalAmount = 0;
    checkoutprdt.clear();
    notifyListeners();
  }

  //calculate total amount of bascket
  double totalAmount = 0;
  totalBillAmount() {
    totalAmount = 0;
    checkoutprdt.forEach((element) {
      totalAmount +=
          double.parse(element.prdtqty) * double.parse(element.prdtprice);
    });
    notifyListeners();
  }

  // change quantity of product in bascket
  Future<bool> onQuantityChanged(String qty, String barcode) async {
    bool isonchangesuccess = true;
    ProductviewModel? model = await getproduct(barcode);
    if (int.parse(model!.prdtqty.toString()) >= int.parse(qty)) {
      checkoutprdt.forEach((element) {
        if (element.prdtcode == barcode) element.prdtqty = qty;
      });
      notifyListeners();
      checkoutprdt.forEach((element) {
        print(element.prdtqty);
      });
      isonchangesuccess = true;
    } else {
      checkoutprdt.forEach((element) {
        if (element.prdtcode == barcode) element.prdtqty = model.prdtqty;
      });
      isonchangesuccess = false;
    }
    totalBillAmount();
    return isonchangesuccess;
  }

  bool isProductExist = false;
  Future<ProductviewModel?> getproduct(String code) async {
    ProductviewModel? model;
    var url = 'http://192.168.1.9/pos/checkout_product_view.php';
    var response = await http.post(Uri.parse(url), body: {"prdtcode": code});
    final List jsondata = jsonDecode(response.body);
    if (jsondata.length > 0) {
      isProductExist = true;
      jsondata.forEach((element) {
        model = ProductviewModel.fromJson(element);
      });
    } else {
      isProductExist = false;
    }
    notifyListeners();
    return model;
  }

  Future<SalesReportModel?> Salesreport() async {
    int checkoutid = 0;
    SalesReportModel? salesmode;
    FactureModel facture = FactureModel(
        price: totalAmount.toString(), date: DateTime.now().toString());
    Facture();

    print(checkoutid.toString());

    checkoutprdt.forEach((element) async {
      int totalprice = (int.parse(element.prdtqty.toString().trim()) *
          int.parse(element.prdtprice.toString()));
      final uri = Uri.parse('http://192.168.1.9/pos/salesreport.php');
      http.Response response;
      response = await http.post(uri, body: {
        "prdtname": element.prdtname,
        "prdtqty": element.prdtqty,
        "prdtprice": totalAmount.toString(),
        "prdtcode": element.prdtcode,
        "date": DateTime.now().toString()
      });
      ProductviewModel? model = await getproduct(element.prdtcode.toString());
      notifyListeners();
      int newqty = 0;
      if (model != null) {
        newqty = int.parse(model.prdtqty.toString()) -
            int.parse(element.prdtqty.toString());
        updateproduct(element.prdtcode, newqty.toString());
        clearBascket();
        notifyListeners();
      }
      if (response.statusCode == 200) {
        print('success');
      } else {
        print('object');
      }
    });

    return salesmode;
  }

  void updateproduct<ProductviewModel>(String code, String qty) async {
    var url = 'http://192.168.1.9/pos/update_product.php';
    await http.post(Uri.parse(url), body: {"prdtcode": code, "prdtqty": qty});
    print('object');
    notifyListeners();
  }

  Future<FactureModel?> Facture() async {
    FactureModel? model;

    final uri = Uri.parse('http://192.168.1.9/pos/facture.php');
    http.Response response;
    response = await http.post(uri, body: {
      'price': totalAmount.toString(),
      'date': DateTime.now().toString()
    });

    return model;
  }
}
