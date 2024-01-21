import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:pos/controller/product_checkout_controller/product_checkout_controller.dart';
import 'package:pos/model/product_view_model/product_view_model.dart';
import 'package:pos/utils/const/textstyle_const.dart';
import 'package:pos/utils/const/variable_const.dart';
import 'package:pos/view/cashscreen/cash_screen.dart';
import 'package:pos/view/changequantity_screeen/change_quantity_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    print(Provider.of<ProductcheckoutController>(context, listen: false)
        .checkoutprdt);
    // TODO: implement initState
    super.initState();
  }

  List newlist = [];
  List list = [];
  bool scanstate = false;
  String _scanbarcodeResult1 = '';
  Future<void> barCodeScanner(BuildContext context) async {
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
        _scanbarcodeResult1 = result;
      });
    } else {
      Text('something wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductcheckoutController produccheckout =
        Provider.of(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyleConst.heading3,
                ),
                Icon(
                  Icons.notifications_none,
                  size: 32,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 151, 47, 202),
                        Color.fromARGB(255, 225, 88, 150)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(9.0, 7), //(x,y)
                          blurRadius: 9.0,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/icons/Slice.png'),
                        Text(
                          '120',
                          style: TextStyleConst.heading4,
                        ),
                        Text(
                          'Product in',
                          style: TextStyleConst.heading4,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(145, 91, 3, 74),
                        Color.fromARGB(255, 238, 105, 105)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(9.0, 7), //(x,y)
                          blurRadius: 9.0,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/icons/Slice.png'),
                        Text(
                          '120',
                          style: TextStyleConst.heading4,
                        ),
                        Text(
                          'Product out',
                          style: TextStyleConst.heading4,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () {
                barCodeScanner(context);
                context
                    .read<ProductcheckoutController>()
                    .getCheckoutproduct(_scanbarcodeResult1);
                scanstate = true;
                setState(() {});
              },
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text('Click here to scan')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product',
                    style: TextStyleConst.heading5,
                  ),
                  Text(
                    'qty',
                    style: TextStyleConst.heading5,
                  ),
                  Text(
                    'price',
                    style: TextStyleConst.heading5,
                  )
                ],
              ),
            ),
            Divider(
              thickness: 10,
            ),
            scanstate == true
                ? Container(
                    child: Expanded(
                    child: ListView(
                      children: [
                        ...produccheckout.checkoutprdt
                            .map((e) => basket_item(e))
                      ],
                    ),
                  ))
                : Text('data'),
            _buildTotalPrice(produccheckout, scanstate),
            scanstate == true
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            const Color.fromARGB(255, 142, 220, 145))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CashScreen(
                                  total_amount: produccheckout.totalAmount)));
                    },
                    child: Text(
                      'Cash',
                      style: TextStyle(color: Colors.black),
                    ))
                : SizedBox()
          ],
        ),
      ),
    ));
  }
}

basket_item(ProductviewModel model) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model.prdtname),
            InkWell(
                onTap: () {
                  print("name " + model.prdtname.toString());
                  Get.to(() => ChangeQuantityScreen(
                      title: model.prdtname,
                      barcode: model.prdtcode,
                      qty: model.prdtqty));
                },
                child: Text(model.prdtqty)),
            Text(model.prdtprice.toString())
          ],
        ),
      )
    ],
  );
}

_buildTotalPrice(ProductcheckoutController controller, bool state) =>
    state == true
        ? Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total Price : ",
                  style: TextStyle(color: Colors.red[300], fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  controller.totalAmount.toString() + " LL",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        : SizedBox();
