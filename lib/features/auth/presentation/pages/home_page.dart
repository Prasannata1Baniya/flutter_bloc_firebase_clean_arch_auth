

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read<AuthCubit>().checkCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page",style: TextStyle(color: Colors.white,fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            context.read<AuthCubit>().logOut();
          }, icon: const Icon(Icons.logout,color: Colors.white,size:25)),
        ],
      ),
      body: BlocBuilder<AuthCubit,AuthState>(
          builder: (context,state){
            if(state is LoadingState){
             return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is AuthenticatedState){
             // final profile=context.read<AuthCubit>().currentUser;
              final profile =state.userModel;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 100,
                        backgroundColor: Colors.blueAccent,
                        child:  Icon(Icons.person,size: 150,
                        color: Colors.white,
                        ),
                    ),
                    const SizedBox(height:30),

                    //Profile Info
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Text("Your Name:",
                                style:TextStyle(fontSize: 35,fontWeight:FontWeight.bold)
                            ),
                            Text(profile?.name ??'No name available',
                                style:const TextStyle(fontSize: 30,fontWeight:FontWeight.normal)
                            ),
                            const SizedBox(height:15),
                            const Text("Your Email:",
                                style: TextStyle(fontSize: 35,fontWeight:FontWeight.bold)
                            ),
                            Text(profile?.email ?? 'No name available',
                                style:const TextStyle(fontSize: 30,fontWeight:FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else if (state is AuthErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                "User not found",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
      },
      ),
    );
  }
}
