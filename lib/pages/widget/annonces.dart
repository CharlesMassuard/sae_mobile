import 'package:flutter/material.dart';
import '../../mytheme.dart';

class Recoit extends StatelessWidget {
  const Recoit({super.key});

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