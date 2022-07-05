import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/bloc/branch/branch_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/models/seller_model.dart';
import 'package:berded_seller/src/pages/router.dart';
import 'package:berded_seller/src/utils/ImageUtil.dart';
import 'package:berded_seller/src/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class BranchList extends StatelessWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchBloc, BranchState>(
      builder: (context, state) {
        return Container(
          child: _buildBranchList(context, state),
        );
      },
    );
  }

  Widget _buildBranchList(BuildContext context, BranchState state) {

    return ListView.builder(
        itemBuilder: (context, index) {
          final branch = state.myBranchesResponse![index];
          final isAuthIndex = state.authorizedBranches?.indexWhere((element){
            return element.sellerId == branch.sellerId;
          });
          return TextButton(
            onPressed: () => context.read<BranchBloc>().add(BranchEventSelect(branch)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: getFullAvatarImagePath(branch.branchAvatar),
              ),
              title: Text(branch.branchName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${branch.email} (${branch.sellerId})",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "" + FormatterConvert().expirationDate(branch.expired).toString()  + " วัน" ,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: isAuthIndex != null && isAuthIndex > -1 ? Colors.green : Colors.grey.shade300,
              ),
            ),
          );
        },
        itemCount: state.myBranchesResponse!.length);
  }
}
