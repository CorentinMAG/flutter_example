import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dog_detail_page.dart';
import 'dog_model.dart';

class DogCard extends StatefulWidget {
  final Dog dog;
  final int index;

  DogCard(this.dog,this.index);

  @override
  _DogCardState createState() => _DogCardState();
}

class _DogCardState extends State<DogCard> {

  String renderUrl;
  _DogCardState();

  @override
  void initState() {
    super.initState();
    renderDogPic();
  }

  void renderDogPic() async {
    await widget.dog.getImageUrl();
    if(mounted){
      setState(() {
        renderUrl = widget.dog.imageUrl;
      });
    }
  }

  Widget get dogImage{
    var dogAvatar = Hero(
      tag: widget.dog,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(renderUrl ?? '')
            )
        ),
      ),
    );
  var placeholder = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'DOGGO',
      textAlign: TextAlign.center,
    ),
  );
  return AnimatedCrossFade(
  // You pass it the starting widget and the ending widget.
  firstChild: placeholder,
  secondChild: dogAvatar,
  // Then, you pass it a ternary that should be based on your state
  //
  // If renderUrl is null tell the widget to use the placeholder,
  // otherwise use the dogAvatar.
  crossFadeState: renderUrl == null
  ? CrossFadeState.showFirst
      : CrossFadeState.showSecond,
  // Finally, pass in the amount of time the fade should take.
  duration: Duration(milliseconds: 1000),
  );
}



  Widget get dogCard{
    return Container(
      width: 290.0,
      height: 115.0,
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.only(
            top:8.0,
            bottom:8.0,
            left: 64.0
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(widget.dog.name,
              style: Theme.of(context).textTheme.headline),
              Text(widget.dog.location,style: Theme.of(context).textTheme.subhead),
              Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(": ${widget.dog.rating} / 10")
                ],
              )
            ],
          ) ,
        ),
      ),
    );
  }

  showDogDetailPage(){
    Navigator.of(context).push(
      MaterialPageRoute(
        // builder methods always take context!
        builder: (BuildContext context) {
          return DogDetailPage(widget.dog,widget.index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> showDogDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 50.0,
                child: dogCard,
              ),
              Positioned(
                top: 7.5,
                child: dogImage,
              )
            ],
          ),
        ),
      ),
    );
  }
}
