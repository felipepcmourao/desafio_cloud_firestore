import 'package:desafio_cloud_firestore/service/auth/auth_service.dart';
import 'package:desafio_cloud_firestore/components/my_button.dart';
import 'package:desafio_cloud_firestore/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  // EMAIL AND PASSWORD CONTROLLER
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // TAP TO GO TO LOGIN PAGEflut
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // REGISTER METHOD

  void register (BuildContext context){
    //get auth service
    final auth = AuthService();

    //compare password and confirm password
    if (_pwController.text.trim() == _confirmPwController.text.trim()) {

      //password match
      try {
         auth.signUpWithEmailPassword(_emailController.text.trim(), _pwController.text.trim());
      } catch (e) {
         showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
      ));
      }
    }

    //passwords don't match
    else {
       showDialog(context: context, builder: (context)=> const AlertDialog(
        title: Text("Passwords don't match"),
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
        
          // CREATE ACCOUNT MESSAGE
          Text(
            "Create your new account",
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
        
          const SizedBox(height: 10),

          // CONFIRM PW TEXTFIELD
          MyTextfield(
          hintText: "Confirm password",
          obscureText: true,
          controller: _confirmPwController,
        ),
        
          const SizedBox(height: 25),

          // BUTTON
          MyButton(
            text: 'Register',
            onTap: () => register(context)),

          const SizedBox(height: 25),

          // LOGIN NOW
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ", 
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),),
              GestureDetector(
                onTap: onTap,
                child: Text("Login now", 
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
