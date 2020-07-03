import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_by_example/dog_card.dart';
import 'package:flutter_by_example/dog_model.dart';
import 'package:provider/provider.dart';

import 'dog_list_model.dart';

class DogList extends StatefulWidget {

  final DogListModel doggos;
  DogList(this.doggos);

  @override
  _DogListState createState() => _DogListState(doggos);
}

class _DogListState extends State<DogList> {
  DogListModel doggos;
  _DogListState(this.doggos);

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context){
    return ListView.builder(
        itemCount: doggos.length,
        itemBuilder: (context,index){
          return DogCard(doggos.getAt(index),index);
        });
  }
}

