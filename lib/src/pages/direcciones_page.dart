import 'package:flutter/material.dart';
import 'package:scanner_sqlite/src/block/scans_block.dart';
import 'package:scanner_sqlite/src/models/scan_model.dart';
import 'package:scanner_sqlite/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  
  @override
  Widget build(BuildContext context) {


    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (context, AsyncSnapshot<List<ScanModel>> snapshot)
      {
                      
           if(!snapshot.hasData)
       {
           return Center(child: CircularProgressIndicator());
         }else{
             
          final scans = snapshot.data;


          if(scans.length == 0)
          {
            return Center(child: Text('No hay información'));
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              child: ListTile(leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () =>  utils.launchURL(scans[i], context)),
              onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
             )
              
            
            );
        

         }
   


      });
  }
}