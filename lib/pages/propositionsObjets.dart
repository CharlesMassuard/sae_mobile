import 'package:flutter/material.dart';
import 'package:sae_mobile/providers/supabaseProv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/utils/supabaseService.dart';
import 'package:sae_mobile/providers/objetsProvider.dart';
import 'package:sae_mobile/models/objets.dart';
import 'package:sae_mobile/pages/widget/informationPopup.dart';

import '../models/annoncesModel.dart';

class PropositionsObjets extends StatefulWidget {
  const PropositionsObjets({super.key});

  @override
  PropositionsObjetsState createState() => PropositionsObjetsState();
}

class PropositionsObjetsState extends State<PropositionsObjets> {
  late Future<List<Objet>> _objetsFuture;
  late supabaseProvider announcementProvider;
  List<Objet> listObjet = [];
  late SupabaseService supabaseService;
  Objet? dropdownValue;

  @override
  void initState() {
    super.initState();
    loadObjets();
    supabaseService = SupabaseService();
    announcementProvider = Provider.of<supabaseProvider>(context, listen: false);
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final id = int.parse(uri.pathSegments.last);
    _objetsFuture = announcementProvider.fetchObjetAnnonce(id);
  }

  void loadObjets() async {
    List<Objet>? objets = await MesObjetsProvider().getMesObjets();
    setState(() {
      listObjet = objets ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final id = int.parse(uri.pathSegments.last);
    final screenUtil = ScreenUtil(context);
    _objetsFuture = Provider.of<supabaseProvider>(context, listen: false).fetchObjetAnnonce(id);
    return MaterialApp(
        theme: MyTheme.dark(), // Use MyTheme.dark() for the dark theme
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Objets proposés'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/reponsesRecues'),
            ),
            actions: const [
              InfoButton(
                infoText: 'Ici, vous pouvez voir les objets proposés par les autres utilisateurs pour votre annonce. \nAttention, accepter un objet refusera automatiquement les autres propositions.',
              ),
            ],
          ),
          body: FutureBuilder<List<Objet>>(
            future: _objetsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final objets = snapshot.data!;
                return ListView.builder(
                  itemCount: objets.length,
                  itemBuilder: (context, index) {
                    final objet = objets[index];
                    return ListTile(
                      title: Text('Nom: ${objet.nomObjet}', style: TextStyle(fontSize: screenUtil.responsiveFontSizeMedium())),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description: ${objet.descriptionObjet}', style: TextStyle(fontSize: screenUtil.responsiveFontSizeLong())),
                          Text('Owner: ${objet.usernameOwner}', style: TextStyle(fontSize: screenUtil.responsiveFontSizeVeryLong())),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await supabaseService.refuseObjet(objet.id, id);
                              setState(() {});
                            },
                            child: Text('Refuser', style: TextStyle(fontSize: screenUtil.responsiveFontSizeVeryLong())),
                          ),
                          const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () async {
                              await supabaseService.acceptObjet(objet.id, id);
                              context.go('/reponsesRecues');
                            },
                            child: Text('Accepter', style: TextStyle(fontSize: screenUtil.responsiveFontSizeVeryLong())),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
    );
  }
}