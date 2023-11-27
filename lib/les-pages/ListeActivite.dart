import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Activite.dart';
import 'ActivitePageDeDetail.dart';

class ListeActivites extends StatefulWidget {
  const ListeActivites({Key? key}) : super(key: key);

  @override
  State<ListeActivites> createState() => _ListeActivitesState();
}

class _ListeActivitesState extends State<ListeActivites> {
  late List<String> categories;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('activites').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        categories = ['Toutes'];
        categories.addAll(Set<String>.from(snapshot.data!.docs.map((doc) => doc['categorie'] as String)));

        return _construireBarreOngletsCategories(snapshot.data!.docs);
      },
    );
  }

  Widget _construireBarreOngletsCategories(List<QueryDocumentSnapshot<Object?>> documents) {
    return DefaultTabController(
      length: categories.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              isScrollable: true,
              labelColor: Color(0xFF5F6F52),
              unselectedLabelColor: Colors.grey,
              tabs: _construireOngletsBarre(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: _construireVuesBarreOnglets(documents),
            ),
          ),
        ],
      ),
    );
  }

  List<Tab> _construireOngletsBarre() {
    return categories.map((String categorie) {
      return Tab(
        text: categorie,
      );
    }).toList();
  }

  List<Widget> _construireVuesBarreOnglets(List<QueryDocumentSnapshot<Object?>> documents) {
    return categories.map((String categorie) {
      List<Activite> activitesFiltrees = documents
          .where((doc) => categorie == 'Toutes' ? true : doc['categorie'] == categorie)
          .map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Activite(
          titre: data['titre'],
          lieu: data['lieu'],
          prix: data['prix'].toDouble(),
          imageUrl: data['imageUrl'],
          categorie: data['categorie'],
          participantsMinimum: data['participantsMinimum'],
        );
      }).toList();

      Widget _construireImageActivite(String? imageUrl) {
        if (imageUrl != null && imageUrl.isNotEmpty) {
          return Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          );
        } else {
          return Icon(Icons.image, size: 60);
        }
      }

      return ListView.builder(
        itemCount: activitesFiltrees.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Color(0xFFFEFAE0),
            child: ListTile(
              leading: _construireImageActivite(activitesFiltrees[index].imageUrl),
              title: Text(
                activitesFiltrees[index].titre,
                style: TextStyle(
                  color: Color(0xFF5F6F52),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${activitesFiltrees[index].lieu} - ${activitesFiltrees[index].prix} Mad',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PageDeDetail(activite: activitesFiltrees[index]),
                  ),
                );
              },
            ),
          );
        },
      );
    }).toList();
  }
}
