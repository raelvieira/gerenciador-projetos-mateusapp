import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'modules/projeto/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Gerenciador de Projetos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.red,
          cardColor: Colors.grey[100],
          accentColor: Colors.redAccent,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.red,
              elevation: 0,
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
              )
          )
      ),
      home: HomeModule(),
    );
  }
}