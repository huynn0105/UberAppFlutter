import 'package:flutter/material.dart';
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("This is Splash Page",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
