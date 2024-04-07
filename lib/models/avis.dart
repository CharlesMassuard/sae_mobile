import 'dart:ffi';

class AvisPersonne{
  String id;
  String userWriter;
  String userReviewed;
  Bool done;
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
  String id;
  String idObjetReview;
  String nomObjet;
  String userWriter;
  Bool done;
  String avis;

  AvisObjet({required this.id, required this.idObjetReview, required this.nomObjet, required this.userWriter, required this.done, required this.avis});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idObjetReview': idObjetReview,
      'nomObjet': nomObjet,
      'userWriter': userWriter,
      'done': done,
      'avis': avis,
    };
  }
}