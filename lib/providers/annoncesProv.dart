import 'package:flutter/foundation.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

class Announcement {
  final int id;
  final String title;
  final String description;
  final String username;
  final String status;
  final String date;

  Announcement({required this.title, required this.description, required this.username, required this.id, required this.status, required this.date});
}

class AnnouncementProvider with ChangeNotifier {
  List<Announcement> _announcements = [];
  final SupabaseService _supabaseService;

  AnnouncementProvider(this._supabaseService);

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
}