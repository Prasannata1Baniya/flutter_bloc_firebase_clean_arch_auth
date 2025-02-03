import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase/features/auth/data/repos-impl/auth_repo_impl.dart';
import 'package:flutter_bloc_firebase/features/auth/presentation/cubit/auth_cubit.dart';
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
          BlocProvider(create: (_)=>AuthCubit(authRepo)),
        ], child: const MyApp()
    ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
     // home: const MyHomePage(),
    );
  }
}
