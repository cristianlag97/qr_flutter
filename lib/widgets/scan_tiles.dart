import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utlis/utils.dart';


class ScanTiles extends StatelessWidget {

  final String tipo;

  ScanTiles({ required this.tipo});

  @override
  Widget build(BuildContext context) {


    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) => Dismissible(
          key: UniqueKey(),
          background: Container(
              color: Colors.red
          ),
          onDismissed: (DismissDirection direction) {
            Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scans[index].id!);
          },
          child: ListTile(
            leading: Icon(
              this.tipo == 'http'
              ?Icons.compass_calibration
              :Icons.map_outlined,
              color: Theme.of(context).primaryColor
            ),
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scans[index]),
          ),
        )
    );
  }
}
