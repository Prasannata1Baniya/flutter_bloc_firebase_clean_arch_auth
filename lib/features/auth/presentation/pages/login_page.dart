
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc_firebase/features/auth/presentation/pages/auth_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/my_text_field.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
   LoginPage({super.key, required this.onTap});

  final TextEditingController emailController=TextEditingController();
   final TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page",
          style: TextStyle(color: Colors.white,fontSize: 30),),
        backgroundColor: Colors.black,
      ),
      body:BlocListener<AuthCubit,AuthState>(
        listener: (context,state){
        if(state is AuthenticatedState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
        }else if(state is AuthErrorState){
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(state.error))
           );
        }
      },
        child: Column(
          children: [
            const Icon(Icons.login),
           MyTextField(controller: emailController , obscureText: false, hText: 'email',),
            MyTextField(controller: passwordController,
                obscureText: true, hText: 'password'),
            ElevatedButton(
                onPressed: (){
              context.read<AuthCubit>().login(
                  emailController.text.trim(),
                  passwordController.text.trim());
            },
                child: const Text("Login")
            ),
            Row(
              children: [
                const Text("Not a member"),
                GestureDetector(
                    onTap: onTap,
                    /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage(isLogin: false)),
                );*/
                    child:const  Text("Register")
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
