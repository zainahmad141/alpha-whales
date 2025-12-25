import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../app_exports.dart';
import '../data/auth_service.dart';
import '../data/model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationProvider authenticationProvider;

  LoginBloc({
    AuthenticationProvider? authenticationProvider,
  }) : authenticationProvider = authenticationProvider ?? AuthenticationProvider(), super(LoginInitial()) {
    on<LoginButtonPressed>(_handleLogin);
    on<SignUpButtonPressed>(_handleSignUp);
    on<AuthStarted>(_handleAuthStarted);
    on<VerifyEmailButtonPressed>(_handleVerifyEmail);
    on<LoginSuccessEvent>(_handleSuccess);
  }

  Future<void> _handleSuccess(
      LoginSuccessEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());
      DocumentSnapshot userDoc = await DatabaseService().getCurrentUserData();
      emit(LoginSuccess(
          user: UserModel.fromFirestore(
              userDoc.data() as Map<String, dynamic>)));
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  _handleVerifyEmail(
      VerifyEmailButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());
      await FirebaseAuth.instance.currentUser?.reload();
      final isEmailVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
      DocumentSnapshot userDoc = await DatabaseService().getCurrentUserData();
      if (isEmailVerified) {
        emit(LoginSuccess(
            user: UserModel.fromFirestore(
                userDoc.data() as Map<String, dynamic>)));
      } else {
        emit(const LoginVerification(
            error: 'Please verify your email before proceeding.'));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  Future<void> _handleAuthStarted(
      AuthStarted event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        if (!currentUser.emailVerified) {
          emit(const LoginVerification(error: 'Please verify your email before proceeding.'));
        } else {
          DocumentSnapshot userDoc =
          await DatabaseService().getCurrentUserData();
          emit(LoginSuccess(
              user: UserModel.fromFirestore(
                  userDoc.data() as Map<String, dynamic>)));
        }
      } else {
        await Future.delayed(
          const Duration(seconds: 2),
        );
        emit(const LoginFailure());
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  Future<void> _handleLogin(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());

    try {
      UserCredential? authUser = await authenticationProvider
          .signIn(UserModel(email: event.username, password: event.password));
      if (authUser?.user != null) {
        if (!authUser!.user!.emailVerified) {
          authenticationProvider.verifyEmail();
          emit(const LoginVerification());
        } else {
          DocumentSnapshot userDoc =
              await DatabaseService().getCurrentUserData();
          emit(LoginSuccess(
              user: UserModel.fromFirestore(
                  userDoc.data() as Map<String, dynamic>)));
        }
      } else {
        emit(const LoginFailure(error: 'Invalid credentials'));
      }
    } on FirebaseAuthException catch (error) {
      emit(LoginFailure(error: error.message.toString()));
    }on Exception catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  Future<void> _handleSignUp(
      SignUpButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());
      final authUser =
          await authenticationProvider.signUp(event.user);
      if (authUser?.user != null) {
        authenticationProvider.verifyEmail();
        emit(SignUpSuccess());
      }
    } on FirebaseAuthException catch (error) {
      emit(SignUpFailure(error: error.message.toString()));
    } catch (error) {
      emit(SignUpFailure(error: error.toString()));
    }
  }
}
