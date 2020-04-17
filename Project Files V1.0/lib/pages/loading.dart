import 'dart:io';

import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:covid19counter/services/CaseCount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19counter/services/Defaultcountry.dart';
class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  Defaultcountry defaultcountry=Defaultcountry();
  final countries=Countries();
  
  void setupCount() async{

    await Connection.getConnection();
    String status=Connection.status;
    if(status=='connected'){
    String defcountry=await defaultcountry.getCountry();
    
    CaseCount instance=CaseCount(countries.resolveName(defcountry));
    await instance.getData();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
        'Country':instance.data['country'],
        'Total Cases':instance.data['cases'],
        'Deaths':instance.data['deaths'],
        'Recovered':instance.data['recovered'],
        'Active Cases':instance.data['active'],
        'url':(instance.data['countryInfo']['iso2']).toLowerCase(),
        'Updated':instance.data['updated'],
        'defCountry':defcountry,

    });}else{setupCount();}
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupCount();
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