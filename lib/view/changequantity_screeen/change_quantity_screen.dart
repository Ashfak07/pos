import 'package:flutter/material.dart';
import 'package:pos/controller/product_checkout_controller/product_checkout_controller.dart';
import 'package:provider/provider.dart';

class ChangeQuantityScreen extends StatefulWidget {
  String title;
  String barcode;
  String qty;
  ChangeQuantityScreen(
      {super.key,
      required this.title,
      required this.barcode,
      required this.qty});

  @override
  State<ChangeQuantityScreen> createState() => _ChangeQuantityScreenState();
}

class _ChangeQuantityScreenState extends State<ChangeQuantityScreen> {
  List<String> _numbers = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "00",
    "OK",
  ];

  String qty = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title.toString()),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Quantity"),
                        SizedBox(height: 15),
                        Text(
                          "${qty}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          if (qty.length > 0) {
                            setState(() {
                              qty = qty.substring(0, qty.length - 1);
                            });
                          }
                        },
                        icon: Icon(Icons.cancel_presentation))
                  ],
                ),
              )),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      ..._numbers.map((e) => GestureDetector(
                          onTap: () {
                            print("item pressed " + e);
                            if (_numbers.indexOf(e) == 11) {
                              if (qty != "") {
                                context
                                    .read<ProductcheckoutController>()
                                    .onQuantityChanged(qty, widget.barcode)
                                    .then((value) {
                                  if (value == false) {
                                    print('object');
                                  }
                                });
                                Navigator.pop(context);

                                // return;
                              }
                            } else {
                              setState(() {
                                qty += e;
                              });

                              print("inside :" + qty);
                            }
                          },
                          child: _build_item_number(400 / 3, 120, e))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _build_item_number(double width, double height, String item) => Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
        height: height,
        width: width,
        child: Center(child: Text(item)),
      );
}
