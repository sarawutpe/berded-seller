
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:berded_seller/src/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAlert(),
        const SizedBox(
          width: 20,
          height: 20,
        ),
        _buildLogo(),
        _buildManagementMenu(context),
      ],
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: 180,
          height: 60,
          child: Image.asset('assets/icon/manage_berded.png')),
    );
  }

  _buildAlert() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // skip if data is not ready
        if (state.result?.expired == null) {
          return SizedBox();
        }

        // skip if still not expired in 7 days
        final expiredDate =
            FormatterConvert().expirationDate(state.result!.expired);
        if (expiredDate > 7) {
          return SizedBox();
        }

        // expiration alert
        return Container(
            width: double.infinity,
            child: Material(
              color: Color(0XFFFFE4C7),
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('แพ็กเกจของคุณใกล้จะหมด '),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoute.top_up),
                      child: Text(
                        'กรุณาเติมเงิน',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _buildManagementMenu(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Wrap(
          direction: Axis.vertical,
          spacing: 8.0,
          runSpacing: 4.0,
          children: <Widget>[
            Row(
              children: [
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () async {
                          await AppTrackingTransparency
                              .requestTrackingAuthorization();
                          Navigator.pushNamed(context, AppRoute.store,
                              arguments: [
                                "https://www.berded.in.th/S3270",
                                "หน้าร้าน"
                              ]);
                        },
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: state.result?.branch_avatar != null &&
                                      state.result!.branch_avatar.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          state.result?.branch_avatar ??
                                              ""),
                                    )
                                  : Image.asset(
                                      'assets/icon/ic_launcher_android.png', width: 95, height: 95,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "หน้าร้าน",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () async {
                          await AppTrackingTransparency
                              .requestTrackingAuthorization();
                          Navigator.pushNamed(context, AppRoute.manage_menu);
                        },
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: const AssetImage(
                                  'assets/icon/ic_backend.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "จัดการเบอร์",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoute.studio),
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                              const AssetImage('assets/icon/ic_studio.png'),
                            )
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "สตูดิโอ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () => context
                            .read<BranchBloc>()
                            .add(BranchEventFetchMyBranches()),
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  const AssetImage('assets/icon/ic_branch.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "เปลี่ยนสาขา",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
