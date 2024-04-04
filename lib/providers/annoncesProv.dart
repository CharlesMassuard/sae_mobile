import 'package:flutter/foundation.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

class Announcement {
  final String title;
  final String description;
  final String username;

  Announcement({required this.title, required this.description, required this.username});
}

class AnnouncementProvider with ChangeNotifier {
  List<Announcement> _announcements = [];
  final SupabaseService _supabaseService;

  AnnouncementProvider(this._supabaseService);

  List<Announcement> get announcements => _announcements;

  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      final res = await _supabaseService.client.from('Annonces').select('titreAnn, descAnn, username').order('idAnn', ascending: false);
      _announcements = res.map((item) {
        return Announcement(
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
}