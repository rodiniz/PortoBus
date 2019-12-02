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
                return ListTile(
                title :new Text("Results") ,                    

                subtitle: new Text(item.busName + '\t\t' + item.nextHour.toString()+ '\t\t' + item.waitTime.toString()),                       


              );
            }
            else {
                 return ListTile(                         

                        subtitle: new Text(item.busName + '\t\t' + item.nextHour.toString()+ '\t\t' + item.waitTime.toString()),                       


                      );                     

            }
      },
    );
  }

}