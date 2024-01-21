import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/controller/product_add_controller/product_add_controller.dart';
import 'package:pos/controller/product_cat_sql/product_cat_sqlcontroller.dart';
import 'package:pos/controller/product_checkout_controller/product_checkout_controller.dart';

import 'package:pos/model/product_cat_model.dart';
import 'package:pos/model/product_list_model/product_list_model.dart';
import 'package:pos/view/bottomnav/bottom_navbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/view/changequantity_screeen/change_quantity_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductCatSqlController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductAddController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductcheckoutController(),
        ),
      ],
      child: GetMaterialApp(home: Bottomnav()),
    );
  }
}
