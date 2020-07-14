import 'package:covid19counter/constants/colors.dart';
import 'package:covid19counter/widgets/DisplayCard.dart';
import 'package:flutter/material.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  Map data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'COVID-19 STATS',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: backgroundColor,
                backgroundImage: AssetImage('assets/all.png'),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Worldwide Count',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 10),
              DisplayCard(
                icon: Icons.account_box,
                color: Colors.amber[600],
                title: 'Total Cases',
                value: data['Total Cases'],
              ),
              SizedBox(
                height: 7,
              ),
              DisplayCard(
                icon: Icons.airline_seat_flat,
                color: Colors.red[600],
                title: 'Deaths',
                value: data['Deaths'],
              ),
              SizedBox(
                height: 7,
              ),
              DisplayCard(
                icon: Icons.directions_walk,
                color: Colors.green,
                title: 'Recovered',
                value: data['Active Cases'],
              ),
              SizedBox(
                height: 7,
              ),
              DisplayCard(
                icon: Icons.accessibility,
                color: Colors.blue[600],
                title: 'Active Cases',
                value: data['Active Cases'],
              ),
              SizedBox(height: 10),
              Text(
                'Last Update: ' +
                    DateTime.fromMillisecondsSinceEpoch(data['Updated'])
                        .toString()
                        .substring(0, 16),
                style: TextStyle(
                    color: Colors.white, letterSpacing: 2, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
