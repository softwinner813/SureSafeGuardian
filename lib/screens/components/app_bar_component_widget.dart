import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarComponentWidget extends StatefulWidget {
  AppBarComponentWidget({Key? key, this.isBackAllow = true}) : super(key: key);
 final bool isBackAllow;

  @override
  _AppBarComponentWidgetState createState() => _AppBarComponentWidgetState();
}

class _AppBarComponentWidgetState extends State<AppBarComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isBackAllow ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/images/Path_346.svg',
                      width: 24,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                ):Container(),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Path_229.svg',
                          width: 18,
                          height: 23,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_222.svg',
                          width: 19,
                          height: 19,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_223.svg',
                          width: 14,
                          height: 19,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_224.svg',
                          width: 16,
                          height: 19,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_229.svg',
                          width: 18,
                          height: 23,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_225.svg',
                          width: 16,
                          height: 19,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_226.svg',
                          width: 12,
                          height: 27,
                          fit: BoxFit.fitWidth,
                        ),
                        SvgPicture.asset(
                          'assets/images/Path_224.svg',
                          width: 16,
                          height: 19,
                          fit: BoxFit.fitWidth,
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Guardian',
                          style: TextStyle(
                            color: Color(0xFFD33157),
                            fontSize: 23,
                          ),
                        ),
                        Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.09, 0.35),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/Group_262.svg',
                                      width: 23,
                                      height: 18,
                                      fit: BoxFit.cover,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional(-0.04, -0.24),
                                    child: SvgPicture.asset(
                                      'assets/images/Path_230.svg',
                                      height: 9,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Icon(
                    Icons.dehaze,
                    color: FlutterFlowTheme.primaryColor,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFB5C4CF),
        )
      ],
    );
  }
}
