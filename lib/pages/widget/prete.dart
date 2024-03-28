import 'package:flutter/material.dart';
import '../../mytheme.dart';

class Prete extends StatelessWidget {
  const Prete({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MyTheme.dark(),
        title: "Profil",
        home: const Scaffold(
            body: Center(
                child: Text(
                    "Mes objets!"
                )
            )
        )
    );
  }
}