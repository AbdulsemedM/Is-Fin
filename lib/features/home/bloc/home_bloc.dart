import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/home/data/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<FetcheCreditScore>(_onFetchCreditScore);
  }
  Future<void> _onFetchCreditScore(
      FetcheCreditScore event, Emitter<HomeState> emit) async {
    emit(CreditScoreFetchedLoading());
    try {
      final score = await homeRepository.fetchCreditScore();
      emit(CreditScoreFetchedSuccess(score: score));
    } catch (e) {
      emit(CreditScoreFetchedFailure(errorMessage: e.toString()));
    }
  }
}
