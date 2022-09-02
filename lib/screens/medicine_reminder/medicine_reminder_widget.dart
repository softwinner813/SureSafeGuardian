import 'dart:async';

import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/model/mqtt/MedicineReminder.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/components/notification/notification_manager.dart';
import 'package:guardian/screens/drawer/Drawer.dart';

import '../components/app_bar_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class MedicineReminderWidget extends StatefulWidget {
  MedicineReminderWidget({Key? key}) : super(key: key);

  @override
  _MedicineReminderWidgetState createState() => _MedicineReminderWidgetState();
}

class _MedicineReminderWidgetState extends State<MedicineReminderWidget> {
  late TextEditingController textController1;
  double sliderValue1 = 0.0;
  late TextEditingController textController2;
  double sliderValue2 = 0.0;
  bool _loadingButton = false;
  bool switchListTileValue1 = false;
  bool switchListTileValue2 = false;
  bool switchListTileValue3 = false;
  bool switchListTileValue4 = false;
  bool switchListTileValue5 = false;
  bool switchListTileValue6 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<MedicineReminder> reminders = [];
  double time = 0.0;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    loadReminders();
  }

  loadReminders() async {

    setState(() {
      reminders = [];
      isloading = true;
    });
    reminders = await Repository().getAllMedicineReminder(context);
    reminders.forEach((element) {
      element.daysList = element.days?.split(",");
    });
    isloading = false;
    print("reminder list loaded ${reminders.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      drawer: DrawerScreen(),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Group_933.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppBarComponentWidget(),
                    Expanded(
                      child: Container(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        color: Color(0xF25C5C5A),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isloading
                                ? Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                )
                                : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: reminders.length,
                                        itemBuilder: (context, index) {
                                          return itemReminderAdd(
                                              reminders[index], index);
                                        })),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    reminders.add(MedicineReminder(
                                        id: 0,
                                        title: "",
                                        time: DateTime.now(),days:"",daysList: []));
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD24B4B),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Add Reminder',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                            if (reminders.length == 0)
                              SizedBox(
                                height: 16,
                              ),

                            if (reminders.length != 0)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 16, 0, 16),
                                child: FFButtonWidget(
                                  onPressed: ()  async{
                                    setState(() {
                                      isloading = true;
                                    });
                                    reminders.forEach((element) async {
                                      element.days = element.daysList?.join(",");
                                      await Repository().addMedicineReminder(
                                          context, element);
                                      NotificationManger().scheduleNotification(element.id??0,element.time??DateTime.now(),"Medicine Reminder",element.title??"");
                                      await  Future.delayed(Duration(seconds: 1));
                                    });
                                    await  Future.delayed(Duration(seconds: 1));
                                   setState(() {
                                     isloading = false;
                                   });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MedicineReminderWidget()));
                                  },
                                  text: 'Save Alerts',
                                  options: FFButtonOptions(
                                    width: 190,
                                    height: 50,
                                    color: FlutterFlowTheme.primaryColor,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 50,
                                  ),
                                  loading: _loadingButton,
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemReminderAdd(MedicineReminder medicineReminder, int index) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reminder #${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            IconButton(
                onPressed: () async {
                  int? deleted = await Repository()
                      .deleteMedicineReminder(context, medicineReminder);
                  NotificationManger().cancelNotification(medicineReminder.id??0);
                  setState(() {
                    reminders.remove(medicineReminder);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: TextFormField(
              initialValue: medicineReminder.title.toString(),
              decoration: InputDecoration(
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                contentPadding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              ),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              onChanged: (value) {
                setState(() {
                  reminders[index].title = value;
                });
              },
            ),
          ),
        ),
        Text(
          '${medicineReminder.time?.hour != 0 ? medicineReminder.time?.hour : sliderValue1.toStringAsFixed(2)} ${sliderValue1 < 12 ? "am" : "pm"}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 30,
          ),
        ),
        Slider(
          activeColor: Colors.white,
          inactiveColor: Color(0x7EFFFFFF),
          min: 0,
          max: 24,
          divisions: 24,
          value: (reminders[index].time?.hour ?? 0).toDouble(),
          onChanged: (newValue) {
            var _time = DateTime.now();
            setState(() {
              reminders[index].time = DateTime(
                _time.year,
                _time.month,
                _time.day,
                newValue.toInt(),
              );
            });
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            itemDay(medicineReminder,index,"Mon"),
            itemDay(medicineReminder,index,"Tues"),
            itemDay(medicineReminder,index,"Wed"),
            itemDay(medicineReminder,index,"Thurs"),
            itemDay(medicineReminder,index,"Fri"),
            itemDay(medicineReminder,index,"Sat"),
            itemDay(medicineReminder,index,"Sun"),
          ],
        ),
        SizedBox(height: 8,),
      ],
    );
  }

  Widget itemDay(MedicineReminder medicineReminder, int index,String day){
    return InkWell(
      onTap: (){
        setState(() {
          reminders[index].daysList?.contains(day) == true ? reminders[index].daysList?.remove(day) : reminders[index].daysList?.add(day);
        });
      },
      child: Row(
        children: [
          reminders[index].daysList?.contains(day) == true ? Icon(Icons.check_circle,size: 14,color: MqttGreenColor,) : Icon(Icons.check_circle_outline,
              size: 14,color: Colors.white,) ,
          SizedBox(width: 3,),
          Text(
            '$day',
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
              color: reminders[index].daysList?.contains(day) == true ? MqttGreenColor :  Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

}
