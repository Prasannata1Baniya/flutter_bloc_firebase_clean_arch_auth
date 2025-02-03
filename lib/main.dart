import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/repos-impl/auth_repo_impl.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth_state.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/auth/presentation/pages/home_page.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final AuthRepoImpl authRepo=AuthRepoImpl(FirebaseAuth.instance, FirebaseFirestore.instance);

  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>AuthCubit(authRepo: authRepo)..checkCurrentUser()),
        ], child: const MyApp(),
    ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return const HomePage();
            }
            if (state is UnAuthenticatedState) {
              return const AuthPage();
            }
            else {
              return const Scaffold(
                  body: CircularProgressIndicator()
              );
            }
          },
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)));
            }
          }
      ),
    );







      /*MaterialApp(
      debugShowCheckedModeBanner: false,
     home:  BlocConsumer<AuthCubit,AuthState>(
         builder: (context,state){
           if(state is LoadingState){
             return const Center(child: CircularProgressIndicator());
           }
           if(state is AuthenticatedState){
             return const HomePage();
           }
           if(state is UnAuthenticatedState){
             //return const AuthPage(isLogin: true);
             return const AuthPage();

           }
           else{
             return const Center(child:Text("Failed"));
           }
         },
         listener: (context,state){
           if(state is AuthErrorState){
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(state.error)));
           }
         }),
    );*/
  }
}
