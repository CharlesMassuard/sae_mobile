import 'package:go_router/go_router.dart';
import 'pages/connexion.dart';
import 'pages/SAE.dart';
import 'pages/createAccount.dart';
import 'pages/nouvelleAnnonce.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) { return const SAE();}
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) { return const LoginPage();}
      ),
      GoRoute(
          path: '/register',
          builder: (context, state) { return const CreateAccountPage();}
      ),
      GoRoute(
          path: '/nouvelleAnnonce',
          builder: (context, state) { return const NouvelleAnnonce();}
      ),
    ],
  );
}