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

  Future<AvisPersonne?> fetchAvisPersonne(String username) async {
    try {
      final res = await _supabaseService.client.from('AvisPersonne')
          .select('idAvis, userWriter, userReviewed, done, avis')
          .eq('userReviewed', username);
      if(res.isEmpty) {
        return null;
      }
      return AvisPersonne(
        id: res[0]['id'],
        userWriter: res[0]['userWriter'],
        userReviewed: res[0]['userReviewed'],
        done: res[0]['done'],
        avis: res[0]['avis'],
      );
    } catch (e) {
      throw Exception('An error occurred while fetching avis: $e');
    }
  }

  Future<AvisObjet> fetchAvisObjet(String username) async {
    try{
      final res = await _supabaseService.client.from('AvisObjet')
          .select('idAvis, Objets: idObjetReview (*), userWriter, done, avis')
          .eq('Objets.usernameOwner', username);
      return AvisObjet(
        id: res[0]['id'],
        idObjetReview: res[0]['idObjetReview'],
        nomObjet: res[0]['nomObjet'],
        userWriter: res[0]['userWriter'],
        done: res[0]['done'],
        avis: res[0]['avis'],
      );
    } catch (e) {
      throw Exception('An error occurred while fetching avis: $e');
    }
  }
}