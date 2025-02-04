
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';
import '../../domain/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepo authRepo;
  UserModel? _currentUser;
  AuthCubit({required this.authRepo}):super(AuthInitialState());

  Future<void> login(String email,String password) async{
    emit(LoadingState());
    try{
      final user=await authRepo.login(email, password);
      if(user!=null){
        _currentUser=user;
        emit(AuthenticatedState(user));
      }
      else{
        emit(AuthErrorState("User not found"));
      }

    }catch(e){
      emit(AuthErrorState(e.toString()));

    }
  }

  Future<void> register(String name,String email,String password) async{
      emit(LoadingState());
      try{
       final user=await authRepo.register(name, email, password) ;
       _currentUser=user;
       if(user!=null){
         emit(AuthenticatedState(user));
       }
       else{
         emit(AuthErrorState('User not created'));
       }
     }catch(e){
        emit(AuthErrorState(e.toString()));
      }
  }

  //get currentUser
  UserModel? get currentUser=> _currentUser;

  Future<void> checkCurrentUser() async{
    emit(LoadingState());
    try{
      final UserModel? user=await authRepo.checkCurrentUser();
      if(user!=null){
        _currentUser=user;
        emit(AuthenticatedState(user));
      }else{
        emit(UnAuthenticatedState());
      }
    }
    catch(e){
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> logOut() async{
    try{
      await authRepo.logOut();
      emit(UnAuthenticatedState());
    }catch(e){
      emit(AuthErrorState(e.toString()));
      //throw Exception(e.toString());
    }
  }

}
