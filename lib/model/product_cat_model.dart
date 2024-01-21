import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'product_cat_model.g.dart';

@HiveType(typeId: 1)
class ProductCatModel {
  @HiveField(0)
  final Uint8List image;
  @HiveField(1)
  final String pname;

  ProductCatModel({required this.image, required this.pname});
}
