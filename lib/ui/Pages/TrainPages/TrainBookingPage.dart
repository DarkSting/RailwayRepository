import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_flutter/ui/Components/QuadClipper.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';
import 'package:login_flutter/ui/Pages/DashboardPages/DashBoard.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';
import 'package:login_flutter/ui/Pages/LoginAndSignupPages/login.dart';
import 'package:login_flutter/ui/Components/IncrementDecrementComponent.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Pages/PaymentPages/PaymentPage.dart';


class TrainBookingPage extends StatefulWidget {

  TrainBookingPage({required this.trainData,super.key});

  final double height = 60;
  TrainBooking trainData;

  @override
  State<TrainBookingPage> createState() => _TrainBookingPageState();
}

class _TrainBookingPageState extends State<TrainBookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerConFirmPassword = TextEditingController();

  final Box _boxAccounts = Hive.box("accounts");
  bool _obscurePassword = true;

  void updateParentWidget(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    color: LightColor.lightOrange,
                    borderRadius: BorderRadius.only(bottomRight:Radius.circular(50),bottomLeft:Radius.circular(50) )
                ),
                child:Center(
                  child: Text(
                    "Train Booking",
                    style: TextStyle(fontSize:40,color: Colors.white
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 35),

              //fields
              Container(

                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color : LightColor.lightOrange,
                    width:1.0,
                  )
                ),

                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text("Train ID : ${widget.trainData.trainNumber}",style: Theme.of(context).textTheme.titleMedium,) ,
                ),
              ),
              const SizedBox(height: 10),
              Container(

                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color : LightColor.lightOrange,
                      width:1.0,
                    )
                ),

                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text("passengers : ${widget.trainData.passengers}",style: Theme.of(context).textTheme.titleMedium,) ,
                ),
              ),

              const SizedBox(height: 10),
              Container(

                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color : LightColor.lightOrange,
                      width:1.0,
                    )
                ),

                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text("Seat Price : ${widget.trainData.seatPrice}",style: Theme.of(context).textTheme.titleMedium,) ,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color : LightColor.lightOrange,
                      width:1.0,
                    )
                ),

                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text("Seat Type : ${widget.trainData.seatType}",style: Theme.of(context).textTheme.titleMedium,) ,
                ),
              ),
              const SizedBox(height: 10),
              IncrementDecrementCard(title: "Seats Count",height: widget.height,bookingData: widget.trainData,callback: updateParentWidget,),
              const SizedBox(height: 30),
              Container(

                height: widget.height,
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Total Price : ${widget.trainData.totalPrice}",style: Theme.of(context).textTheme.titleLarge,) ,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [

                  FractionallySizedBox(

                      widthFactor: 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          ),
                        ),
                        onPressed: () async{
                            PaymentFunction function = PaymentFunction();

                            try{
                              print(widget.trainData.passengers);
                              await function.makePayment(widget.trainData.totalPrice);
                              Navigator.pushReplacement(
                                 context,
                                 MaterialPageRoute(builder: (context) =>const Dashboard()),
                                );

                            }catch(e){
                              print(e);
                            }

                            print("hello akash is it working");
                          
                        }
                        ,
                        child: const Text("Proceed to Payment"),
                      )
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}


