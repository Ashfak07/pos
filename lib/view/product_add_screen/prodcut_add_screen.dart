import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pos/controller/product_add_controller/product_add_controller.dart';
import 'package:pos/utils/const/textstyle_const.dart';
import 'package:pos/utils/const/variable_const.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  // @override
  // void initState() {
  //   loadDbData();
  //   // TODO: implement initState
  //   super.initState();
  // }

  TextEditingController productNameController = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController qty = TextEditingController();

  List list = [];

  String _scanbarcodeResult = '';
  File? _image;
  Uint8List? imagearray;
  final ImagePicker imgpicker = ImagePicker();
  void selectedimage() async {
    var file = await imgpicker.pickImage(source: ImageSource.camera);

    _image = File(file!.path);
    imagearray = _image!.readAsBytesSync();
  }

  Future<void> barCodeScanner() async {
    String result;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'cancel', true, ScanMode.BARCODE);
      debugPrint(result);
    } on PlatformException {
      result = 'Failed to get platform';
    }
    if (mounted) {
      setState(() {
        _scanbarcodeResult = result;
      });
    } else {
      Text('something wrong');
    }
  }

  @override
  void initState() {
    print(Variableconst.data);
    super.initState();
  }
  // loadDbData() async {
  //   await Provider.of<ProductListController>(context, listen: false).loadDb();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    ProductAddController productList = Provider.of(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                barCodeScanner();
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 1000,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  DottedBorder(
                                      padding: EdgeInsets.all(20),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(30),
                                      strokeWidth: 1,
                                      child: _image != null
                                          ? Image.file(
                                              _image!,
                                              width: 100,
                                            )
                                          : Icon(Ionicons.camera)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.blue)),
                                      onPressed: () async {
                                        selectedimage();
                                      },
                                      child: Text(
                                        'Add image',
                                        style: TextStyleConst.heading4,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('item code:-${_scanbarcodeResult}'),
                              TextFormField(
                                controller: productNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Product name',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: price,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'price',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: qty,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Qty',
                                ),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blue)),
                                    onPressed: () {
                                      setState(() {
                                        productList.addCat(
                                            qty: qty.text,
                                            name: productNameController.text,
                                            price: price.text,
                                            code: _scanbarcodeResult,
                                            image: _image!);
                                      });
                                    },
                                    child: Text(
                                      'save',
                                      style: TextStyleConst.heading4,
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.qr_code_scanner,
                size: 30,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.search,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
                child: FutureBuilder(
                    future: productList.getProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data != null
                                ? snapshot.data.length
                                : 0,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          ondismiss(context, list[index]['id']);
                                          setState(() {
                                            var url =
                                                'http://192.168.1.9/pos/delete_product.php';
                                            http.post(Uri.parse(url), body: {
                                              "id": list[index]['id']
                                            });
                                          });
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                      // SlidableAction(
                                      //   onPressed: doNothing,
                                      //   backgroundColor: Color(0xFF21B7CA),
                                      //   foregroundColor: Colors.white,
                                      //   icon: Icons.share,
                                      //   label: 'Share',
                                      // ),
                                    ],
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(9.0, 7), //(x,y)
                                            blurRadius: 9.0,
                                          )
                                        ]),
                                    child: ListTile(
                                      leading: Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          'http://192.168.1.9/pos/uplods${list[index]['prdtiamge']}',
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                      title: Text(list[index]['prdtname']),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(list[index]['prdtqty']
                                              .toString()),
                                          Row(
                                            children: [
                                              Text(list[index]['prdtprice']
                                                  .toString()),
                                              InkWell(
                                                  onTap: () {
                                                    int qty = int.parse(
                                                        list[index]['prdtqty']);

                                                    qty = qty + 1;
                                                    productList.editproduct(
                                                        list[index]["id"],
                                                        qty.toString());
                                                    setState(() {
                                                      Variableconst.data = list;
                                                      print(Variableconst.data);
                                                    });
                                                  },
                                                  child: Icon(Icons.add))
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
          ],
        ));
  }
}

ondismiss(context, String index) {
  Provider.of<ProductAddController>(context, listen: false).deleteitem(index);
}
