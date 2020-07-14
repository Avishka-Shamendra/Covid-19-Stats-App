import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:covid19counter/constants/colors.dart';
import 'package:covid19counter/services/CaseCount.dart';
import 'package:covid19counter/services/Connection.dart';
import 'package:covid19counter/widgets/LoadingPageColumn.dart';
import 'package:flutter/material.dart';
import 'package:covid19counter/services/Defaultcountry.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  Defaultcountry defaultcountry = Defaultcountry();
  final countries = Countries();

  void setupCount() async {
    await Connection.getConnection();
    String status = Connection.status;
    if (status == 'connected') {
      String defcountry = await defaultcountry.getCountry();

      CaseCount instance = CaseCount(countries.resolveName(defcountry));
      await instance.getData();

      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'Country': instance.data['country'],
          'Total Cases': instance.data['cases'],
          'Deaths': instance.data['deaths'],
          'Recovered': instance.data['recovered'],
          'Active Cases': instance.data['active'],
          'url': (instance.data['countryInfo']['iso2']).toLowerCase(),
          'Updated': instance.data['updated'],
          'defCountry': defcountry,
        },
      );
    } else {
      setupCount();
    }
  }

  @override
  void initState() {
    super.initState();
    setupCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ContentColumn(),
      ),
    );
  }
}
