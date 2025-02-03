
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc_firebase/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  //final bool isLogin;
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
   bool isLogin=true;
  void togglePage(){
    setState(() {
      isLogin=!isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginPage(onTap: togglePage,);
    }
    else {
      return RegisterPage(onTap: togglePage,);
    }
  }
}
