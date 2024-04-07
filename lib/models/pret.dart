import 'package:sae_mobile/models/annoncesModel.dart';
import 'package:sae_mobile/models/objets.dart';

class Pret {
  final int id;
  bool enCours;
  final Announcement annonce;
  final Objet objet;

  Pret({
    required this.id,
    required this.annonce,
    required this.objet,
    required this.enCours,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enCours': enCours,
      'annonce': annonce,
      'objet': objet,
    };
  }
}