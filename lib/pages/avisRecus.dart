import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/providers/supabaseProv.dart';
import 'package:sae_mobile/models/avis.dart';
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
  late Future<List<AvisPersonne?>?> _avisPersonneFuture;
  late Future<List<AvisObjet?>?> _avisObjetsFuture;
  late SupabaseService _supabaseService;

  @override
  void initState() {
    super.initState();
    screenUtil = ScreenUtil(context);
    _supabaseService = SupabaseService();
    _supabaseProvider = Provider.of<supabaseProvider>(context, listen: false);
    _avisPersonneFuture = _supabaseProvider.fetchAvisPersonne(_supabaseService.getUsernameFromEmail() as String) as Future<List<AvisPersonne?>?>;
    _avisObjetsFuture = _supabaseProvider.fetchAvisObjet(_supabaseService.getUsernameFromEmail() as String) as Future<List<AvisObjet?>?>;
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
            child: FutureBuilder<List<AvisPersonne?>?>(
              future: _avisPersonneFuture,
              builder: (BuildContext context, AsyncSnapshot<List<AvisPersonne?>?> snapshot) {
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
                        child: Text('Auncun avis reçu !'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                title: Text(snapshot.data![index]!.userWriter.toString()),
                                subtitle: Text(snapshot.data![index]!.avis.toString()),
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