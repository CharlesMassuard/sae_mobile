import 'package:flutter/material.dart';
import '../mytheme.dart';
import 'package:sae_mobile/pages/widgets/widgetAccueil.dart';
import 'package:sae_mobile/pages/widgets/widgetProfile.dart';
import 'package:sae_mobile/pages/widgets/widgetSettings.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  Home createState()=> Home();
}

class Home extends State<MainPage>{
  Home();

  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch(_currentScreen){
      case 0:
        child = WidgetAccueil();
        break;
      case 1:
        child = WidgetProfile();
        break;
      case 2:
        child = WidgetSettings();
        break;
    }

    return MaterialApp( //Changer la barre de navigation
        theme: MyTheme.dark(),
        title: "SAE Mobile",
        home: Scaffold(
          appBar: AppBar(
              title: const Text("ALL'O"),
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
      currentIndex: _currentScreen,
      onTap: (int index) => setState(() => _currentScreen = index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}