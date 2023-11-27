class Activite {
  final String titre;
  final String lieu;
  final double prix;
  final String imageUrl;
  final String categorie;
  final int participantsMinimum;

  Activite({
    required this.titre,
    required this.lieu,
    required this.prix,
    required this.imageUrl,
    required this.categorie,
    required this.participantsMinimum,
  });
}
