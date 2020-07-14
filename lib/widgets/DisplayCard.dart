import 'package:covid19counter/constants/colors.dart';
import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  const DisplayCard({
    this.title,
    this.value,
    this.icon,
    this.color,
  });
  final String title;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: color,
              letterSpacing: 2,
            ),
          ),
          trailing: Text(
            value.toString(),
            style: TextStyle(
              fontSize: 30,
              color: color,
            ),
          ),
          leading: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
      ),
    );
  }
}
