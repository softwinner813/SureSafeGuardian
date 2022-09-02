import 'package:fluttertoast/fluttertoast.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/VoipUser.dart';
import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/drawer/Drawer.dart';
import 'package:guardian/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:guardian/voip/actor/AuthenticationActor.dart';

import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class VoipProfilesView extends StatefulWidget {
  VoipProfilesView({Key? key}) : super(key: key);

  @override
  _VoipProfilesViewState createState() => _VoipProfilesViewState();
}

class _VoipProfilesViewState extends State<VoipProfilesView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _show = false;
  late TextEditingController profileController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController cPasswordController;
  bool passwordVisibility = false;
  bool _loadingButton = false;
  final formKey = GlobalKey<FormState>();
  List<VoipUser> voipUserList = [];
  int defaultVoIPUser = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    cPasswordController = TextEditingController();
    passwordVisibility = false;
    init();
  }

  init()async{
    voipUserList = await DBProvider.db.getAllVoipUser();
    defaultVoIPUser = await getVoipUser();
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: DrawerScreen(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Group_933.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppBarComponentWidget(),
                UserInfoAwayView(),
                SizedBox(height: 8,),
                Text("Tap On user name for default call",style: Theme.of(context).textTheme.caption,),
                SizedBox(height: 8,),
                Expanded(child: voipUserList.length == 0 ? Center(child: Text("VoIP Profile list is empty",style: Theme.of(context).textTheme.headline6,),) : ListView.builder(
                    shrinkWrap: true,
                    itemCount: voipUserList.length,
                    physics:AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      VoipUser? voipUser = voipUserList[index];
                      return ListTile(
                        onTap: ()async{
                          saveVoipUser(voipUser.id??-1);
                          setState(() {
                            defaultVoIPUser = voipUser.id??-1;
                          });
                        },
                        leading: Icon(Icons.circle,color: defaultVoIPUser == voipUser.id ? Colors.blue : Colors.grey,),
                        title: Text("${voipUser.name??""}"),
                        subtitle: Text(voipUser.username??""),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: ()async{
                            await DBProvider.db.deleteVoipUser(voipUser.id??0);
                            Fluttertoast.showToast(msg: "User removed successfully");
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VoipProfilesView()));
                          },
                        ),
                      );
                    }))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    color: Colors.white,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Text(
                            "Add VoIP Profile",
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        Text(
                          "To Ignore Any Changes and Exit This Screen Swipe Down",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),


                          TextFormField(
                            controller: profileController,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter profile name'),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter profile name";
                                }
                              }
                          ),
                          TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter username'),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter username";
                                }
                              }
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter password',
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter password";
                              }
                            },
                          ),
                          TextFormField(
                            controller: cPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Enter confirm password',
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter confirm password";
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16, 32, 16, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                setState(() => _loadingButton = true);
                                try {
                                  if (formKey.currentState!.validate()) {
                                    if(passwordController.text != cPasswordController.text){
                                      Fluttertoast.showToast(msg: "Password not matched");
                                    } else{
                                      var response = await DBProvider.db
                                          .newVoipUser(VoipUser(id: 1,
                                          name: profileController.text,
                                          username: usernameController.text,
                                          password: passwordController.text));
                                      print("add voip response $response");
                                      Fluttertoast.showToast(
                                          msg: "User Added Successfully");
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VoipProfilesView()));
                                    }
                                  }
                                } finally {
                                  setState(() => _loadingButton = false);
                                }
                              },
                              text: 'Save',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 40,
                                color: FlutterFlowTheme.primaryColor,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
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
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          label: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 8,
              ),
              Text("Add New")
            ],
          )),
    );
  }
}
