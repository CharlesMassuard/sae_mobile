import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/providers/supabaseProv.dart';
import 'package:sae_mobile/utils/supabaseService.dart';
import 'router.dart';
import 'bdLocale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => supabaseProvider(SupabaseService()),
      child: MaterialApp.router(
        routerConfig: MyAppRouter.router,
        debugShowCheckedModeBanner: false,
        title: "SAE Mobile",
      ),
    );
  }
}