import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screen/connexion.dart';
import 'screen/home.dart';
import 'screen/createAccount.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) { return const LoginPage();}
      ),
      GoRoute(
          path: '/home',
          builder: (context, state) { return const MyApp();}
      ),
      GoRoute(
          path: '/createAccount',
          builder: (context, state) { return const CreateAccountPage();}
      ),
    ],
  );
}
