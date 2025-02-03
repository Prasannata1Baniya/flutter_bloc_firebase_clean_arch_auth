
import '../../data/model/user_model.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}

class LoadingState extends AuthState{}

class AuthenticatedState extends AuthState{
 final UserModel? userModel;
  AuthenticatedState(this.userModel);
}

class UnAuthenticatedState extends AuthState{}

class AuthErrorState extends AuthState{
  final String error;
  AuthErrorState(this.error);
}