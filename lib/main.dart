import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ycqvbochpjqhxnvdoepf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljcXZib2NocGpxaHhudmRvZXBmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAxNzEyODgsImV4cCI6MjAyNTc0NzI4OH0.TyusO0SoF8Lt-luQz72vM7pZahOrZE8dD8dPnyVpCeY',
  );

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
