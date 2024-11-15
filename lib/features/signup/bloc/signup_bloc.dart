import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/signup/data/repository/signup_repository.dart';
import 'package:ifb_loan/features/signup/models/signup_model.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;
  SignupBloc(this.signupRepository) : super(SignupInitial()) {
    on<SignupSent>(_userSignUp);
  }
  void _userSignUp(SignupSent event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    print("loading...");
    try {
      final signup = await signupRepository.sendSignup(
        event.fullName,
        event.phoneNumber,
        event.password,
        event.email,
      );
      emit(SignupSuccess(signupModel: signup));
      print(signup);
    } catch (e) {
      emit(SignupFailure(e.toString()));
      print("failure...");
      print(e.toString());
    }
  }
}
