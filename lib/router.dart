import 'package:go_router/go_router.dart';
import 'package:sae_mobile/pages/reponseAnnonce.dart';
import 'package:sae_mobile/pages/connexion.dart';
import 'package:sae_mobile/pages/SAE.dart';
import 'package:sae_mobile/pages/createAccount.dart';
import 'package:sae_mobile/pages/nouvelleAnnonce.dart';
import 'package:sae_mobile/pages/connexion.dart';
import 'package:sae_mobile/pages/SAE.dart';
import 'package:sae_mobile/pages/createAccount.dart';
import 'package:sae_mobile/pages/nouvelleAnnonce.dart';
import 'package:sae_mobile/pages/mesObjets.dart';
import 'package:sae_mobile/pages/nouvelObjet.dart';
import 'package:sae_mobile/pages/mesObjets.dart';
import 'package:sae_mobile/pages/reponsesRecues.dart';
import 'package:sae_mobile/pages/propositionsObjets.dart';

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
      GoRoute(
        path: '/annonce/:id',
        builder: (context, state) { return const ReponseAnnonce();}
      ),
      GoRoute(
          path: '/mesObjets',
          builder: (context, state) { return const MesObjets();}
      ),
      GoRoute(
          path: '/nouvelObjet',
          builder: (context, state) { return const NouvelObjet();}
      ),
      GoRoute(
          path: '/reponsesRecues',
          builder: (context, state) { return const ReponsesRecues();}
      ),
      GoRoute(
          path: '/propositionsObjets/:id',
          builder: (context, state) { return const PropositionsObjets();}
      ),
    ],
  );
}