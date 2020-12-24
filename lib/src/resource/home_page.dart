import 'package:UberApp/src/bloc/auth_bloc.dart';
import 'package:UberApp/src/events/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ICab"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => BlocProvider.of<AuthBloc>(context).add(AuthEventLoggedOut())
          )
        ],
      ),
      body: Center(
        child: Text("This is Home Page", style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
