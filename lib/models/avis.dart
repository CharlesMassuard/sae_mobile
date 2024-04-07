class AvisPersonne{
  int id;
  String userWriter;
  String userReviewed;
  bool done;
  String avis;

  AvisPersonne({required this.id, required this.userWriter, required this.userReviewed, required this.done, required this.avis});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userWriter': userWriter,
      'userReviewed': userReviewed,
      'done': done,
      'avis': avis,
    };
  }
}

class AvisObjet{
  int id;
  int idObjetReview;
  String nomObjet;
  String usernameOwner;
  String userWriter;
  bool done;
  String avis;

  AvisObjet({required this.id, required this.idObjetReview, required this.nomObjet, required this.usernameOwner, required this.userWriter, required this.done, required this.avis});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idObjetReview': idObjetReview,
      'nomObjet': nomObjet,
      'usernameOwner': usernameOwner,
      'userWriter': userWriter,
      'done': done,
      'avis': avis,
    };
  }
}