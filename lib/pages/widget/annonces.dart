import 'package:flutter/material.dart';
import 'package:sae_mobile/providers/annoncesProv.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:provider/provider.dart';

class WidgetAnnonces extends StatefulWidget {
  const WidgetAnnonces({super.key});

  @override
  WidgetAnnoncesState createState() => WidgetAnnoncesState();
}

class WidgetAnnoncesState extends State<WidgetAnnonces> {
  late Future<List<Announcement>> _announcementFuture;

  @override
  void initState() {
    super.initState();
    final announcementProvider = Provider.of<AnnouncementProvider>(context, listen: false);
    _announcementFuture = announcementProvider.fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    return MaterialApp(
        theme: MyTheme.light(),
        title: "Annonces",
        home: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Annonces",
                          style: TextStyle(
                            fontSize: screenUtil.responsiveFontSizeShort(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10), // You can adjust this value to your liking
                        ElevatedButton(
                          onPressed: () => context.go('/nouvelleAnnonce'),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: screenUtil.responsiveFontSizeShort(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Announcement>>(
                    future: _announcementFuture,
                    builder: (BuildContext context, AsyncSnapshot<List<Announcement>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: 200,  // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), // Adjust the color as needed
                              backgroundColor: Colors.grey[200], // Adjust the color as needed
                              strokeWidth: 5, // Adjust the stroke width as needed
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Ajouter un objet!'),
                        );
                      }
                      else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final announcement = snapshot.data![index];
                            return Container(
                              color: Colors.blueGrey[50], // Set the background color of the ListTile
                              child: ListTile(
                                title: Text(announcement.title),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(announcement.description),
                                    Text('Date : ${announcement.date}', style: TextStyle(fontStyle: FontStyle.italic)), // Display the date of the announcement
                                    Text('Auteur : ${announcement.username}', style: TextStyle(fontStyle: FontStyle.italic)), // Display the name of the owner
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to the details page
                                    context.go('/annonce/${announcement.id}');
                                  },
                                  child: Text('Voir plus'),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            )
        )
    );
  }
}

