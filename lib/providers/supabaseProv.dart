import 'package:flutter/foundation.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

import '../models/avis.dart';
import '../models/objets.dart';
import '../models/annoncesModel.dart';
import '../models/pret.dart';

class supabaseProvider with ChangeNotifier {
  List<Announcement> _announcements = [];
  List<Objet> _objets = [];
  final SupabaseService _supabaseService;

  supabaseProvider(this._supabaseService);

  List<Announcement> get announcements => _announcements;

  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      final res = await _supabaseService.client.from('Annonces').select('idAnn, titreAnn, descAnn, username, statusAnn, date').or('statusAnn.eq.posted,statusAnn.eq.answered').order('idAnn', ascending: false);
      _announcements = res.map((item) {
        return Announcement(
          id: item['idAnn'],
          title: item['titreAnn'],
          description: item['descAnn'],
          username: item['username'],
          status: item['statusAnn'],
          date: item['date'],
        );
      }).toList();
      notifyListeners();
      return _announcements;
    } catch (e) {
      throw Exception('An error occurred while fetching announcements: $e');
    }
  }

  Future<Announcement> fetchAnnouncement(int id) async {
    try {
      final res = await _supabaseService.client.from('Annonces').select('idAnn, titreAnn, descAnn, username, statusAnn, date').eq('idAnn', id).single();
      return Announcement(
        id: res['idAnn'],
        title: res['titreAnn'],
        description: res['descAnn'],
        username: res['username'],
        status: res['statusAnn'],
        date: res['date'],
      );
    } catch (e) {
      throw Exception('An error occurred while fetching announcement: $e');
    }
  }

  Future<List<Announcement>> fetchMyAnnouncements() async {
    try {
      final username = await _supabaseService.getUsernameFromEmail();
      if (username == null) {
        throw Exception('Vous n\'êtes pas connecté.');
      }
      final res = await _supabaseService.client.from('Annonces').select('idAnn, titreAnn, descAnn, username, statusAnn, date').eq('username', username).or('statusAnn.eq.posted,statusAnn.eq.answered').order('idAnn', ascending: false);
      _announcements = res.map((item) {
        return Announcement(
          id: item['idAnn'],
          title: item['titreAnn'],
          description: item['descAnn'],
          username: item['username'],
          status: item['statusAnn'],
          date: item['date'],
        );
      }).toList();
      notifyListeners();
      print (_announcements);
      return _announcements;
    } catch (e) {
      throw Exception('An error occurred while fetching announcements: $e');
    }
  }

  Future<List<Objet>> fetchObjetAnnonce(int id) async {
    try {
      final res = await _supabaseService.client.from('ReponseAnnonce')
          .select('Objets: idObjetRep (*)')
          .eq('idAnnRep', id);

      return res.map((item) {
        final objet = item['Objets'];
        return Objet(
          id: objet['idObjet'],
          nomObjet: objet['nomObjet'],
          descriptionObjet: objet['descriptionObjet'],
          usernameOwner: objet['usernameOwner'],
        );
      }).toList();
    } catch (e) {
      throw Exception('An error occurred while fetching object: $e');
    }
  }

  Future<List<Pret?>?> fetchEmprunts() async {
    try {
      final username = await _supabaseService.getUsernameFromEmail();
      if (username == null) {
        throw Exception('Vous n\'êtes pas connecté.');
      }
      final res = await _supabaseService.client.from('Pret')
          .select('id, Annonces: idAnnPret (*), Objets: idObjPret (*), enCours')
          .eq('Annonces.username', username)
          .eq('enCours', true);
      if(res.isEmpty) {
        return null;
      }
      var prets = res.map((item) {
        final annonce = item['Annonces'];
        final objet = item['Objets'];

        if (annonce == null || objet == null) {
          return null;
        }

        return Pret(
          id: item['id'],
          enCours: item['enCours'],
          annonce: Announcement(
            id: annonce['idAnn'],
            title: annonce['titreAnn'],
            description: annonce['descAnn'],
            username: annonce['username'],
            status: annonce['statusAnn'],
            date: annonce['date'],
          ),
          objet: Objet(
            id: objet['idObjet'],
            nomObjet: objet['nomObjet'],
            descriptionObjet: objet['descriptionObjet'],
            usernameOwner: objet['usernameOwner'],
          ),
        );
      }).toList();

      // If all values are null, return null
      if (prets.every((item) => item == null)) {
        return null;
      }

      // Filter out null values
      prets.removeWhere((item) => item == null);

      return prets;
    } catch (e) {
      throw Exception('An error occurred while fetching prets: $e');
    }
  }

  Future<List<Pret?>?> fetchPrets() async {
    try {
      final username = await _supabaseService.getUsernameFromEmail();
      if (username == null) {
        throw Exception('Vous n\'êtes pas connecté.');
      }
      final res = await _supabaseService.client.from('Pret')
          .select('id, Annonces: idAnnPret (*), Objets: idObjPret (*), enCours')
          .eq('Objets.usernameOwner', username)
          .eq('enCours', true);
      if(res.isEmpty) {
        return null;
      }
      var prets = res.map((item) {
        final annonce = item['Annonces'];
        final objet = item['Objets'];

        if (annonce == null || objet == null) {
          return null;
        }

        return Pret(
          id: item['id'],
          enCours: item['enCours'],
          annonce: Announcement(
            id: annonce['idAnn'],
            title: annonce['titreAnn'],
            description: annonce['descAnn'],
            username: annonce['username'],
            status: annonce['statusAnn'],
            date: annonce['date'],
          ),
          objet: Objet(
            id: objet['idObjet'],
            nomObjet: objet['nomObjet'],
            descriptionObjet: objet['descriptionObjet'],
            usernameOwner: objet['usernameOwner'],
          ),
        );
      }).toList();

      // If all values are null, return null
      if (prets.every((item) => item == null)) {
        return null;
      }

      // Filter out null values
      prets.removeWhere((item) => item == null);

      return prets;
    } catch (e) {
      throw Exception('An error occurred while fetching prets: $e');
    }
  }

  Future<List<AvisPersonne>> fetchAvisPersonne(String username) async {
    try {
      final res = await _supabaseService.client.from('AvisUtilisateur')
          .select('id, userWriter, userReviewed, done, avis')
          .eq('userReviewed', username);
      return res.map((item) {
        return AvisPersonne(
          id: item['id'],
          userWriter: item['userWriter'] ?? '',
          userReviewed: item['userReviewed'] ?? '',
          done: item['done'] ?? false,
          avis: item['avis'] ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('An error occurred while fetching avis: $e');
    }
  }

  Future<List<AvisObjet>> fetchAvisObjet(String username) async {
    try{
      final res = await _supabaseService.client.from('AvisObjet')
          .select('id, idObjetReview, Objets: idObjetReview (nomObjet, usernameOwner), userWriter, done, avis')
          .filter('Objets.usernameOwner', 'eq', username);
      return res.map((item) {
        final obj = item['Objets'];
        return AvisObjet(
          id: item['id'],
          idObjetReview: item['idObjetReview'] ?? '',
          nomObjet: obj != null ? obj['nomObjet'] : '',
          usernameOwner: obj != null ? obj['usernameOwner'] : '',
          userWriter: item['userWriter'] ?? '',
          done: item['done'] ?? false,
          avis: item['avis'] ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('An error occurred while fetching avis: $e');
    }
  }
}