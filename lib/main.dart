import 'package:flutter/material.dart';
import 'router.dart';

Future<void> main() async {
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
