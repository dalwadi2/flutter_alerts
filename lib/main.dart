import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _state createState() => new _state();
}

enum answers { YES, NO, MAYBE }

class _state extends State<MyApp> {
  String value = '';

  void setValue(String myValue) {
    setState(() {
      value = myValue;
    });
  }

  Future askUser() async {
    switch (await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text('Do you like Flutter?'),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('Yes !!!'),
              onPressed: () => Navigator.pop(context, answers.YES),
            ),
            new SimpleDialogOption(
              child: new Text('No :('),
              onPressed: () => Navigator.pop(context, answers.NO),
            ),
            new SimpleDialogOption(
              child: new Text('Maybe :|'),
              onPressed: () => Navigator.pop(context, answers.MAYBE),
            )
          ],
        ))) {
      case answers.YES:
        setValue('Yes');
        break;
      case answers.NO:
        setValue('No');
        break;
      case answers.MAYBE:
        setValue('Maybe');
        break;
    }
  }

  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  void showSnackbar() {
    scaffoldState.currentState
        .showSnackBar(new SnackBar(content: new Text('This is snackbar')));
  }

  Future showAletDialog(BuildContext context, String message) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        ));
  }

  void showBottomBar() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext cotext) {
          return new Container(
            padding: EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Information',
                  style: new TextStyle(color: Colors.red),
                ),
                new RaisedButton(
                  onPressed: () => Navigator.pop(cotext),
                  child: new Text('Close'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text('My Title'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Hello World!'),
              new RaisedButton(
                onPressed: showBottomBar,
                child: new Text('Open BottomBar'),
              ),
              new RaisedButton(
                onPressed: showSnackbar,
                child: new Text('Snackbar'),
              ),
              new RaisedButton(
                onPressed: () => showAletDialog(context, 'Flutter Altert Box'),
                child: new Text('Alert Dialog'),
              ),
              new RaisedButton(
                onPressed: () => askUser(),
                child: new Text('Custom Alert Dialog'),
              ),
              new Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
