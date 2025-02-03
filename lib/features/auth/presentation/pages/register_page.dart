
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc_firebase/features/auth/presentation/pages/auth_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/my_text_field.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

   const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   late TextEditingController nameController=TextEditingController();

  late TextEditingController emailController=TextEditingController();

  late TextEditingController passwordController=TextEditingController();
   @override
   void initState() {
     super.initState();
     nameController = TextEditingController();
     emailController = TextEditingController();
     passwordController = TextEditingController();
   }

   @override
   void dispose() {
     nameController.dispose();
     emailController.dispose();
     passwordController.dispose();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Icon(Icons.login),
              const SizedBox(height:30),
              MyTextField(controller: nameController,
                  obscureText: false, hText: 'name'),
              const SizedBox(height:15),
              MyTextField(controller: emailController , obscureText: false, hText: 'email',),
              const SizedBox(height:15),
              MyTextField(controller: passwordController,
                  obscureText: true, hText: 'password'),
              const SizedBox(height:30),
          GestureDetector(
            onTap: (){
              context.read<AuthCubit>().register(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
              /*ElevatedButton(
                  onPressed: (){
                    context.read<AuthCubit>().login(
                        emailController.text.trim(),
                        passwordController.text.trim());
                  },
                  child: const Text("Login")),*/
              const SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member"),
                  const SizedBox(width:20),
                  GestureDetector(
                      onTap: widget.onTap,
                      /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthPage(isLogin: true)),
                  );*/
                      child:const Text("Login",style: TextStyle(color:Colors.blue),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
