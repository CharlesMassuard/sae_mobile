import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget{
  String myText;
  bool myValue;
  ValueChanged<bool> returnValue;
  MyTextButton({required this.myText,required this.myValue,required
  this.returnValue});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => returnValue(myValue),
      child: Text(myText,
          style: const TextStyle(color: Colors.white)),
    );
  }
}
