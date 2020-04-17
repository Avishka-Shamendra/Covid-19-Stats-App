
import 'dart:convert';
import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:http/http.dart';

class WorldCount{

  Map data;//data to send to home page






  Future<void> getData() async{
    try {
      Response response = await Future.value(get('https://corona.lmao.ninja/v2/all')).timeout(const Duration(seconds: 7));
      this.data = jsonDecode(response.body);
    }catch(e){

    }



  }


}