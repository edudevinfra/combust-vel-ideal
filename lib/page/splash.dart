import 'package:combustivel_ideal/page/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Text titulo = Text(
      "EDMM COMBUSTÍVEIS",
      style: TextStyle(fontSize: 25.0, color: Colors.green),
    );

    Text version = Text(
      "version 1.0",
      style: TextStyle(fontSize: 10.0, color: Colors.black),
    );

    Container img = Container(
      child: Column(
        children: <Widget>[
          Container(

            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo_splash.png")),
            ),
          ),
        ],
      ),
    );

    Container container = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: titulo,
        ), img, version],
      ),
    );

    Scaffold scaffold = Scaffold(
      body: container,
    );

    return scaffold;
  }
}
