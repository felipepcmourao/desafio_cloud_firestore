import 'package:desafio_cloud_firestore/service/auth/auth_service.dart';
import 'package:desafio_cloud_firestore/components/my_button.dart';
import 'package:desafio_cloud_firestore/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  // EMAIL AND PASSWORD CONTROLLER
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // TAP TO GO TO REGISTER PAGE
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // LOGIN METHOD
  void login (BuildContext context){
    // auth service
    final authService = AuthService();

    // try login
    try {
      authService.signInWithEmailPassword(
      _emailController.text.trim(), 
      _pwController.text.trim());
    }

    // catch any errors
    catch (e) {
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // LOGO
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary),

          const SizedBox(height: 50),
        
          // WELCOME MESSAGE
          Text(
            "Welcome back!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),),
        
          const SizedBox(height: 25),

          // EMAIL TEXTFIELD
          MyTextfield(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(height: 10),

          // PW TEXTFIELD
          MyTextfield(
          hintText: "Password",
          obscureText: true,
          controller: _pwController,
        ),
        
          const SizedBox(height: 25),

          // BUTTON
          MyButton(
            text: 'Login',
            onTap: () => login(context)),

          const SizedBox(height: 25),

          // REGISTER NOW
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member? ", 
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),),
              GestureDetector(
                onTap: onTap,
                child: Text("Register now", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),),
              ),
            ],
          )
        ],),
      ),
    );
  }
}
