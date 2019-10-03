import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lapermata_project/homepages/belum_login.dart';

class AkunLogin extends StatelessWidget {
  const AkunLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home:  BuildView(),);
  }
}

class BuildView extends StatefulWidget {
  BuildView({Key key}) : super(key: key);

  BuildViewState createState() => BuildViewState();
}

class BuildViewState extends State<BuildView> {

  @override
  void initState() {
    super.initState();
    kodeNavBar = 4;
  }

  @override
  Widget build(BuildContext context) {
    return kodeUsers != "" ? AkunSetelahLogin() : BelumLogin();
  }
}


class AkunSetelahLogin extends StatefulWidget {
  @override
  _AkunSetelahLoginState createState() => _AkunSetelahLoginState();
}

class _AkunSetelahLoginState extends State<AkunSetelahLogin> {
  var loading = false;
  //final list = new List<DataUser>();

  List dataAPIAkun = [{
    "foto_selfie": "",
    "nama": "",
    "alamat": "",
    "no_telepon": "",
    "tahanan": "",
    "kode": ""
  }];


   @override
  void initState() {
    super.initState();
    ambildataAkun();
  }

  Future<void> ambildataAkun() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(
            'http://lapermata.site/api/data/user/detail/' + kodeUsers),
        headers: {"Accept": "aplication/json"});
    if (this.mounted){
      setState(() {
      dataAPIAkun = json.decode(hasil.body);
    });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : new Scaffold(
            body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/background.jpg"),
                )),
              ),
              new Container(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text("Profile Pengguna", style:TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0)),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Column(children: <Widget>[
                              Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                                        child: CircleAvatar(
                                          radius: 90.0,
                                          backgroundImage: NetworkImage(
                                              'http://lapermata.site/static/images/kunjungan/' +
                                                  dataAPIAkun[0]['foto_selfie']),
                                        ),
                                      ),
                                    
                                 
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    dataAPIAkun[0]['nama'],
                                    style: TextStyle(
                                        fontSize: 24.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    dataAPIAkun[0]['alamat'],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32.0, right: 32.0, top: 10.0),
                                    child: Container(
                                      height: 4.0,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                            Colors.lightBlue,
                                            Colors.deepPurple
                                          ])),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32.0, right: 32.0),
                                         child: Column(
                                              children: <Widget>[
                                                Text(
                                                  dataAPIAkun[0]['no_telepon'],
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      color: Colors.blueAccent),
                                                ),
                                                Text(
                                                  'Nomor Telepon',
                                                  style:
                                                      TextStyle(color: Colors.grey),
                                                ),
                                                SizedBox(height: 16.0),

                                                 Text(
                                        dataAPIAkun[0]['kode'],
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.black),
                                      ),
                                      Text(
                                        'Kode User',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(height: 16.0),

                                      Text(
                                        dataAPIAkun[0]['tahanan'],
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.black),
                                      ),
                                      Text(
                                        'Kode Keluarga Binaan',
                                        style: TextStyle(color: Colors.grey),
                                      ),



                                              ],
                                            ),
                                          
                                  ),
                                 
                                ],
                              ),
                            ]),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ));
        }
}

