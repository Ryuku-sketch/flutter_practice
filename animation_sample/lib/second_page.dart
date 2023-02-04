import 'package:flutter/material.dart';

///
/// Simple Page for the transition from notification
///
class SecondPage extends StatelessWidget {
  const SecondPage({required this.taskName, Key? key}) : super(key: key);

  final String taskName;

  @override
  Widget build(BuildContext context) {
    String displayText =
        taskName.isNotEmpty ? taskName : 'It returns empty String';
    return Scaffold(
        body: Center(
      child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          color: Colors.lightGreen,
          child: Text(
            displayText,
            style: const TextStyle(fontSize: 30, color: Colors.black),
          )),
    ));
  }
}
