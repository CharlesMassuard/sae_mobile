import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/utils/screenUtil.dart';
import 'package:sae_mobile/mytheme.dart';

class WidgetAnnonces extends StatelessWidget {
  const WidgetAnnonces({super.key});

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    return MaterialApp(
        theme: MyTheme.dark(),
        title: "Annonces",
        home: Scaffold(
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Annonces",
                            style: TextStyle(
                              fontSize: screenUtil.responsiveFontSizeShort(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10), // You can adjust this value to your liking
                          ElevatedButton(
                            onPressed: () => context.go('/nouvelleAnnonce'),
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: screenUtil.responsiveFontSizeShort(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            )
        )
    );
  }
}