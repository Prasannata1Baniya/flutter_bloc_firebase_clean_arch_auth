

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().checkCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(onPressed: (){
            context.read<AuthCubit>().logOut();
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      body: BlocBuilder<AuthCubit,AuthState>(
          builder: (context,state){
            if(state is LoadingState){
             return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is AuthenticatedState){
              final profile=context.read<AuthCubit>().currentUser;
              return Column(
                children: [
                  const Icon(Icons.person),
                  const Text("Your Name:"),
                  Text(profile?.name ??'No name available'),
                  const Text("Your Email:"),
                  Text(profile?.email ?? 'No name available'),
                ],
              );
            }else if(state is AuthErrorState){
              return Text(state.error);
            }
            return const Text("User not found");
      },
      ),
    );
  }
}
