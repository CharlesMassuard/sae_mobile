import 'package:flutter/material.dart';
import 'package:sae_mobile/providers/annoncesProv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
    _announcementFuture = Provider.of<AnnouncementProvider>(context, listen: false).fetchAnnouncement(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réponse à l\'annonce de '),
      ),
      body: FutureBuilder<Announcement>(
        future: _announcementFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final announcement = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${announcement.title}', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 10),
                  Text('Description: ${announcement.description}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Username: ${announcement.username}', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/');
                      },
                      child: Text('Go Back'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}