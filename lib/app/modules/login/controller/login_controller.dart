import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtimer/app/services/auth/auth_sersvice.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthSersvice _authSersvice;
  LoginController({required AuthSersvice authSersvice})
      : _authSersvice = authSersvice,
        super(const LoginState.initial());

  Future<void> signIn() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authSersvice.signIn();
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: 'Erro ao realizar login'));
    }
  }
}
