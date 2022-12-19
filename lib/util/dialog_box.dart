import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({Key? key, this.controller, required this.onSave, required this.onCancel}) : super(key: key);

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //GET USER INPUT

            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add a new task',
                border: OutlineInputBorder(),
              ),
            ),

            //BUTTONS => SAVE, CANCEL
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //SAVE BUTTON
                MyButton(text: 'SAVE', onPressed: onSave),

                //CANCEL BUTTON

                SizedBox(
                  width: 8,
                ),

                MyButton(text: 'CANCEL', onPressed: onCancel)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
