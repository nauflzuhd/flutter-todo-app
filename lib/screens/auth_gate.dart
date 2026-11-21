import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';
import 'sign_in_screen.dart';
import 'todo_screen.dart';


class AuthGate extends StatelessWidget{
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return StreamBuilder<User?> (
      stream: auth.authStateChanges,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text('Gagal memuat status login'),
            ),
          );
        } else if(snapshot.hasData){
          return TodoScreen();
        } else{
          return const SignInScreen();
        }
      },
    );
  }
}