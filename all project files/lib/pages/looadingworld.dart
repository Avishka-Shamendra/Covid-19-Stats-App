import 'dart:io';

import 'package:covid19counter/services/CaseCount.dart';
import 'package:covid19counter/services/WorldCount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19counter/services/Defaultcountry.dart';
class LoadWorld extends StatefulWidget {
  @override
  _LoadWorldState createState() => _LoadWorldState();
}

class _LoadWorldState extends State<LoadWorld> {


  void setupWoldCount() async{
    try{
    await Connection.getConnection();
    String status=Connection.status;
    if(status=='connected'){

      WorldCount instance=WorldCount();
      await instance.getData();

      Navigator.pushReplacementNamed(context, '/world', arguments: {

        'Total Cases':instance.data['cases'],
        'Deaths':instance.data['deaths'],
        'Recovered':instance.data['recovered'],
        'Active Cases':instance.data['active'],
        'Updated':instance.data['updated'],


      });}else{setupWoldCount();}}
      catch(e){}
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupWoldCount();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[ SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
              SizedBox(height: 30,),
              Text(
                "Please make sure that Wi-Fi \n or mobile data is turned on",
                style: TextStyle(
                  color: Colors.white,

                ),
              ),
            ]),

      ),
    );
  }
}


class Connection{
  static String status;

  static getConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status='connected';
      }
    } on SocketException catch (_) {
      status='not connected';
    }
  }
}