import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guardian/voip/actor/UserCallerActor.dart';

class CallScreenView extends StatefulWidget {
  final String mobileNumber;
  final String name;

  const CallScreenView({Key? key,required this.mobileNumber,required this.name}) : super(key: key);
  @override
  _CallScreenViewState createState() => _CallScreenViewState();
}

class _CallScreenViewState extends State<CallScreenView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   init();
  }

  init()async{
    var responseCalling = await  UserCallerActor().makeCall("+917304610113");
    print("Call Status-------> $responseCalling");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff081C3F),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 46),
                        child: Text(
                          "Calling",
                          style: TextStyle(color: Colors.white),
                        )),
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff192B48)),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Color(0xff69C1D4)),
                            padding: EdgeInsets.all(40),
                            child: Text(
                              "${widget.name.characters.first}",
                              style: TextStyle(fontSize: 36,color: Colors.white),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                        child: Text(
                          "Duration 00:35",
                          style: TextStyle(color: Colors.white60),
                        )),
                  ],
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(onPressed: ()async{
                   var responseCallEnd = await UserCallerActor().endCall();
                   if(responseCallEnd == true){
                     Fluttertoast.showToast(msg: "Call end failed");
                   }else{
                     Fluttertoast.showToast(msg: "Call ended");
                     Navigator.pop(context);
                   }

                  },child: Icon(Icons.call_end),backgroundColor: Colors.redAccent,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
