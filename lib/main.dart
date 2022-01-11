import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'mapa': (_) => const MapaPage(),
        },
        //Theme: ThemeData(
        //primaryColor: Colors.red,
          //floatingActionButtonTheme: FloatingActionButtonThemeData(
          // backgroundColor: Colors.red
          // )
        //)
        theme: ThemeData(
          primarySwatch: Colors.deepPurple
        )
      ),
    );
  }
}

/*
* Tuve el mismo error, lo resolví de la siguiente manera:

theme: ThemeData(
  colorScheme: ColorScheme.light().copyWith(primary: Colors.orange),
),
También funciona con el siguiente código

theme: ThemeData(
  primarySwatch: Colors.red
),
Traté de entender el concepto del porqué pero no lo logré.
*
* */