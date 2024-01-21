import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductCatSqlController with ChangeNotifier {
  Future<void> addCat({required String name, required File image}) async {
    final uri = Uri.parse('http://192.168.1.9/pos/product_cat_add.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['prdtctname'] = name;
    var pic = await http.MultipartFile.fromPath('prdtctimage', image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('iamge uploded');
    } else {
      print('object');
    }
    notifyListeners();
  }

  Future getCat() async {
    var url = 'http://192.168.1.9/pos/category_view.php';
    var response = await http.get(Uri.parse(url));

    return jsonDecode(response.body);
  }
}
