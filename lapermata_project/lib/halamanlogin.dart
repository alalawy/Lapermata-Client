import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lapermata_project/halamanregister.dart';
import 'package:lapermata_project/home.dart';
import 'package:lapermata_project/homepages/aturkunjungan.dart';
import 'package:lapermata_project/homepages/lapastoday.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'validation.dart';
import 'package:lapermata_project/homepages/belum_login.dart';
import 'package:lapermata_project/homepages/chat.dart';
import 'package:lapermata_project/homepages/akun.dart';
import 'package:lapermata_project/homepages/pantaukeluarga.dart';

class HalamanLogin extends StatefulWidget {
  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

final noHp = TextEditingController();
final password = TextEditingController();
final incorrect = TextEditingController();
final kodePengunjung = TextEditingController();
final tanggalKunjungan = TextEditingController();
final kodeTahanan = TextEditingController();

class _HalamanLoginState extends State<HalamanLogin> with Validation {
  bool _showPassword = true;

  _showHide() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
  final formKey = GlobalKey<FormState>();

  String nomor = '';
  String passwordd = '';

  savePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 850, height: 1500, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 235.0, bottom: 20.0),
                  child: Image.asset("assets/image_02.png"),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 50.0, bottom: 40.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset("assets/logo.png",
                          width: ScreenUtil.getInstance().setWidth(120),
                          height: ScreenUtil.getInstance().setHeight(120)),
                      Text(
                        "LAPERMATA",
                        style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: ScreenUtil.getInstance().setSp(50),
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(80),
                  ),
                  Form(
                    key: formKey,
                    child: new Container(
                      width: double.infinity,
                      //height: ScreenUtil.getInstance().setHeight(695),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 20.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("No.Hp Aktif",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(30))),
                            TextFormField(
                                controller: noHp,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Nomor Hp",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.blue,
                                    )),
                                validator: validateNomorLogin,
                                onSaved: (String value) {
                                  nomor = value;
                                }),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Password",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(30))),
                            TextFormField(
                                controller: password,
                                obscureText: _showPassword,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.blue,
                                    )),
                                validator: validatePasswordLogin,
                                onSaved: (String value) {
                                  passwordd = value;
                                }),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Lihat Password",
                                    style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontFamily: "Poppins-Medium",
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(25)),
                                  ),
                                  onPressed: _showHide,
                                ),
                              ],
                            ),
                            // SizedBox(

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  incorrect.text,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(30)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(500),
                          height: ScreenUtil.getInstance().setHeight(80),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea),
                              ]),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0),
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  onLogin();
                                });
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  child: new Dialog(
                                    child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            new CircularProgressIndicator(),
                                            new Text("Loading"),
                                          ],
                                        )),
                                  ),
                                );
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                                if (formKey.currentState.validate() &&
                                    kodeUsers != '-' &&
                                    kodeUsers != " " &&
                                    kodeUsers != "" &&
                                    kodeUsers != null) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('kodeUser', kodeUsers);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => pilihLogin()));

                                  showDialog(
                                      context: context,
                                      child: new AlertDialog(
                                        title: new Text("Selamat Datang"),
                                        content: new Text(
                                            prefs.getString('kodeUser')),
                                      ));
                                  _incrementCounter();
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  return showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: new Text("Peringatan !"),
                                        content: new Container(
                                          height: 70.0,
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "No HP atau Password Yang Anda Masukkan Salah ! "),
                                              Text(
                                                "Mohon Periksa Kembali.",
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              },
                              child: Center(
                                child: Text("LOGIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Belum Punya Akun? Daftar Sekarang",
                          style: TextStyle(
                              fontSize: 14.0, fontFamily: "Poppins-Medium")),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(500),
                          height: ScreenUtil.getInstance().setHeight(80),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.pink,
                                Colors.orangeAccent,
                              ]),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HalamanRegister()),
                                );
                              },
                              child: Center(
                                child: Text("Buat Akun",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

onLogin() async {
  String urlLoggin = 'http://lapermata.site/api/login';
  Map mapLogin = {'no_telepon': noHp.text, 'password': password.text};
  apiRequest(urlLoggin, mapLogin).toString();
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  kodeUsers = reply;
  httpClient.close();
  return reply;
}

Widget pilihLogin() {
  if (kodeNavBar == 5) {
    return ChatLogin();
  } else if(kodeNavBar == 4){
    return AkunLogin();
  }else if(kodeNavBar == 3){
    return PantauKeluargaLogin();
  }else if(kodeNavBar == 2){
    return AturKunjunganLogin();
  }  else {
    return DashboardSL();
  }
}
