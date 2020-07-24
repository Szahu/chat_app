import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenterHorizontal extends StatelessWidget {
  CenterHorizontal(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[child],
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitRing(color: Colors.blue, size: 50.0),
      ),
    );
  }
}

Future<void> showDialogBox(
    BuildContext context, String dialogTitle, String dialogText) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return ButtonBarTheme(
        data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
        child: AlertDialog(
          title: CenterHorizontal(
            Text(
              dialogTitle,
              style: TextStyle(
                color: Colors.red[600],
              ),
            ),
          ),
          content: Text(dialogText, style: TextStyle(fontSize: 18.0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Okay',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ],
        ),
      );
    },
  );
}
