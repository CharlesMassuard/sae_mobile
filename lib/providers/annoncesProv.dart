import 'package:flutter/foundation.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

class Announcement {
  final int id;
  final String title;
  final String description;
  final String username;

  Announcement({required this.title, required this.description, required this.username, required this.id});
}

class AnnouncementProvider with ChangeNotifier {
  List<Announcement> _announcements = [];
  final SupabaseService _supabaseService;

  AnnouncementProvider(this._supabaseService);

  List<Announcement> get announcements => _announcements;

  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      final res = await _supabaseService.client.from('Annonces').select('idAnn, titreAnn, descAnn, username').order('idAnn', ascending: false);
      _announcements = res.map((item) {
        return Announcement(
          id: item['idAnn'],
          title: item['titreAnn'],
          description: item['descAnn'],
          username: item['username'],
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
      final res = await _supabaseService.client.from('Annonces').select('idAnn, titreAnn, descAnn, username').eq('idAnn', id).single();
      return Announcement(
        id: res['idAnn'],
        title: res['titreAnn'],
        description: res['descAnn'],
        username: res['username'],
      );
    } catch (e) {
      throw Exception('An error occurred while fetching announcement: $e');
    }
  }
}