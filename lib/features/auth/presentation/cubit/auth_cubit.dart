
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';
import '../../domain/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepo _authRepo;
  UserModel? _currentUser;
  AuthCubit(this._authRepo):super(AuthInitialState());

  Future<void> login(String email,String password) async{
    emit(LoadingState());
    try{
      final user=await _authRepo.login(email, password);
      if(user!=null){
        emit(AuthenticatedState(user));
      }
      else{
        emit(AuthErrorState("User not found"));
      }

    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> register(String name,String email,String password) async{
      emit(LoadingState());
      try{
       final user=await _authRepo.register(name, email, password) ;
       if(user!=null){
         emit(AuthenticatedState(user));
       }
       else{
         emit(AuthErrorState('User not created'));
       }
     }catch(e){
        throw Exception(e.toString());
     }
  }

  //get currentUser
  UserModel? get currentUser=> _currentUser;

  Future<void> checkCurrentUser() async{
    try{
      final UserModel? user=await _authRepo.checkCurrentUser();
      if(user!=null){
        _currentUser=user;
        emit(AuthenticatedState(user));
      }else{
        emit(UnAuthenticatedState());
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async{
    try{
      await _authRepo.logOut();

    }catch(e){
      throw Exception(e.toString());
    }
  }

}
