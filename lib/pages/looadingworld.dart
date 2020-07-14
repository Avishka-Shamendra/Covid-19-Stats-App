import 'package:covid19counter/constants/colors.dart';
import 'package:covid19counter/services/Connection.dart';
import 'package:covid19counter/services/WorldCount.dart';
import 'package:covid19counter/widgets/LoadingPageColumn.dart';
import 'package:flutter/material.dart';

class LoadWorld extends StatefulWidget {
  @override
  _LoadWorldState createState() => _LoadWorldState();
}

class _LoadWorldState extends State<LoadWorld> {
  void setupWoldCount() async {
    try {
      await Connection.getConnection();
      String status = Connection.status;
      if (status == 'connected') {
        WorldCount instance = WorldCount();
        await instance.getData();

        Navigator.pushReplacementNamed(
          context,
          '/world',
          arguments: {
            'Total Cases': instance.data['cases'],
            'Deaths': instance.data['deaths'],
            'Recovered': instance.data['recovered'],
            'Active Cases': instance.data['active'],
            'Updated': instance.data['updated'],
          },
        );
      } else {
        setupWoldCount();
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    setupWoldCount();
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
