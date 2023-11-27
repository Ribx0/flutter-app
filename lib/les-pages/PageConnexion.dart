import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'PageAcceuil.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final TextEditingController controleurNomUtilisateur = TextEditingController();
  final TextEditingController controleurMotDePasse = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscureText = true;

  bool validateInputs() {
    if (controleurNomUtilisateur.text.isEmpty || controleurMotDePasse.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Veuillez remplir tous les champs',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  void seConnecter(BuildContext context) async {
    if (!validateInputs()) {
      return;
    }

    String nomUtilisateur = controleurNomUtilisateur.text;
    String motDePasse = controleurMotDePasse.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: nomUtilisateur,
        password: motDePasse,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
    } catch (e) {
      print('Erreur de connexion : $e');

      Fluttertoast.showToast(
        msg: 'Erreur de connexion : $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAE0),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Remplacez l'image actuelle par l'icône de connexion
            Icon(
              Icons.login,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: controleurNomUtilisateur,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: controleurMotDePasse,
              obscureText: _obscureText,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Ajoutez ici la logique pour la récupération de mot de passe
              },
              child: Text(
                'Mot de passe oublié?',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => seConnecter(context),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF5F6F52),
                padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              child: Text(
                'Se Connecter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
