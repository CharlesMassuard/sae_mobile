import 'dart:ui';

import 'package:flutter/material.dart';

class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo({required this.userId,required this.id,required this.title,required this.completed});

  static Todo fromJson(Map<String, dynamic> json){
    final Color clr;
    clr = Colors.greenAccent;
    return Todo(userId: json["userId"], id: json["id"], title: json["title"], completed: json["completed"]);
  }
}