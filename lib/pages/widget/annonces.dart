import 'package:flutter/material.dart';
import '../../mytheme.dart';

class WidgetAnnonces extends StatelessWidget {
  const WidgetAnnonces({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MyTheme.dark(),
        title: "Annonces",
        home: const Scaffold(
            body: Center(
                child: Text(
                    "Liste d'annonces épiques!"
                )
            )
        )
    );
  }
}