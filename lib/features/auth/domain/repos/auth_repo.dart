
import '../../data/model/user_model.dart';

abstract class AuthRepo{
  //FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  //FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<UserModel?> login(String email,String password);
  Future<UserModel?> register(String name,String email,String password);
  Future<UserModel?> checkCurrentUser();
  Future<void> logOut();

}