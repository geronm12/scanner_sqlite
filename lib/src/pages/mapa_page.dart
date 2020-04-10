import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:scanner_sqlite/src/models/scan_model.dart';
 
class MapaPage extends StatefulWidget {
  @override
  _MapaPage createState() => _MapaPage();
}

class _MapaPage extends State<MapaPage> {

 final map = new MapController();  
 
 String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
  
  
  final ScanModel scan = ModalRoute.of(context).settings.arguments;
  
  
  return Scaffold(
    appBar: AppBar(title: Text('Coordenadas QR'),
    actions: <Widget>[
    IconButton(
    icon: Icon(Icons.my_location),
    onPressed: (){
    
    map.move(scan.getLatLng(), 15);

    },
    )],),  
    body: _crearFlutterMap(scan),
    floatingActionButton: _crearBotonFlotante(context),
    );

 
  }

    
   Widget _crearBotonFlotante(BuildContext context)
   {
     return FloatingActionButton(
     backgroundColor: Theme.of(context).primaryColor,
     child: Icon(Icons.repeat),
     onPressed: () {
     
      if(tipoMapa == 'streets')
       {
         tipoMapa = 'dark';
       }else if(tipoMapa == 'dark')
       {
         tipoMapa = 'light';
       }else if(tipoMapa == 'light')
       {
         tipoMapa = 'outdoors';
       }else if (tipoMapa == 'outdoors')
       {
         tipoMapa = 'satellite';
       }else 
       {
         tipoMapa = 'streets';
       }
 
        
        setState(() {});


     },

     );
   } 
   
   Widget _crearFlutterMap(ScanModel scan)
   {
    return new FlutterMap(
    mapController: map,
    options: MapOptions(
    center: scan.getLatLng(),
    zoom: 15
    ),

    layers: [
    _crearMapa(),
    _crearMarcadores(scan)

    ]);
   }


   _crearMapa()
   {
      
     return TileLayerOptions(
     urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}' ,
     additionalOptions: {
     'accessToken': 'pk.eyJ1IjoiZ2Vyb2xwIiwiYSI6ImNrOG95Mjg0MDAwbGgzbnBlc2JycThnMXAifQ.wTPe7SDBufqGv6zh1kRoQA',
      'id' : 'mapbox.$tipoMapa'
     });
     
     
     //Tipos de mapas: streets, dark, light, outdoors, satelite
   }



  _crearMarcadores (ScanModel scan) {


   return MarkerLayerOptions(

    markers: <Marker>[
    Marker(
    width: 100.0,
    height: 100.0,
    point: scan.getLatLng(),
    builder: (context) => Container(
    child: Icon(Icons.location_on, 
    size: 70.0,
    color: Theme.of(context).primaryColor
    ),
    

    )

    )


    ]
   );
   
     


  }
}