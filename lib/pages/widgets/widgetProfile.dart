import 'package:flutter/material.dart';
import '../../mytheme.dart';

class WidgetProfile extends StatelessWidget {
  const WidgetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MyTheme.dark(),
        title: "SAE Mobile",
        home: const Scaffold(
            body: Center(
                child: Text(
                    "Page profile!"
                )
            )
        )
    );
  }
}