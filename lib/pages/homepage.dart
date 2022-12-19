import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import '../util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();
  int time = 2;

  @override
  void initState() {
    //IF THIS IS THE FIRST TIME EVER PENING THE APP, THEN DEFAULT DATA
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //THERE ALREADY EXISTS DATA
      db.loadData();
    }
    db.updateDatabase();

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      if (db.toDoList[index][1]) {
        _confetticontroller.play();
      } else {
        _confetticontroller.stop();
      }
    });
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //CREATE A NEW TASK
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  final _confetticontroller = ConfettiController();

  @override
  void dispose() {
    super.dispose();
    _confetticontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_confetticontroller.state == ConfettiControllerState.playing) {
          _confetticontroller.stop();
        } else {
          _confetticontroller.play();
        }
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
              appBar: AppBar(
                title: Center(child: Text('TO DO')),
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.deepPurple[300],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Text(db.toDoList.length.toString()),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: createNewTask,
                child: Icon(Icons.add),
              ),
              backgroundColor: Colors.deepPurple[200],
              body: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ListView.builder(
                    itemCount: db.toDoList.length,
                    itemBuilder: (context, index) {
                      return ToDoTile(
                        taskName: db.toDoList[index][0],
                        taskCompleted: db.toDoList[index][1],
                        onChanged: (value) => checkBoxChanged(value, index),
                        deleteFunction: (context) => deleteTask(index),
                      );
                    }),
              )),
          ConfettiWidget(
            confettiController: _confetticontroller,
            blastDirection: pi / 2,
            emissionFrequency: 0.4,
          )
        ],
      ),
    );
  }
}
