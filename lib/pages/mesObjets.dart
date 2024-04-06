import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:sae_mobile/providers/objetsProvider.dart';
import 'package:sae_mobile/models/objets.dart';

class MesObjets extends StatefulWidget {
  const MesObjets({super.key});

  @override
  _MesObjets createState() => _MesObjets();
}

class _MesObjets extends State<MesObjets> {
  final _formKey = GlobalKey<FormState>();

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
                    "Mes Objets",
                    style: TextStyle(
                      fontSize: screenUtil.responsiveFontSizeShort(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10), // You can adjust this value to your liking
                  ElevatedButton(
                    onPressed: () => context.go('/nouvelObjet'),
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
            child: FutureBuilder<List<Objet>?>(
              future: MesObjetsProvider.db.getMesObjets()?.catchError((error) {
                print('Error getting objects: $error');
              }),
              builder: (BuildContext context, AsyncSnapshot<List<Objet>?> snapshot) {
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
                        child: Text('Ajouter un objet!'),
                      );
                    } else {
                      print('Objects returned: ${snapshot.data}');
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data![index].nomObjet),
                              subtitle: Text(snapshot.data![index].descriptionObjet),
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