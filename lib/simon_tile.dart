import 'package:flutter/material.dart';

class SimonTile extends StatelessWidget {
  final Color color;
  final String name;
  final Function onTap;
  final BoxShadow clickedShadow;
  SimonTile({this.color, this.name, this.onTap, this.clickedShadow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.height / 5,
        height: MediaQuery.of(context).size.height / 5,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black,
            width: 10.0,
          ),
          color: color,
          boxShadow: [clickedShadow],
        ),
      ),
    );
  }
}
