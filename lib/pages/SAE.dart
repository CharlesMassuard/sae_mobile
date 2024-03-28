import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/pages/home.dart';
import '../mytheme.dart';
import 'SettingViewModel.dart';

class MySAE extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //creation d'un provider
    return ChangeNotifierProvider(
      create: (_){
        SettingViewModel settingViewModel = SettingViewModel();
        //getSettings est deja appelee dans le constructeur
        return settingViewModel;
      },
      child: Consumer<SettingViewModel>(
        builder: (context,SettingViewModel notifier,child){
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark():MyTheme.light(),
              title: "SAE Mobile",
              home: MainPage()
          );
        },
      ),
    );
  }
}