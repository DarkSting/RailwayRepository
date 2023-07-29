import 'package:http/http.dart' as http;
import 'dart:convert';

class TrainBoxModel {
   TrainBoxModel({
      this.name="", this.price=0, this.seatCount=0, this.seatClass=""});

  final String name;
  final int price;
  final int seatCount;
  final String seatClass;

   List<dynamic>? receivedTrainBoxes;

   Future<void> getTrainBoxes ({required int trainNumber}) async{

     print("im in the future function");
     final url = Uri.parse('http://192.168.8.114:8080/train/gettrain');

     final headers = {
       'Content-Type' : 'application/json',
     };

     final body = {

       "trainNumber":trainNumber,
     };

     http.Response response = await http.post(url,
       headers:headers,
       body: jsonEncode(body),
     );


     if(response.statusCode==200){
       List<dynamic> foundTrainBoxes =  jsonDecode(response.body)['trainBoxes'];
       receivedTrainBoxes=foundTrainBoxes;

     }
     else{
       print(jsonDecode(response.body)['msg']);
       return null;
     }

   }

  Future<void> populateTrainBoxes({int trainNumber=0}) async{

     try {
       await getTrainBoxes(trainNumber: trainNumber);
     }
     catch(e){
       print(e);
     }
  }
}