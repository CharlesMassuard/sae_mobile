class MesObjets {
  final int id;
  String nomObjet;
  String descriptionObjet;

  MesObjets({
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
}