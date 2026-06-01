import 'package:desafio_cloud_firestore/service/auth/auth_service.dart';
import 'package:desafio_cloud_firestore/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // LOG OUT FUNCTION
  void logout (){
    // auth services
    final auth = AuthService();

    // sign out
    auth.signOut();
  }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(children: [
          // LOGO
        DrawerHeader(
          child: Center(
            child: Icon(
              Icons.chat, 
              color: Theme.of(context).colorScheme.primary,
              size: 40,
              ),
          )
          ),

        // HOME LIST TILE
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            title: const Text("H O M E"),
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),

        // SETTING LIST TILE
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            title: const Text("S E T T I N G S"),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,),
            onTap: () {
              Navigator.pop(context);

              // navigate to settings page
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (builder) => const SettingsPage(),
                  )
                  );

            },
          ),
        ),
        ],),

        // LOGOUT LIST TILE
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            title: const Text("L O G O U T"),
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,),
            onTap: logout,
          ),
        )

      ],),
    );
  }
}
