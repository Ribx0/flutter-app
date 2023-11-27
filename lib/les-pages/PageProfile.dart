import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'PageConnexion.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color(0xFF5F6F52),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              void _signOut(BuildContext context) {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Connexion()),
                );
              }

              _signOut(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              // Afficher la photo de profil si disponible
              if (user.photoURL != null && user.photoURL!.isNotEmpty)
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
              SizedBox(height: 16),
              // Afficher le nom de l'utilisateur avec un style différent
              Text(
                'Nom: ${user.displayName ?? 'N/A'}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5F6F52)),
              ),
              SizedBox(height: 8),
              // Afficher l'email de l'utilisateur avec un style différent
              Text(
                'Email: ${user.email ?? 'N/A'}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ] else
              Text('Utilisateur non connecté', style: TextStyle(fontSize: 18, color: Color(0xFF5F6F52))),
          ],
        ),
      ),
    );
  }
}
