part of 'branch_bloc.dart';

class BranchEvent extends Equatable {
  const BranchEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// Reset
class BranchEventReInitial extends BranchEvent {
  BranchEventReInitial();
}

// Fetch branch event
class BranchEventFetchMyBranches extends BranchEvent {
  BranchEventFetchMyBranches();
}

class BranchEventSetAuthorizedBranches extends BranchEvent {
  final List<AuthorizedBranch> authorizedBranches;
  BranchEventSetAuthorizedBranches({ required this.authorizedBranches});
}

// Fetch branch event
class BranchEventRefreshMyBranch extends BranchEvent {
  final StreamController? streamController;

  BranchEventRefreshMyBranch({this.streamController});
}

class BranchEventSaveAsAuthorized extends BranchEvent {
  final String seller_id;
  final String token;
  final String username;

  BranchEventSaveAsAuthorized({required this.seller_id, required this.token, required this.username});
}

// Select branch event
class BranchEventSelect extends BranchEvent {
  final MyBranchesResponse selectedBranch;
  BranchEventSelect(this.selectedBranch);
}
