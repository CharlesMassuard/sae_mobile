import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api/myapi.dart';

import 'models/task.dart';

class Ecran3 extends StatelessWidget{
  final myApi = MyAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myApi.getTodos(),
        builder: (context,snapshot) {
          if ( snapshot.connectionState!=ConnectionState.done && !snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot?.error.toString()??"Error"));
          }
          if(snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data?.length??0,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.lightBlue,child: Text(snapshot.data?[index].id.toString()??""),),
                      title: Text(snapshot.data?[index].title??""),
                    ),
                  );
                });
          }
          return Container();
        }
    );
  }

}
