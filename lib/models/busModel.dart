class BusModel{
  String busName;
  String nextHour;
  String waitTime;
  BusModel({this.busName,this.nextHour, this.waitTime});

  BusModel.fromJson(Map<String,dynamic> json) {
    busName=json['busName'];
    nextHour= json['nextHour'];
    waitTime= json['waitTime'];
  }
}