import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentFunction {

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(int amount) async {

    final url = Uri.parse('http://192.168.8.114:8080/payment/makePayment');
    final headers = {
      'Content-Type':'application/json'
    };

    final data ={
        'amount':amount
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      Map<String,dynamic> paymentIntentData = jsonDecode(response.body);
      

      if(paymentIntentData['paymentIntent']!="" && paymentIntentData['paymentIntent'] !=null){
        String _intent = paymentIntentData['paymentIntent'];

        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: _intent,
              applePay: false,
              googlePay: false,
              merchantCountryCode: "SL",
              merchantDisplayName: "OpenSourceX",
              testEnv: false,
              customerId: paymentIntentData['customer'],
              customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
            )
        );
      await Stripe.instance.presentPaymentSheet();


    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }


    }

  }


}
