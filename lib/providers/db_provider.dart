import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();//constructor privado

  Future<Database> get database async{
    if(_database !=null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database>initDB() async{

    //Path de donde almacenaré la base de datos
    Directory documentsDyrectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDyrectory.path, 'ScansDB.db');
    print(path);

    //crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute('''
          CREATE TABLE SCANS(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );

  }

  //TODO: Forma uno de hacer y es la forma larga
  Future<int>nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //Verificar base de datos
    final db = await database;
    final respuesta = await db.rawInsert(
      '''
      INSERT INTO Scan (id, tipo, valor)
        VALUES( $id, '$tipo', '$valor' )
      ''');

    return respuesta;
  }

  //TODO: Segunda forma corta y funciona igual
  Future<int> nuevoScan (ScanModel nuevoScan) async {
    final db = await database;
    final respuesta = await db.insert('Scans', nuevoScan.toJson());

    //es el ultimo ID del registro insertado
    return respuesta;
  }

  Future<ScanModel?> getScanById( int id ) async{
    final db = await database;
    final respuesta = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return respuesta.isNotEmpty ? ScanModel.fromJson(respuesta.first) : null;
  }

  Future<List<ScanModel>?> getTodosScans() async{
    final db = await database;
    final respuesta = await db.query('Scans');

    return respuesta.isNotEmpty ? respuesta.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansPorTipo( String tipo) async{

    final db = await database;
    //final respuesta = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    final respuesta = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return respuesta.isNotEmpty ? respuesta.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan (ScanModel nuevoScan) async {
    final db = await database;
    final respuesta = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id ]);
    return respuesta;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final respuesta = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return respuesta;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final respuesta = db.delete('Scans');
    return respuesta;
  }

}