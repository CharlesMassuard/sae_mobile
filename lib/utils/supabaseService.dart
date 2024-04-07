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

  Future<int> insertObjet(String nom, String description, int idBDLocale) async {
    int returnedId = await objetExist(idBDLocale);
    if (returnedId != -1) {
      return returnedId;
    }
    try {
      final userMail = client.auth.currentUser?.email;
      if (userMail == null) {
        throw Exception('No user is currently logged in');
      }
      final username = await getUsernameFromEmail();
      final response = await client.from('Objets').insert({
        'nomObjet': nom,
        'descriptionObjet': description,
        'usernameOwner': username,
        'idObjetBDLocal': idBDLocale,
        'lent': false,
      }).select('idObjet');
      if (response.isNotEmpty) {
        return response[0]['idObjet'];
      } else {
        throw Exception('Failed to insert object: no rows returned');
      }
    }
    catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }

  Future<int> objetExist(int idBDLocale) async {
    try {
      final response = await client.from('Objets').select().eq('idObjetBDLocal', idBDLocale);
      if (response.isNotEmpty) {
        return response[0]['idObjet'];
      } else {
        return -1;
      }
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }

  Future<void> reponseAnnonce(int idAnnonce, int idObjet) async {
    try {
      final response = await client.from('ReponseAnnonce').insert({
        'idAnnRep': idAnnonce,
        'idObjetRep': idObjet,
      });
      updateAnnonce(idAnnonce);
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }

  Future<void> updateAnnonce(int idAnnonce) async {
    try {
      final response = await client.from('Annonces').update({'statusAnn': 'answered'}).eq('idAnn', idAnnonce);
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }

  Future<void> refuseObjet(int idObjet, int idAnnonce) async {
    try {
      final response = await client.from('ReponseAnnonce').delete().eq('idObjetRep', idObjet).eq('idAnnRep', idAnnonce);
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }

  Future<void> acceptObjet(int idObjet, int idAnnonce) async {
    try {
      final response = await client.from('Objets').update({'lent': true}).eq('idObjet', idObjet);
      final response2 = await client.from('Annonces').update({'statusAnn': 'accepted'}).eq('idAnn', idAnnonce);
      final response3 = await client.from('ReponseAnnonce').delete().eq('idAnnRep', idAnnonce);
      final response4 = await client.from('Pret').insert(
        {
          'idObjPret': idObjet,
          'idAnnPret': idAnnonce,
          'enCours': true,
        },
      );
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception('A method was called on a null object: $e');
      } else {
        throw Exception('An unknown error occurred: $e');
      }
    }
  }
}