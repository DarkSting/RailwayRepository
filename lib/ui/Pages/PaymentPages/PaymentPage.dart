import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Components/TrainModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentFunction {

  Map<String, dynamic>? paymentIntent;

  Future<String> getStoredCookies() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt') ?? '';

  }

  Future<void> makePayment(int amount, TrainBooking bookingData) async {

    String storedCookies = await getStoredCookies();

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

        //when the payment is successfull the booking controller will be invoked
      await Stripe.instance.presentPaymentSheet().whenComplete(() async{

        try{


          //mail sending
          final emailUrl = Uri.parse('http://192.168.8.114:8080/payment/sendmail');

          final mailBody = {
            'user': '64c2bea893fbba7a0836ab3f'
            ,'bookedSeatsArray' : bookingData.bookedSeats
            ,'cost': bookingData.totalPrice
            ,'paidDate': DateTime.now().toString()
            ,'discounts': 5
          };


          final emailResponse = await http.post(
            emailUrl,
            headers: headers,
            body: jsonEncode(mailBody),
          );



          if(emailResponse.statusCode==200){
            print(jsonDecode(emailResponse.body));
          }

          if(response.statusCode==201){
                print("train seat booked");
          }
          else{
            throw Exception(jsonDecode(response.body));
          }
        }
        catch(e){
          print(e);
        }

      });


    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }


    }

  }


}
