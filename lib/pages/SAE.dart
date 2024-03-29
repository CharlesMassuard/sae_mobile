import 'package:flutter/material.dart';
import 'package:sae_mobile/mytheme.dart';
import 'package:sae_mobile/pages/widget/profil.dart';
import 'package:sae_mobile/pages/widget/annonces.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SAE extends StatefulWidget{
  const SAE({super.key});

  @override
  Home createState()=> Home();
}

class Home extends State<SAE>{
  Home();

  int _currentWidget = 0;

  Future<bool> checkLoginStatus() async {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == false) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return Container();
        } else {
          return _buildHome(context);
        }
      },
    );
  }

  Widget _buildHome(BuildContext context) {
    Widget child = Container();

    switch(_currentWidget){
      case 0:
        child = WidgetAnnonces();
        break;
      case 1:
        child = WidgetProfil();
        break;
    }

    return MaterialApp(
        theme: MyTheme.dark(),
        title: 'Accueil',
        home: Scaffold(
          appBar: AppBar(
              title: const Text("Allo, La plateforme d'échange entre étudiants!"),
              titleTextStyle: MyTheme.darkTextTheme.displayLarge
          ),
          backgroundColor: Colors.black,
          bottomNavigationBar: _getNavBar(),
          body: SizedBox.expand(child: child),
        )
    );
  }

  Widget _getNavBar(){
    return BottomNavigationBar(
      currentIndex: _currentWidget,
      onTap: (int index) => setState(() => _currentWidget = index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Annonces',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}