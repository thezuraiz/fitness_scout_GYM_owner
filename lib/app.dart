
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bindings/general_bindings.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      // By default Theme is on Light
      theme: AppTheme.lightTheme,
      title: 'Fitness Scout for GYM Owners',
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: ZColor.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: ZColor.white,
          ),
        ),
      ),
    );
  }
}

