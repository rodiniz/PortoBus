import 'package:bus_hour/models/busModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BusList extends StatefulWidget {

  BusList({Key key, this.stocks}) : super(key: key);

  final List<BusModel> stocks;

  @override
  State<StatefulWidget> createState() {
    return new _StockListState();
  }
}

class _StockListState extends State<BusList> {

  @override
  Widget build(BuildContext context) {
    return _buildStockList(context, widget.stocks);
  }

  ListView _buildStockList(context, List<BusModel> stocks) {
    return new ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
           var item=stocks[index];  
           if(index==0){
                var listTile = ListTile(
                  title :new Text("Results"),
                  subtitle:  Container(
                      child: Table(  border: TableBorder.all(width: 0.0),
                      children: [                    
                        TableRow(children: [
                          TableCell(child: new Text(item.busName)),
                          TableCell(child: new Text(item.nextHour.toString())),
                          TableCell(child: new Text(item.waitTime.toString())),
                        ])
                        ]
              
                      )),                    
                );
                return listTile;
            }
            else{
            return Container(
               child: Table(  border: TableBorder.all(width: 0.0),
                  children: [                    
                      TableRow(children: [
                        TableCell(child: new Text(item.busName)),
                        TableCell(child: new Text(item.nextHour.toString())),
                        TableCell(child: new Text(item.waitTime.toString())),
                      ])
                      ]
             
                    ),
                  );
            }
      },
    );
  }

}