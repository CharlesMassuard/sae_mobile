import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal() {
    Supabase.initialize(
      url: 'https://ycqvbochpjqhxnvdoepf.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljcXZib2NocGpxaHhudmRvZXBmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAxNzEyODgsImV4cCI6MjAyNTc0NzI4OH0.TyusO0SoF8Lt-luQz72vM7pZahOrZE8dD8dPnyVpCeY',
    );
  }

  SupabaseClient get client => Supabase.instance.client;

  Future<String?> getUsernameFromEmail() async {
    return await Future<String?>(() {
      final userEmail = Supabase.instance.client.auth.currentUser?.email;
      if (userEmail != null) {
        final username = userEmail.split('@')[0];
        return username;
      }
      return null;
    });
  }

  Future<void> insertAnnouncement(String title, String description, String date) async {
    try {
      final userMail = client.auth.currentUser?.email;
      if (userMail == null) {
        throw Exception('No user is currently logged in');
      }
      final username = await getUsernameFromEmail();
      final response = await client.from('Annonces').insert({
        'titreAnn': title,
        'descAnn': description,
        'username': username,
        'statusAnn': 'posted',
        'date': date,
      });
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }
}