import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/providers/supabaseProv.dart';
import 'package:sae_mobile/mytheme.dart';
import '../models/avis.dart';
import '../utils/supabaseService.dart';

class AvisList extends StatefulWidget {
  const AvisList({Key? key}) : super(key: key);

  @override
  _AvisListState createState() => _AvisListState();
}

class _AvisListState extends State<AvisList> {
  late SupabaseService _supabaseService;
  String? username;

  @override
  void initState() {
    super.initState();
    _supabaseService = SupabaseService();
    Future.microtask(() async {
      username = await _supabaseService.getUsernameFromEmail();
      setState(() {}); // Call setState to rebuild the widget with the new value.
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<supabaseProvider>(context, listen: false);
    if (username == null) {
      return CircularProgressIndicator(); // Show a loading spinner while username is null.
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<AvisPersonne>>(
            future: provider.fetchAvisPersonne(username!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final avis = snapshot.data![index];
                    return Theme(
                      data: MyTheme.dark(), // Replace this with your custom theme
                      child: Material(
                        child: ListTile(
                          title: Text('AvisPersonne: ${avis.avis}'),
                          subtitle: Text('Written by: ${avis.userWriter}'),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          FutureBuilder<List<AvisObjet>>(
            future: provider.fetchAvisObjet(username!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final avis = snapshot.data![index];
                    return Theme(
                      data: MyTheme.dark(), // Replace this with your custom theme
                      child: Material(
                        child: ListTile(
                          title: Text('AvisObjet: ${avis.avis}'),
                          subtitle: Text('Written by: ${avis.userWriter} On: ${avis.nomObjet}'),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }
}