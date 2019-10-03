import 'dart:async';
import 'package:lapermata_project/halamanlogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lapermata_project/homepages/lapastoday.dart';

class BelumLogin extends StatelessWidget {
  const BelumLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ChatBloc(),
      child: MaterialApp(home: kodeUsers != "" ? MyHomePageSL() : TanpaLogin())
    );
  }
}


class TanpaLogin extends StatefulWidget {
  @override
  _TanpaLoginState createState() => _TanpaLoginState();
}

class _TanpaLoginState extends State<TanpaLogin> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.pinkAccent,
//      color: Color(0xff1066E3),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new HalamanLogin()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/login.png',
                        height: 280.0,
                        width: 280,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        'Oppss !! Anda Belum Login',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'RobotMono'),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      registerButon,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String kodeUsers;
int kodeNavBar;

class ChatBloc with ChangeNotifier {
  Future<void> getKodeUser() async{
     Timer.periodic(Duration(seconds: 1), (t) async{
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        kodeUsers = prefs.getString('kodeUser');
        notifyListeners();
      } catch (e) {
        print(e.error);
      }

  });
} 
}