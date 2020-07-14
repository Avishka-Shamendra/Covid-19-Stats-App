import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:covid19counter/constants/colors.dart';
import 'package:covid19counter/services/CaseCount.dart';
import 'package:covid19counter/widgets/DisplayCard.dart';
import 'package:flutter/material.dart';
import 'package:covid19counter/services/Defaultcountry.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  Defaultcountry defaultcountry = Defaultcountry();
  final countries = Countries();

  Future<Map> refreshHome() async {
    CaseCount instance;
    try {
      instance = CaseCount(countries.resolveName(data['defCountry']));
    } catch (e) {}

    await instance.getData();

    return {
      'Country': instance.data['country'],
      'Total Cases': instance.data['cases'],
      'Deaths': instance.data['deaths'],
      'Recovered': instance.data['recovered'],
      'Active Cases': instance.data['active'],
      'url': (instance.data['countryInfo']['iso2']).toLowerCase(),
      'Updated': instance.data['updated'],
      'defCountry': (instance.data['countryInfo']['iso2'].toLowerCase()),
    };
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'COVID-19 STATS',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () async {
              try {
                Map homedata = await refreshHome();
                this.data = homedata;
                setState(
                  () {},
                );
              } catch (e) {
                try {
                  Alert(
                    style: AlertStyle(
                      descStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    context: context,
                    title: "OOPS!",
                    desc: "Lost Internet Connection.",
                    image: Image.asset("assets/oops.jpg"),
                  ).show();
                } catch (e1) {}
              }
            },
          )
        ],
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
                backgroundImage: AssetImage(
                  'assets/${data['url']}.png',
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  data['Country'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 2,
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
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Opacity(
                opacity: (data['defCountry'] == data['url']) ? 0 : 1,
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: (data['defCountry'] != data['url'])
                      ? () async {
                          Alert(
                            style: AlertStyle(
                              descStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            context: context,
                            title: "ALERT",
                            desc:
                                "Are you sure you want to change the default country?",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () async {
                                  await defaultcountry.setCountry(data['url']);
                                  data['defCountry'] = data['url'];
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                              DialogButton(
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ).show();
                        }
                      : null,
                  label: Text(
                    'Set this as Default Country',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
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
              SizedBox(
                height: 7,
              ),
              FlatButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(
                      () {
                        try {
                          data = {
                            'Country': result['Country'],
                            'Total Cases': result['Total Cases'],
                            'Deaths': result['Deaths'],
                            'Recovered': result['Recovered'],
                            'Active Cases': result['Active Cases'],
                            'url': (result['url']).toLowerCase(),
                            'Updated': result['Updated'],
                            'defCountry': result['defCountry'],
                          };
                        } catch (e) {
                          data = data;
                        }
                      },
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Search Country',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              FlatButton.icon(
                onPressed: () async {
                  try {
                    Navigator.pushNamed(context, '/loadingworld');
                  } catch (e) {}
                },
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                label: Text(
                  'See Worldwide Stats',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
