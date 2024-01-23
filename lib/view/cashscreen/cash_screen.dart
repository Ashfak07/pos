import 'package:flutter/material.dart';
import 'package:pos/controller/product_add_controller/product_add_controller.dart';
import 'package:pos/controller/product_checkout_controller/product_checkout_controller.dart';
import 'package:provider/provider.dart';

class CashScreen extends StatelessWidget {
  CashScreen({super.key, required this.total_amount});
  double total_amount;
  var text_receivedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Column(
            children: [
              Text(
                "$total_amount",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Total amount due",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cash Received",
                style: TextStyle(color: Colors.green.shade300),
              ),
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      const Color.fromARGB(255, 142, 220, 145))),
              onPressed: () {
                context
                    .read<ProductcheckoutController>()
                    .Salesreport()
                    .then((value) => Navigator.pop(context));
              },
              child: Text(
                'Cash',
                style: TextStyle(color: Colors.black),
              ))
        ]),
      ),
    );
  }
}
