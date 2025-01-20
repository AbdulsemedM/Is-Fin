import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/dashborad/data/data_provider/dashboard_data_provider.dart';
import 'package:ifb_loan/features/dashborad/data/repository/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<SendFcmTokenEvent>((event, emit) async {
      emit(DashboardLoading());
      try {
        final repository = DashboardRepository(DashboardDataProvider());
        final result = await repository.sendFcmToken(event.fcmToken);
        emit(DashboardSuccess(result));
      } catch (e) {
        emit(DashboardFailure(e.toString()));
      }
    });
  }
}
