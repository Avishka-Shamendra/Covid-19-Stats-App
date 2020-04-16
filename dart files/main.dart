

import 'package:covid19counter/pages/home.dart';
import 'package:covid19counter/pages/location.dart';
import 'package:covid19counter/pages/looadingworld.dart';
import 'package:covid19counter/pages/world.dart';
import 'package:flutter/material.dart';
import 'package:covid19counter/pages/loading.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  theme: ThemeData(fontFamily: 'OpenSans'),
  initialRoute: '/',
  routes: {
    '/':(context)=>Load(),
    '/home':(context)=>Home(),
    '/location':(context)=>ChooseCountry(),
    '/world':(context)=>World(),
    '/loadingworld':(context)=>LoadWorld(),
  },
));
