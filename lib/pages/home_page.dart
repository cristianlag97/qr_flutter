import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';

import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/custom_navigator.dart';
import 'package:qr_reader/widgets/scan_button.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async{

              final deleteAllScans = await Provider.of<ScanListProvider>(context, listen: false);
              deleteAllScans.borrarTodos();


            },
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
    //final tempScan = ScanModel(valor: 'http://youtube.com');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScanById(4);
    //DBProvider.db.deleteAllScans();

    //Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(currentIndex) {

      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        //return MapasPage();
        return ScanTiles(tipo: 'geo');

      case 1:
        scanListProvider.cargarScanPorTipo('http');
        //return DireccionesPage();
        return ScanTiles(tipo: 'http');

      default:
        //return MapasPage()
        return ScanTiles(tipo: 'geo');
    }

    /*const optionSelect = {
      0: MapasPage(),
      1: DireccionesPage()
    };

    final pageDefault = MapasPage();
    final page = optionSelect[currentIndex] ?? pageDefault;
    return page;*/
  }
}
