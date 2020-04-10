import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_sqlite/src/block/scans_block.dart';
import 'package:scanner_sqlite/src/models/scan_model.dart';
import 'package:scanner_sqlite/src/pages/direcciones_page.dart';
import 'package:scanner_sqlite/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:scanner_sqlite/src/utils/utils.dart' as utils;
 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0; 
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text('QRScanner'),
    actions: <Widget>[
    IconButton(icon: Icon(Icons.delete_forever),
    onPressed: scansBloc.borrarTodos)
    ],),
    body: _callPage(currentIndex),
    bottomNavigationBar: _crearBotomNavigationBar(),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
    onPressed: () => _scanQR(context),
    child: Icon(Icons.filter_center_focus),
    backgroundColor: Theme.of(context).primaryColor,
    ),
   
    );
  }

  _scanQR(BuildContext context) async
  {
    
    //https://fernando-herrera.com
 
    String local =  'geo:40.712784,-74.005941';

    String futureString = 'https://fernando-herrera.com';

    try{
     

    
    //futureString = await BarcodeScanner.scan();
    
   
     if(futureString != null)
     {
       
       final scan = ScanModel(valor: local);
       scansBloc.agregarScan(scan);
       
       if(Platform.isIOS)
       {
         Future.delayed(Duration(milliseconds: 750), ()
         {
            utils.launchURL(scan, context);
         });
       }else{

            utils.launchURL(scan, context);
           
       }

     }



    }catch (e)
    {
      futureString = e.toString();
    }

  }



  Widget _callPage(int paginaActual)
  {

     switch(paginaActual)
     {
       case 0: return MapasPage();
       case 1: return DireccionesPage();
       
       
       
       
       default: return MapasPage();
     }




  }

  Widget _crearBotomNavigationBar()
  {
    return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
    setState(() {
      currentIndex = index;
    });
    },
    items: [
    BottomNavigationBarItem(
    icon: Icon(Icons.map),
    title: Text('Mapas')
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.brightness_5),
    title: Text('Direcciones')

    ),

    ],
    );
  }



  


}