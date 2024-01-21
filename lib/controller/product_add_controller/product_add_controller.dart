import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductAddController with ChangeNotifier {
  List<dynamic> Category = [];
  Future<void> addCat(
      {required String qty,
      required String name,
      required String price,
      required String code,
      required File image}) async {
    final uri = Uri.parse('http://192.168.1.9/pos/productsadd.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['prdtname'] = name;
    request.fields['prdtprice'] = price;
    request.fields['prdtqty'] = qty;
    request.fields['prdtcode'] = code;

    var pic = await http.MultipartFile.fromPath('prdtiamge', image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('iamge uploded');
    } else {
      print('object');
    }
    notifyListeners();
  }

  Future getProduct() async {
    var url = 'http://192.168.1.9/pos/product_view.php';
    var response = await http.get(Uri.parse(url));

    return jsonDecode(response.body);
  }

  void deleteitem(String index) async {
    var url = 'http://192.168.1.9/pos/delete_product.php';
    await http.post(Uri.parse(url), body: {"id": index});
    notifyListeners();
  }

  void editproduct(String id, String qty) async {
    var url = 'http://192.168.1.9/pos/updateqty.php';
    await http.post(Uri.parse(url), body: {"id": id, "prdtqty": qty});
    print('object');
    notifyListeners();
  }
}
