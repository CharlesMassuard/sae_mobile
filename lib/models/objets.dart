class Objet {
  final int id;
  String nomObjet;
  String descriptionObjet;

  Objet({
    required this.id,
    required this.nomObjet,
    required this.descriptionObjet,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomObjet': nomObjet,
      'descriptionObjet': descriptionObjet,
    };
  }

  @override
  String toString() {
    return this.nomObjet;
  }
}