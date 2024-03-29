import 'package:flutter/material.dart';
import '../../mytheme.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WidgetProfil extends StatefulWidget {
  const WidgetProfil({super.key});

  @override
  WidgetProfilState createState() => WidgetProfilState();
}

class WidgetProfilState extends State<WidgetProfil> {
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      userEmail = user.email ?? '';
    }
  }

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
              Text(
                "Bonjour $userEmail 👋",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
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