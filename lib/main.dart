import 'package:desafio_cloud_firestore/service/auth/auth_gate.dart';
import 'package:desafio_cloud_firestore/service/auth/auth_service.dart';
import 'package:desafio_cloud_firestore/service/chat/chat_service.dart';
import 'package:desafio_cloud_firestore/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(
  MultiProvider(providers: [
ChangeNotifierProvider(
    create: (context)=> ThemeProvider()),
ChangeNotifierProvider(
    create: (context)=> AuthService()),
ChangeNotifierProvider(
    create: (context)=> ChatService())
  ], 
  child: const MyApp(),)
  
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
