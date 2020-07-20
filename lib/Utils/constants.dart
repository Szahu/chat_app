import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  hintText: 'use .copyWith(hintText: )',
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.only(),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(100.0))),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[200], width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(100.0))),
);

BoxDecoration textInputBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(100.0)),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 4,
      offset: Offset(1, 2), // changes position of shadow
    ),
  ],
);

class DecoratedRaisedButton extends StatelessWidget {
  DecoratedRaisedButton({this.label, this.onPressed});
  final label;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: textInputBoxDecoration.copyWith(color: Colors.transparent),
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: BorderSide(color: Colors.blue, width: 3.0),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 23.0, color: Colors.white),
          ),
          padding: EdgeInsets.symmetric(horizontal: 37.0, vertical: 10.0),
          color: Colors.blue,
          onPressed: onPressed),
    );
  }
}
