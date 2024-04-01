import 'package:flutter/material.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

class WidgetProfil extends StatefulWidget {
  const WidgetProfil({super.key});

  @override
  WidgetProfilState createState() => WidgetProfilState();
}

class WidgetProfilState extends State<WidgetProfil> {
  String userEmail = '';
  late ScreenUtil screenUtil;

  @override
  void initState() {
    super.initState();
    final supabaseService = SupabaseService();
    supabaseService.getUsernameFromEmail().then((value) {
      setState(() {
        userEmail = value ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil = ScreenUtil(context);
    return MaterialApp(
      theme: MyTheme.dark(),
      title: "Profil",
      home: Scaffold(
        body: FutureBuilder<String?>(
          future: SupabaseService().getUsernameFromEmail(), // Use the singleton instance here
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                userEmail = snapshot.data ?? '';
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bonjour $userEmail 👋",
                      style: TextStyle(
                        fontSize: screenUtil.responsiveFontSizeMedium(),
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
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 200,
                        minHeight: 50,
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Se déconnecter'),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}