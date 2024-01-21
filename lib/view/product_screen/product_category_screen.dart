import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pos/controller/product_cat_sql/product_cat_sqlcontroller.dart';

import 'package:pos/model/product_cat_model.dart';
import 'package:pos/utils/const/textstyle_const.dart';
import 'package:pos/view/product_add_screen/prodcut_add_screen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  File? _image;
  Uint8List? imagearray;
  final ImagePicker imgpicker = ImagePicker();
  void selectedimage() async {
    var file = await imgpicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(file!.path);
      imagearray = _image!.readAsBytesSync();
    });
  }

  // Future getImage() async {
  //   try {
  //     var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _image = pickedFile as File;
  //       });
  //     } else {
  //       print("No image is selected.");
  //     }
  //   } catch (e) {
  //     print("error while picking image.");
  //   }
  // }

  TextEditingController categorynamecontroller = TextEditingController();
  // @override
  // void initState() {
  //   Provider.of<ProductCartegoryController>(context,listen: false);
  //   // TODO: implement initState
  //   super.initState();
  // }
  // @override
  // void initState() {
  //   loadDbData();
  //   super.initState();
  // }

  // loadDbData() async {
  //   await Provider.of<ProductCartegoryController>(context, listen: false)
  //       .loadDb();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    ProductCatSqlController productcatprovider =
        Provider.of<ProductCatSqlController>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 370,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      backgroundColor: MaterialStatePropertyAll(
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
                          TextFormField(
                            controller: categorynamecontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product category name',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue)),
                                onPressed: () {
                                  productcatprovider.addCat(
                                      name: categorynamecontroller.text,
                                      image: _image!);
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
          child: Icon(Ionicons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products category',
                      style: TextStyleConst.heading5,
                    ),
                    Icon(
                      Icons.search,
                      size: 32,
                    )
                  ],
                ),
                Flexible(
                  child: FutureBuilder(
                      future: productcatprovider.getCat(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) print(snapshot);
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data != null
                                    ? snapshot.data.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  List list = snapshot.data;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ProductAddScreen();
                                        }));
                                      },
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                ondismiss(context, index);
                                                setState(() {});
                                              },
                                              backgroundColor:
                                                  Color(0xFFFE4A49),
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset:
                                                      Offset(9.0, 7), //(x,y)
                                                  blurRadius: 9.0,
                                                )
                                              ]),
                                          child: ListTile(
                                            leading: Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                'http://192.168.1.6/pos/uplods${list[index]['prdtctimage']}',
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                            title: Text(list[index]
                                                    ['prdtctname']
                                                .toString()),
                                            trailing:
                                                Icon(Icons.arrow_forward_ios),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

ondismiss(context, int index) {}
