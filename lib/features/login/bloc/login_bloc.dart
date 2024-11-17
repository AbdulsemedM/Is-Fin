import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/login/data/repository/login_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginFetched>(_userLogin);
  }
  void _userLogin(LoginFetched event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    // print("loading...");
    try {
      final signup =
          await loginRepository.sendLogin(event.phoneNumber, event.password);
      emit(LoginSuccess());
      print(signup);
    } catch (e) {
      emit(LoginFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }
}
