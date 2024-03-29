import 'package:flutter/material.dart';
import '../../mytheme.dart';
import 'package:go_router/go_router.dart';

class WidgetProfil extends StatelessWidget {
  const WidgetProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.dark(),
      title: "Profil",
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  minHeight: 50,
                ),
                child: ElevatedButton(
                  onPressed: () => context.go('/page1'),
                  child: const Text('Mon profil'),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  minHeight: 50,
                ),
                child: ElevatedButton(
                  onPressed: () => context.go('/page2'),
                  child: const Text('Mes objets'),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  minHeight: 50,
                ),
                child: ElevatedButton(
                  onPressed: () => context.go('/page3'),
                  child: const Text('Mes prêts'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}