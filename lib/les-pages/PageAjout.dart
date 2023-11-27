import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class Ajout extends StatefulWidget {
  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  final TextEditingController controleurTitre = TextEditingController();
  final TextEditingController controleurLieu = TextEditingController();
  final TextEditingController controleurPrix = TextEditingController();
  final TextEditingController controleurUrlImage = TextEditingController();
  final TextEditingController controleurCategorie = TextEditingController();
  final TextEditingController controleurParticipantsMinimum = TextEditingController();

  BuildContext? get contexte => null;

  String _predictedCategory = '';

  Future<void> classifyImage(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.3.87:5000/classify'),
        body: jsonEncode({'image_url': imageUrl}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final predictedCategory = json['class'];
        setState(() {
          _predictedCategory = predictedCategory;
          controleurCategorie.text = _predictedCategory;
        });
      } else {
        print('Error classifying image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error classifying image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Activité'),
        backgroundColor: Color(0xFF5F6F52),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextField(controleurTitre, 'Titre', Icons.title),
            buildTextField(controleurLieu, 'Lieu', Icons.location_on),
            buildTextField(controleurPrix, 'Prix (en \Mad)', Icons.attach_money),
            buildTextField(controleurUrlImage, 'URL de l\'image', Icons.image),
            buildTextField(controleurCategorie, 'Catégorie', Icons.category, enabled: false),
            buildTextField(
              controleurParticipantsMinimum,
              'Participants Minimum',
              Icons.group,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                enregistrerActivite();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFA9B388),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Enregistrer l\'activité',
                style: TextStyle(fontSize: 18.0, color: Color(0xFFFEFAE0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller,
      String label,
      IconData icon, {
        TextInputType keyboardType = TextInputType.text,
        bool enabled = true,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Entrez $label',
          prefixIcon: Icon(icon, color: Color(0xFF5F6F52)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Color(0xFFFEFAE0),
        ),
        enabled: enabled,
      ),
    );
  }

  void enregistrerActivite() async {
    await classifyImage(controleurUrlImage.text);

    await FirebaseFirestore.instance.collection('activites').add({
      'titre': controleurTitre.text,
      'lieu': controleurLieu.text,
      'prix': double.parse(controleurPrix.text),
      'imageUrl': controleurUrlImage.text,
      'categorie': _predictedCategory,
      'participantsMinimum': int.parse(controleurParticipantsMinimum.text),
    });

    controleurTitre.clear();
    controleurLieu.clear();
    controleurPrix.clear();
    controleurUrlImage.clear();
    controleurCategorie.clear();
    controleurParticipantsMinimum.clear();

    ScaffoldMessenger.of(contexte!).showSnackBar(
      SnackBar(
        content: Text('Activité ajoutée avec succès !'),
        backgroundColor: Color(0xFFB99470),
      ),
    );
  }
}
