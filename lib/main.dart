import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'router.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SupabaseService supabaseService = SupabaseService();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyAppRouter.router,
      debugShowCheckedModeBanner: false,
      title: "SAE Mobile",
    );
  }
}
