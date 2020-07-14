import 'dart:convert';
import 'dart:io';
import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:http/http.dart';

class CaseCount {
  final countries = Countries();
  String country; //country to display on the UI
  String url; //code to call for country
  Map data; //data to send to home page

  CaseCount(String country) {
    this.country = country;
    this.url = countries.resolveCode(this.country);
  }

  Future<void> getData() async {
    try {
      Response response =
          await get('https://corona.lmao.ninja/v2/countries/$url');
      if (response != null) {
        this.data = jsonDecode(response.body);
      }
    } catch (e) {}
  }
}
