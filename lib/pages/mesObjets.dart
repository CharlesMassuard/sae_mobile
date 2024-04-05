import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:sae_mobile/providers/objetsProvider.dart';
import 'package:sae_mobile/models/objets.dart';

class MesObjets extends StatefulWidget {
  const MesObjets({Key? key}) : super(key: key);

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
            ),git add
          ),
          Expanded(
            child: FutureBuilder<List<MesObjets>?>(
              future: MesObjetsProvider.db.getMesObjets(),
              builder: (BuildContext context, AsyncSnapshot<List<MesObjets>?> snapshot) {
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}