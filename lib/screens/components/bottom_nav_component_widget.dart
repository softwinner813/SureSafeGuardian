import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/VoipUser.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class BottomNavComponentWidget extends StatefulWidget {
  BottomNavComponentWidget({Key? key}) : super(key: key);

  @override
  _BottomNavComponentWidgetState createState() =>
      _BottomNavComponentWidgetState();
}

class _BottomNavComponentWidgetState extends State<BottomNavComponentWidget> {
  List<VoipUser> voipUsers = [];
  int defaultUserId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init()async{
    voipUsers = await DBProvider.db.getAllVoipUser();
    defaultUserId = await getVoipUser();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFB5C4CF),
        ),
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: voipUsers.length == 0 ? Center(child: Text("No Voice Connection Set Up")) :  ListView.builder(
              shrinkWrap: true,
                itemCount: voipUsers.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                VoipUser voipUser = voipUsers[index];
              return Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    Container(
                      child: Align(
                        alignment: AlignmentDirectional(0, -0.11),
                        child: Text(
                          '${voipUser.name.toString().characters.first.toUpperCase()}',
                          style: TextStyle(
                            color: Color(0xFF9FBBE2),
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.94, -0.87),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: defaultUserId == voipUser.id ? MqttGreenColor :  Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
  Widget dummyView(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -0.11),
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Color(0xFF9FBBE2),
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.94, -0.87),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -0.11),
                  child: Text(
                    'P',
                    style: TextStyle(
                      color: Color(0xFF93F490),
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.94, -0.87),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -0.11),
                  child: Text(
                    'J',
                    style: TextStyle(
                      color: Color(0xFF9FBBE2),
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.94, -0.87),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -0.11),
                  child: Text(
                    'S',
                    style: TextStyle(
                      color: Color(0xFF9FBBE2),
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.94, -0.87),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -0.11),
                  child: Text(
                    'N',
                    style: TextStyle(
                      color: Color(0xFF9FBBE2),
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.94, -0.87),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
