import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/pages/branch/widgets/branch_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({Key? key}) : super(key: key);

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColors.lightPrimary,
        title: Text("เลือกสาขา"),
      ),
      body: BranchList(),
    );
  }
}
