import 'package:flutter/foundation.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

import '../models/objets.dart';
import '../models/annoncesModel.dart';

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




}