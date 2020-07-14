import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ContentColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Please make sure that Wi-Fi \n or mobile data is turned on",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
