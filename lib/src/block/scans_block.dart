


import 'dart:async';

import 'package:scanner_sqlite/src/block/validators.dart';
import 'package:scanner_sqlite/src/models/scan_model.dart';
import 'package:scanner_sqlite/src/providers/db_provider.dart';

class ScansBloc with Validators {

static final ScansBloc _singleton = new ScansBloc._internal();

factory ScansBloc()
{
  return _singleton;
}

ScansBloc._internal() 
{
  //Obtener Scans de la Base de datos
   obtenerScans();                        
                         
} 


final _scansController = StreamController<List<ScanModel>>.broadcast();

Stream<List<ScanModel>>get scansStream => _scansController.stream.transform(validarGeo);
Stream<List<ScanModel>>get scansStreamHttp => _scansController.stream.transform(validarHttp);
 
void dispose ()
{
  _scansController?.close();
}

agregarScan(ScanModel scan) async 
{
   await DBProvider.db.nuevoScan(scan);
   obtenerScans();
   
}


obtenerScans() async 
{
   
   _scansController.sink.add(await DBProvider.db.getTodosScans());

}

borrarScan (int id) async {

 await DBProvider.db.deleteScan(id);

 obtenerScans();

}


borrarTodos() async {

  await DBProvider.db.deleteAll();
  obtenerScans();
  
}





}