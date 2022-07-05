import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:berded_seller/src/utils/ImageUtil.dart';
import 'package:berded_seller/src/utils/Util.dart';
import 'package:berded_seller/src/utils/formatter.dart';
import 'package:berded_seller/src/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/src/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _packageVersion = '';

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    initPackageInfoState();
  }

  void initPackageInfoState() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      _packageVersion = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        height: double.infinity,
        child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          _buildDrawerHeader(context),
          _buildDrawerSubHeader(context),
          _buildDrawerMenu(context),
        ])),
      ),
    );
  }

  _buildDrawerHeader(BuildContext context) {
    final userFontScale = MediaQuery.of(context).textScaleFactor;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final _packageId = state.result?.package_id ?? 0;
        return SizedBox(
          height: 240.0,
          child: DrawerHeader(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    width: 80,
                    height: 65,
                    child: CircleAvatar(
                      backgroundImage: getFullProfileImagePath(state.result?.branch_avatar ?? ""),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Text(
                    state.result?.branch_name ?? "Loading...",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18 / userFontScale, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.result?.username ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12 / userFontScale, color: Colors.grey.shade700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 8),
                        padding: EdgeInsets.only(top: 2, right: 6, bottom: 2, left: 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Color(
                              getBerdedPackageColor(_packageId),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppRoute.top_up),
                          child: Text(
                            getBerdedPackageName(_packageId),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12 / userFontScale,
                              color: Color(
                                getBerdedPackageColor(_packageId),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (state.result?.certified ?? false)
                        Container(
                          width: 100,
                          height: 35,
                          child: Image.asset('assets/icon/ic_certified.png'),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildDrawerSubHeader(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${FormatterConvert().withComma(state.result?.total_number ?? 0)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Container(
                              width: 15,
                                height: 15,
                                child: Image.asset('assets/icon/ic_all.png'),
                            ),
                            Text(' เบอร์ทั้งหมด', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${FormatterConvert().withComma(state.result?.count_berded ?? 0)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              child: Image.asset('assets/icon/ic_berded.png'),
                            ),
                            Text(' เบอร์เด็ด', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${FormatterConvert().withComma(state.result?.count_recommend ?? 0)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              child: Image.asset('assets/icon/ic_intro.png'),
                            ),
                            Text(' เบอร์แนะนำ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20,
                thickness: 0.6,
                endIndent: 0,
                color: Colors.grey.shade300,
              ),
              Container(
                padding: EdgeInsets.only(left: 14.0),
                child: Row(
                  children: [
                    Text('วันหมดอายุ : ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
                    Text(
                      state.result?.expired != null
                          ? "${FormatterConvert().formattedDate(state.result!.expired)} " + "(${FormatterConvert().expirationDate(state.result!.expired).toString()})"
                          : '',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildDrawerMenu(BuildContext context) {
    final authorizedBranches = context.read<BranchBloc>().state.authorizedBranches?.length ?? 0;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 280,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                  leading: Icon(Icons.payments),
                  title: const Text("แจ้งชำระเงิน"),
                  onTap: () async {
                    Navigator.pop(context);
                    await AppTrackingTransparency.requestTrackingAuthorization();
                    Navigator.pushNamed(context, AppRoute.top_up);
                  }),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(authorizedBranches > 1 ? "ออกจากระบบ(สาขาปัจจุบัน)" : "ออกจากระบบ"),
                onTap: () => authorizedBranches > 1 ? context.read<LoginBloc>().add(LoginEventLogoutOnlyCurrentBranch()) : context.read<LoginBloc>().add(LoginEventLogout()),
              ),
              if (authorizedBranches > 1)
                ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text("ออกจากระบบ(ทุกสาขา)"),
                  onTap: () => context.read<LoginBloc>().add(LoginEventLogout()),
                ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 100, height: 60, child: Image.asset('assets/icon/manage_berded.png')),
                Text('เวอร์ชัน $_packageVersion'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
