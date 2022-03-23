import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
// import 'package:payu_money_flutter/payu_money_flutter.dart';

class PayuPayment extends StatefulWidget {
  @override
  _PayuPaymentState createState() => _PayuPaymentState();
}

class _PayuPaymentState extends State<PayuPayment> {
  // Creating PayuMoneyFlutter Instance
  // PayuMoneyFlutter payuMoneyFlutter = PayuMoneyFlutter();

  // Payment Details
  String phone = "9876543210";
  String email = "gmail@gmail.com";
  String productName = "My Product Name";
  String firstName = "Vaibhav";
  String txnID = "223428947";
  String amount = "1.0";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Payu Money Flutter'),
        ),
        body: Center(
          child: Text("Pay Us 10"),
        ),
        floatingActionButton: FloatingActionButton(
          // Starting up the payment
          onPressed: () {},
          child: Icon(Icons.attach_money),
        ),
      ),
    );
  }
}
