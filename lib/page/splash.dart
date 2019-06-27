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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 60.0),
            child: Text(
              "EDMM COMBUSTÍVEIS",
              style: TextStyle(fontSize: 30.0, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
          Column(

            children: <Widget>[
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo_splash.png")),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.zero,
                child: Text(
                "version 1.0",
                style: TextStyle(fontSize: 10.0, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
