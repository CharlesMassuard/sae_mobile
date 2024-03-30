import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService() {
    Supabase.initialize(
      url: 'https://ycqvbochpjqhxnvdoepf.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljcXZib2NocGpxaHhudmRvZXBmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAxNzEyODgsImV4cCI6MjAyNTc0NzI4OH0.TyusO0SoF8Lt-luQz72vM7pZahOrZE8dD8dPnyVpCeY',
    );
  }

  SupabaseClient get client => Supabase.instance.client;

  Future<void> insertAnnouncement(String title, String description) async {
    try {
      final response = await client.from('Annonces').insert({
        'titreAnn': title,
        'descAnn': description,
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