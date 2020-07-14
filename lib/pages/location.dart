import 'dart:async';
import 'package:covid19counter/constants/colors.dart';
import 'package:covid19counter/services/CaseCount.dart';
import 'package:covid19counter/services/Defaultcountry.dart';
import 'package:flutter/material.dart';
import 'package:covid19counter/services/Countires.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChooseCountry extends StatefulWidget {
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  Defaultcountry defaultcountry = Defaultcountry();
  bool condition = true;
  TextEditingController editingController = TextEditingController();
  List countries = Countries().getCountries();
  var items = List(); //copy for the countries to search

  @override
  void initState() {
    items.addAll(countries);
    super.initState();
  }

  void filterSearchResults(String query) {
    List dummySearchList = List();
    dummySearchList.addAll(countries);
    if (query.isNotEmpty) {
      List dummyListData = List();
      for (int i = 0; i < dummySearchList.length; i++) {
        if ((dummySearchList[i]['name'])
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(dummySearchList[i]);
        }
      }

      setState(
        () {
          items.clear();
          items.addAll(dummyListData);
        },
      );
      return;
    } else {
      setState(
        () {
          items.clear();
          items.addAll(countries);
        },
      );
    }
  }

  void updateLocation(index) async {
    try {
      String defcountry = await defaultcountry.getCountry();
      CaseCount instance = CaseCount(items[index]['name']);
      await instance.getData();

      Navigator.pop(
        context,
        {
          'Country': instance.data['country'],
          'Total Cases': instance.data['cases'],
          'Deaths': instance.data['deaths'],
          'Recovered': instance.data['recovered'],
          'Active Cases': instance.data['active'],
          'url': instance.data['countryInfo']['iso2'].toLowerCase(),
          'Updated': instance.data['updated'],
          'defCountry': defcountry,
        },
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
          desc: "We currently don't have data about that country.",
          image: Image.asset("assets/oops.jpg"),
        ).show();
      } catch (e1) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'COVID-19 STATS',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: TextField(
              autocorrect: false,
              cursorColor: Colors.white,
              textCapitalization: TextCapitalization.words,
              style: TextStyle(
                  color: Colors.white, fontSize: 22, letterSpacing: 2),
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  hintText: 'Search Country',
                  hintStyle: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 20,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey[100],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Card(
                    color: secondaryColor,
                    child: ListTile(
                      onTap: condition
                          ? () {
                              setState(() {
                                condition = false;
                              });
                              try {
                                Timer(Duration(seconds: 3), () {
                                  if (mounted) {
                                    setState(() {
                                      condition = true;
                                    });
                                  }
                                });
                              } catch (e) {}
                              updateLocation(index);
                            }
                          : null,
                      title: Text(
                        items[index]['name'],
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: secondaryColor,
                        backgroundImage: AssetImage(
                            'assets/${items[index]['code'].toLowerCase()}.png'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
