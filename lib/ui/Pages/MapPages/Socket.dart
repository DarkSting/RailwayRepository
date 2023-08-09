import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../Theme/LightColor.dart';

class Socket extends StatefulWidget {
  const Socket({super.key});

  @override
  State<Socket> createState() => _SocketState();
}

class _SocketState extends State<Socket> {
  late IO.Socket socket;


  @override
  void initState(){
    super.initState();
    initSocket();
  }

  Future<void> initSocket() async {
    try {
      socket = IO.io("http://192.168.8.114:8080", <String,dynamic>{
        "transports":["websocket"],
        "autoConnect":false
      });

      socket.connect();
      socket.onConnect((_) {
        print('Connection established');
      });
      socket.onDisconnect((_) => print('Connection Disconnection'));
      socket.onConnectError((err) => print(err));

    } catch (e) {
      print("im invoked");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController _latitude = TextEditingController();
    final TextEditingController _longitude = TextEditingController();

    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _latitude,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline,
                      color: LightColor.darkBlue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: LightColor.extraDarkBlue)),

                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: LightColor.darkBlue, width: 2))),
            ),
            TextFormField(
              controller: _longitude ,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: const Icon(Icons.person_outline,
                    color: LightColor.darkBlue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: LightColor.extraDarkBlue)),

                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: LightColor.darkBlue, width: 2)),
              ),
            ),
            FractionallySizedBox(
                widthFactor: 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: LightColor.lightOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                  ),
                  onPressed: () async{

                    try{
                      print(socket.connected);
                      socket.emit("invoke","token");

                    }
                    catch(e){
                      print(e);
                    }

                  }
                  ,
                  child: const Text("submit"),
                )
            ),

          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
}
