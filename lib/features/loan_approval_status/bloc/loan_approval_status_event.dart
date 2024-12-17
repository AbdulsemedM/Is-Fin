part of 'loan_approval_status_bloc.dart';

@immutable
sealed class LoanApprovalStatusEvent {}

final class FetchLoanApprovalStatusList extends LoanApprovalStatusEvent {
  FetchLoanApprovalStatusList();
}

final class OfferedProductsPriceFetch extends LoanApprovalStatusEvent {
  final String id;
  OfferedProductsPriceFetch({required this.id});
}

final class AcceptOffer extends LoanApprovalStatusEvent {
  final String id;
  final String status;
  final List<OfferedProductsPriceModel>? productList;
  AcceptOffer({required this.id, required this.status, this.productList});
}

final class FetchMurabahaAgreement extends LoanApprovalStatusEvent {
  final String id;
  FetchMurabahaAgreement({required this.id});
}

final class AcceptMurabahaOffer extends LoanApprovalStatusEvent {
  final String id;
  final String status;
  AcceptMurabahaOffer({required this.id, required this.status});
}

final class FetchMurabahaCard extends LoanApprovalStatusEvent {
  final String id;
  FetchMurabahaCard({required this.id});
}
