import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/homepage.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('myBox');

  runApp(const Todoapp());
}

class Todoapp extends StatelessWidget {
  const Todoapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Homepage(),
      ),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
