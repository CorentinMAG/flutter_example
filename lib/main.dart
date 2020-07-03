import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_by_example/dog_list.dart';
import 'package:provider/provider.dart';

import 'dog_list_model.dart';
import 'dog_model.dart';
import 'new_dog_form.dart';

void main() {
  runApp(
     MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DogListModel>(
      create: (context)=> DogListModel(),
      child: MaterialApp(
        title: 'We Rate Dogs',
        theme: ThemeData(
            brightness: Brightness.dark
        ),
        home: MyHomePage(title: 'We Rate Dogs'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Null> _showNewDogForm() async {
    // push a new route like you did in the last section
    Dog newDog = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddDogFormPage();
        },
      ),
    );
    // A null check, to make sure that the user didn't abandon the form.
    if (newDog != null) {
      setState(() {
        Provider.of<DogListModel>(context,listen: false).addDog(newDog);
      });
      // Add a newDog to our mock dog array.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=>_showNewDogForm(),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          )
        ),
        child: DogList(Provider.of<DogListModel>(context)),
      ),
    );
  }
}
