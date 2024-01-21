import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'product_list_model.g.dart';

@HiveType(typeId: 1)
class ProductListModel {
  @HiveField(0)
  final Uint8List image;
  @HiveField(1)
  final String pname;
  @HiveField(2)
  final String qty;
  @HiveField(3)
  final String itemcode;

  ProductListModel(
      {required this.image,
      required this.pname,
      required this.qty,
      required this.itemcode});
}
