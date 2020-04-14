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
          backgroundColor: Colors.grey[800],
          title: Text(
            'COVID-19 STATS',
            style: TextStyle(letterSpacing: 2),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[900],
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[900],
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
          Card(
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: ListTile(
                title: Text(
                  'Total Cases',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber[600],
                    letterSpacing: 2,
                  ),
                ),
                trailing: Text(
                  data['Total Cases'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber[600],
                  ),
                ),
                leading: Icon(
                  Icons.account_box,
                  color: Colors.amber[600],
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: ListTile(
                title: Text(
                  'Deaths',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red[600],
                    letterSpacing: 2,
                  ),
                ),
                trailing: Text(
                  data['Deaths'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red[600],
                  ),
                ),
                leading: Icon(
                  Icons.airline_seat_flat,
                  color: Colors.red[600],
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: ListTile(
                title: Text(
                  'Recovered',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    letterSpacing: 2,
                  ),
                ),
                trailing: Text(
                  data['Recovered'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                leading: Icon(
                  Icons.directions_walk,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Active Cases',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[600],
                            letterSpacing: 2),
                      ),
                    ]),
                trailing: Text(
                  data['Active Cases'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[600],
                  ),
                ),
                leading: Icon(
                  Icons.accessibility,
                  color: Colors.blue[600],
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Last Update: ' +
                DateTime.fromMillisecondsSinceEpoch(data['Updated'])
                    .toString()
                    .substring(0, 16),
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 16
            ),
          ),
        ]))));
  }
}
