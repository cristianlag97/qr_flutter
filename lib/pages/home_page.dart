import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigator.dart';
import 'package:qr_reader/widgets/scan_button.dart';

import 'direcciones_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: (){},
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Obtener el selectedOPt para el menubar
    final uiProvider = Provider.of<UiProvider>(context);

    //Cambiar para mostrar página respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //TODO: temporal leer base de datos
    DBProvider.db.database;

    const optionSelect = {
      0: MapasPage(),
      1: DireccionesPage()
    };

    final pageDefault = MapasPage();
    final page = optionSelect[currentIndex] ?? pageDefault;
    return page;
  }
}
