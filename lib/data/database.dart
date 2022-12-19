import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];

  final _myBox = Hive.box('myBox');

  //RUN THIS METHOD IF THIS IS THE FIRST TIME EVER OPENING THE APP
  void createInitialData() {
    toDoList = [
      ['Make an app', false],
      ['Exercise', false],
    ];
  }

  //LOAD THE DATA FROM DATABASE
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //UPDATE THE DATABASE
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
