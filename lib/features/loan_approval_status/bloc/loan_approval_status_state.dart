part of 'loan_approval_status_bloc.dart';

@immutable
sealed class LoanApprovalStatusState {}

final class LoanApprovalStatusInitial extends LoanApprovalStatusState {}

final class LoanApprovalListFetchedLoading extends LoanApprovalStatusState {}

final class LoanApprovalListFetchedSuccess extends LoanApprovalStatusState {
  final List<StatusProductListModel> productList;

  LoanApprovalListFetchedSuccess({required this.productList});
}

final class LoanApprovalListFetchedFailure extends LoanApprovalStatusState {
  final String errorMessage;

  LoanApprovalListFetchedFailure(this.errorMessage);
}

final class OfferedProductsPriceFetchedLoading
    extends LoanApprovalStatusState {}

final class OfferedProductsPriceFetchedSuccess extends LoanApprovalStatusState {
  final List<OfferedProductsPriceModel> productList;

  OfferedProductsPriceFetchedSuccess({required this.productList});
}

final class OfferedProductsPriceFetchedFailure extends LoanApprovalStatusState {
  final String errorMessage;

  OfferedProductsPriceFetchedFailure(this.errorMessage);
}

final class AcceptOfferLoading extends LoanApprovalStatusState {}

final class AcceptOfferSuccess extends LoanApprovalStatusState {
  final String message;

  AcceptOfferSuccess(this.message);
}

final class AcceptOfferFailure extends LoanApprovalStatusState {
  final String errorMessage;

  AcceptOfferFailure(this.errorMessage);
}

final class FetchMurabahaAgreementLoading extends LoanApprovalStatusState {}

final class FetchMurabahaAgreementSuccess extends LoanApprovalStatusState {
  final MurabahaAgreementModel murabahaAgreement;

  FetchMurabahaAgreementSuccess(this.murabahaAgreement);
}

final class FetchMurabahaAgreementFailure extends LoanApprovalStatusState {
  final String errorMessage;

  FetchMurabahaAgreementFailure(this.errorMessage);
}

final class AcceptMurabahaOfferLoading extends LoanApprovalStatusState {}

final class AcceptMurabahaOfferSuccess extends LoanApprovalStatusState {
  final String message;

  AcceptMurabahaOfferSuccess(this.message);
}

final class AcceptMurabahaOfferFailure extends LoanApprovalStatusState {
  final String errorMessage;

  AcceptMurabahaOfferFailure(this.errorMessage);
}

final class FetchMurabahaCardLoading extends LoanApprovalStatusState {}

final class FetchMurabahaCardSuccess extends LoanApprovalStatusState {
  final MurabahaCardModel murabahaCard;

  FetchMurabahaCardSuccess(this.murabahaCard);
}

final class FetchMurabahaCardFailure extends LoanApprovalStatusState {
  final String errorMessage;

  FetchMurabahaCardFailure(this.errorMessage);
}
