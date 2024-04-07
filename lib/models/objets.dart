class Objet {
  final int id;
  String nomObjet;
  String descriptionObjet;
  String usernameOwner;

  Objet({
    required this.id,
    required this.nomObjet,
    required this.descriptionObjet,
    required this.usernameOwner,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomObjet': nomObjet,
      'descriptionObjet': descriptionObjet,
      'usernameOwner': usernameOwner,
    };
  }

  @override
  String toString() {
    return this.nomObjet;
  }
}