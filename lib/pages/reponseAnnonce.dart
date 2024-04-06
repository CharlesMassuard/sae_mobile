import 'package:flutter/material.dart';
import 'package:sae_mobile/providers/annoncesProv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:sae_mobile/utils/screenUtil.dart';

class ReponseAnnonce extends StatefulWidget {
  const ReponseAnnonce({super.key});

  @override
  ReponseAnnonceState createState() => ReponseAnnonceState();
}

class ReponseAnnonceState extends State<ReponseAnnonce> {
  late Future<Announcement> _announcementFuture;
  late AnnouncementProvider announcementProvider;

  @override
  void initState() {
    super.initState();
    announcementProvider = Provider.of<AnnouncementProvider>(context, listen: false);
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final id = int.parse(uri.pathSegments.last);
    _announcementFuture = announcementProvider.fetchAnnouncement(id);
  }

  @override
  Widget build(BuildContext context) {
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final id = int.parse(uri.pathSegments.last);
    final screenUtil = ScreenUtil(context);
    _announcementFuture = Provider.of<AnnouncementProvider>(context, listen: false).fetchAnnouncement(id);
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
                    Text('Répondre à cette annonce:', style: TextStyle(fontSize: screenUtil.responsiveFontSizeShort())),
                    const SizedBox(height: 10),
                    Text('Coming soon TM', style: TextStyle(fontSize: screenUtil.responsiveFontSizeMedium())),
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
                            onPressed: () {
                              context.go('/');
                            },
                            child: const Text('Répondre'),
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