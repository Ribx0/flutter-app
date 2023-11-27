import 'package:flutter/material.dart';
import 'Activite.dart';

class PageDeDetail extends StatelessWidget {
  final Activite activite;

  PageDeDetail({required this.activite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'activité'),
        backgroundColor: Color(0xFF5F6F52),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFEFAE0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Image.network(
                activite.imageUrl,
                fit: BoxFit.cover,
                height: 300.0,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activite.titre,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5F6F52),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Catégorie : ${activite.categorie}', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.0),
                  Text('Lieu : ${activite.lieu}', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.0),
                  Text('Participants minimum : ${activite.participantsMinimum}', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.0),
                  Text('Prix : ${activite.prix} Mad', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
