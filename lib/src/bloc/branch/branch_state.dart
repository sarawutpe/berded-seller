part of 'branch_bloc.dart';

class BranchState extends Equatable {
  final bool isFetching;
  final bool isSuccess;
  final bool isError;
  final bool isSwitchBranch;
  final List<MyBranchesResponse>? myBranchesResponse;
  final MyBranchesResponse? selectedBranch;
  final String? sellerId;
  final List<AuthorizedBranch>? authorizedBranches;

  const BranchState({
    this.isFetching = false,
    this.isSuccess = false,
    this.isError = false,
    this.isSwitchBranch = false,
    this.myBranchesResponse = const [],
    this.selectedBranch,
    this.sellerId,
    this.authorizedBranches,
  });

  BranchState copyWith({
    bool? isFetching,
    bool? isSuccess,
    bool? isError,
    bool? isSwitchBranch,
    List<MyBranchesResponse>? myBranchesResponse,
    MyBranchesResponse? selectedBranch,
    String? sellerId,
    List<AuthorizedBranch>? authorizedBranches,
  }) {
    return BranchState(
      isFetching: isFetching ?? this.isFetching,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isSwitchBranch: isSwitchBranch ?? this.isSwitchBranch,
      myBranchesResponse: myBranchesResponse ?? this.myBranchesResponse,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      sellerId: sellerId ?? this.sellerId,
      authorizedBranches: authorizedBranches ?? this.authorizedBranches,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "isFetching: $isFetching, isSuccess: $isSuccess, isError: $isError, result: $myBranchesResponse, selectedBranch: $selectedBranch, authorizedBranches: $authorizedBranches";
  }

  @override
  List<Object?> get props => [
        isFetching,
        isSuccess,
        isError,
        isSwitchBranch,
        selectedBranch,
        sellerId,
        authorizedBranches,
      ];
}
