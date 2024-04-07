import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/providers/supabaseProv.dart';
import 'package:sae_mobile/models/pret.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

class AvisRecus extends StatefulWidget {
  const AvisRecus({super.key});


  @override
  _AvisRecusState createState() => _AvisRecusState();
}

class _AvisRecusState extends State<AvisRecus> {
  final _formKey = GlobalKey<FormState>();
  late ScreenUtil screenUtil;
  late supabaseProvider _supabaseProvider;
  late Future<List<Pret?>?> _pretFuture;
  late SupabaseService _supabaseService;

  @override
  void initState() {
    super.initState();
    final pretProvider = Provider.of<supabaseProvider>(context, listen: false);
    _pretFuture = pretProvider.fetchEmprunts();
    screenUtil = ScreenUtil(context);
    _supabaseService = SupabaseService();
    _supabaseProvider = Provider.of<supabaseProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Avis Reçus",
                    style: TextStyle(
                      fontSize: screenUtil.responsiveFontSizeShort(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10), // You can adjust this value to your liking
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Pret?>?>(
              future: _pretFuture,
              builder: (BuildContext context, AsyncSnapshot<List<Pret?>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 200,  // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Adjust the color as needed
                      ),
                    ),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Aucun avis reçu !'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                title: Text(snapshot.data![index]!.objet.toString()),
                                subtitle: snapshot.data![index]!.enCours ? Text("En cours") : Text("Terminé"),
                                trailing: ElevatedButton(
                                  onPressed: () async {
                                    await _supabaseService.arretePret(snapshot.data![index]!.id);
                                    setState(() {
                                      _pretFuture = _supabaseProvider.fetchPrets(); // Fetch the updated data
                                    });
                                  },
                                  child: Text("Marquer l'emprunt comme terminé", style: TextStyle(fontSize: screenUtil.responsiveFontSizeVeryLong())),
                                )
                            ),
                          );
                        },
                      );
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}