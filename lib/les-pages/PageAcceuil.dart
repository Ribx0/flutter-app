import 'package:flutter/material.dart';
import 'ListeActivite.dart';
import 'PageAjout.dart';
import 'PageProfile.dart';

class Accueil extends StatefulWidget {
  @override
  _PageAccueilState createState() => _PageAccueilState();
}

class _PageAccueilState extends State<Accueil> {
  int _indiceCourant = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activités'),
        backgroundColor: Color(0xFF5F6F52),
      ),
      body: _construireCorps(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceCourant,
        onTap: (index) {
          setState(() {
            _indiceCourant = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajouter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Color(0xFF5F6F52),
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFFFEFAE0),
      ),
    );
  }

  Widget _construireCorps() {
    if (_indiceCourant == 0) {
      return ListeActivites();
    } else if (_indiceCourant == 1) {
      return Ajout();
    } else {
      return Profile();
    }
  }
}
