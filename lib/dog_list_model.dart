import 'package:flutter/cupertino.dart';
import 'package:flutter_by_example/dog_model.dart';

class DogListModel with ChangeNotifier{
  List<Dog> _dogs =[
    Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'),
    Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'),
    Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'),
    Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'),
    Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.')
  ];

  int get length => _dogs.length;
  List<Dog> get items =>[..._dogs];

  Dog getAt(int index){
    return _dogs[index];
  }
  void addDog(Dog dog){
    _dogs.add(dog);
    notifyListeners();
  }
  void updateDog(int rating,int index){
    _dogs[index].rating=rating;
    notifyListeners();
  }
}