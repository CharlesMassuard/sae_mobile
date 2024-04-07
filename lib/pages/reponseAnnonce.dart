import 'package:flutter/material.dart';
import 'package:sae_mobile/providers/supabaseProv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/utils/supabaseService.dart';
import 'package:sae_mobile/providers/objetsProvider.dart';
import 'package:sae_mobile/models/objets.dart';

import '../models/annoncesModel.dart';

class ReponseAnnonce extends StatefulWidget {
  const ReponseAnnonce({super.key});

  @override
  ReponseAnnonceState createState() => ReponseAnnonceState();
}

class ReponseAnnonceState extends State<ReponseAnnonce> {
  late Future<Announcement> _announcementFuture;
  late supabaseProvider announcementProvider;
  late List<Objet> listObjet;
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
    _announcementFuture = announcementProvider.fetchAnnouncement(id);
  }

  void loadObjets() async {
    List<Objet>? objets = await MesObjetsProvider().getMesObjets();
    listObjet = objets ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final idAnn = int.parse(uri.pathSegments.last);
    final screenUtil = ScreenUtil(context);
    _announcementFuture = Provider.of<supabaseProvider>(context, listen: false).fetchAnnouncement(idAnn);
    return MaterialApp(
      theme: MyTheme.dark(), // Use MyTheme.dark() for the dark theme
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Réponse à une annonce'),
        ),
        body: FutureBuilder<Announcement>(
          future: _announcementFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final announcement = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Annonce:', style: TextStyle(fontSize: screenUtil.responsiveFontSizeShort())),
                    const SizedBox(height: 10),
                    Text('Titre: ${announcement.title}', style: TextStyle(fontSize: screenUtil.responsiveFontSizeMedium())),
                    const SizedBox(height: 10),
                    Text('Demandé par: ${announcement.username}', style: TextStyle(fontSize: screenUtil.responsiveFontSizeMedium())),
                    const SizedBox(height: 10),
                    Text('Description: ${announcement.description}', style: TextStyle(fontSize: screenUtil.responsiveFontSizeLong())),
                    const SizedBox(height: 30),
                    Text('Préter un objet:', style: TextStyle(fontSize: screenUtil.responsiveFontSizeShort())),
                    const SizedBox(height: 10),
                    DropdownMenu(
                      onSelected: (Objet? value) {
                        dropdownValue = value;
                      },
                      dropdownMenuEntries: listObjet.map<DropdownMenuEntry<Objet>>((Objet value){
                        return DropdownMenuEntry<Objet>(
                          value: value,
                          label: value.nomObjet, // Display the name of the object in the dropdown menu
                        );
                    }).toList(),),
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.go('/');
                            },
                            child: const Text('Retour'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              if(dropdownValue == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Veuillez sélectionner un objet'),
                                    content: const Text('Veuillez sélectionner un objet pour pouvoir le prêter'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Fermer'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              else{
                                String nomObjet = dropdownValue?.nomObjet ?? 'Valeur par défaut';
                                String descriptionObjet = dropdownValue?.descriptionObjet ?? 'Valeur par défaut';
                                int idObj = await supabaseService.insertObjet(nomObjet, descriptionObjet);
                                supabaseService.reponseAnnonce(idAnn, idObj);
                                SnackBar snackBar = const SnackBar(
                                  content: Text('Objet prêté avec succès'),
                                  duration: Duration(seconds: 3),
                                );
                                GoRouter.of(context).go('/');
                              }
                            },
                            child: const Text("Prêter l'objet"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      )
    );
  }
}