// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:guardian/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}




//                Align(
//                   alignment: AlignmentDirectional(0, 1.04),
//                   child: Container(
//                     width: double.infinity,
//                     height: 600,
//                     decoration: BoxDecoration(
//                       color: Color(0xF25C5C5A),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Text(
//                                 'Reminder #1',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 30,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
//                             child: Container(
//                               width: double.infinity,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: Colors.white,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: TextFormField(
//                                 controller: textController1,
//                                 obscureText: false,
//                                 decoration: InputDecoration(
//                                   hintText: 'Medication Name',
//                                   hintStyle: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w300,
//                                     fontSize: 14,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 1,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(4.0),
//                                       topRight: Radius.circular(4.0),
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 1,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(4.0),
//                                       topRight: Radius.circular(4.0),
//                                     ),
//                                   ),
//                                   contentPadding:
//                                       EdgeInsetsDirectional.fromSTEB(
//                                           10, 10, 10, 10),
//                                 ),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w300,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '7:00am',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.normal,
//                               fontSize: 30,
//                             ),
//                           ),
//                           Slider(
//                             activeColor: Colors.white,
//                             inactiveColor: Color(0x7EFFFFFF),
//                             min: 0,
//                             max: 24,
//                             value: sliderValue1,
//                             onChanged: (newValue) {
//                               setState(() => sliderValue1 = newValue);
//                             },
//                           ),
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 'Mon',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Tues',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Wed',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Thurs',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Fri',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Sat',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Sun',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Text(
//                                   'Reminder #2',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 30,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
//                             child: Container(
//                               width: double.infinity,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: Colors.white,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: TextFormField(
//                                 controller: textController2,
//                                 obscureText: false,
//                                 decoration: InputDecoration(
//                                   hintText: 'Medication Name',
//                                   hintStyle: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w300,
//                                     fontSize: 14,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 1,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(4.0),
//                                       topRight: Radius.circular(4.0),
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 1,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(4.0),
//                                       topRight: Radius.circular(4.0),
//                                     ),
//                                   ),
//                                   contentPadding:
//                                       EdgeInsetsDirectional.fromSTEB(
//                                           10, 10, 10, 10),
//                                 ),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w300,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '7:00am',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.normal,
//                               fontSize: 30,
//                             ),
//                           ),
//                           Slider(
//                             activeColor: Colors.white,
//                             inactiveColor: Color(0x7EFFFFFF),
//                             min: 0,
//                             max: 24,
//                             value: sliderValue2,
//                             onChanged: (newValue) {
//                               setState(() => sliderValue2 = newValue);
//                             },
//                           ),
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 'Mon',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Tues',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Wed',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Thurs',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Fri',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Sat',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               Text(
//                                 'Sun',
//                                 style: FlutterFlowTheme.bodyText1.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
//                             child: Container(
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFD24B4B),
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             'Add Reminder',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w300,
//                               fontSize: 14,
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
//                             child: FFButtonWidget(
//                               onPressed: () {
//                                 print('Button pressed ...');
//                               },
//                               text: 'Save Alerts',
//                               options: FFButtonOptions(
//                                 width: 300,
//                                 height: 50,
//                                 color: FlutterFlowTheme.primaryColor,
//                                 textStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 24,
//                                 ),
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1,
//                                 ),
//                                 borderRadius: 50,
//                               ),
//                               loading: _loadingButton,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 )