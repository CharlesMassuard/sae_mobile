import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../mytheme.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sae_mobile/pages/SettingViewModel.dart';

class WidgetSettings extends StatefulWidget{
  @override
  State<WidgetSettings> createState() => _EcranSettingsState();
}
class _EcranSettingsState extends State<WidgetSettings> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SettingsList(
        darkTheme: SettingsThemeData(
          settingsListBackground: MyTheme.dark().scaffoldBackgroundColor,
          settingsSectionBackground: MyTheme.dark().scaffoldBackgroundColor,
        ),
        lightTheme: SettingsThemeData(
          settingsListBackground: MyTheme.light().scaffoldBackgroundColor,
          settingsSectionBackground: MyTheme.light().scaffoldBackgroundColor,
        ),
        sections: [
          SettingsSection(
            title: const Text('Theme'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Dark mode'),
                leading: const Icon(Icons.invert_colors),
                initialValue: context.watch<SettingViewModel>().isDark,
                onToggle: (bool value) {
                  setState(() {
                    _dark = value;
                    context.read<SettingViewModel>().isDark = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
