import 'dart:convert';

import 'package:bus_hour/buslist.dart';
import 'package:bus_hour/models/busModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(    
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Porto Bus Hour'),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
  final String title;
 
  MyHomePage({Key key, this.title}) : super(key: key); 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   
   final items = new List<BusModel>();
   var searchController= TextEditingController();
   bool isLoading= false;
   ProgressDialog pr;
  Future fetchHours(String code ) async {
    final response = await http.get('http://sctpapi.apphb.com/api/SCTP/GetTime?station='+code);
  
    return response;
  }

 Future<void> _refresh() async
  {  
      if(items.length >0){
         _search(null);
      }      
  }

 
  void _search(BuildContext context) async {
   
    try{
      isLoading=true;
     setState(() {});
      fetchHours(searchController.text).then((response){

          Iterable list = json.decode(response.body);
          items.clear();
          items.addAll(list.map((model) => BusModel.fromJson(model)));
          if(items.length==0){
            showAlertDialog('Please check if bus stop code is correct.');
          }
          isLoading=false;
          setState(() {});
        }
     );   
    }
    catch(ex){
      showAlertDialog('Error getting information:' + ex.toString());
    }
    
              
  }
showAlertDialog( String message) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(

    title: Text("Porto Bus Hour"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),   
        actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {showAlertDialog('This app was written by Rodrigo Diniz');},
              child: Text("About"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
        ],     
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(           
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Stop Code",                 
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    :Center(
                      child: new RefreshIndicator(
                        child: new BusList(stocks: items),
                        onRefresh: _refresh,
                      ) 
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {

          
         _search(context);
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.pink,
      ),
      
    );
  }


   void buildSearch(BuildContext context) => _search(context);
}

