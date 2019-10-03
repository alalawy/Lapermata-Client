import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lapermata_project/homepages/belum_login.dart';
import 'package:provider/provider.dart';

class PantauKeluargaLogin extends StatelessWidget {
  const PantauKeluargaLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => KeluargaBloc(),
      child: MaterialApp(home:  BuildView(),));
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
    kodeNavBar = 3;
  }

  @override
  Widget build(BuildContext context) {
    return kodeUsers != "" ? KeluargaSetelahLogin() : BelumLogin();
  }
}

class KeluargaSetelahLogin extends StatefulWidget {
  @override
  _KeluargaSetelahLoginState createState() => _KeluargaSetelahLoginState();
}

class _KeluargaSetelahLoginState extends State<KeluargaSetelahLogin> {
  var loading = false;
  //final list = new List<DataUser>();


  @override
  void initState() {
    super.initState();
    final mBloc = Provider.of<KeluargaBloc>(context, listen:false);
    mBloc.keluargaLog();
  }

  bool cekloading = false;

  


  List cards;

  Widget dataAktivitas() {
    cards = new List.generate(
        dataAPIAktivitas.length,
        (i) => new CardAktivitas(
              date: dataAPIAktivitas[i]['tanggal'],
              text: dataAPIAktivitas[i]['aktivitas'],
            )).toList();

    ListView dataList = ListView(
      children: this.cards,
    );

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return dataAPIAktivitas[0]['kode_tahanan'] == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : new Scaffold(
        body: StreamBuilder(
          stream: Stream<int>.periodic(Duration(seconds: 1)),
          builder: (context, snapshot){
            return Container(
            child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8.0,
                      ),
                      CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage(
                            'http://lapermata.site/static/images/tahanan/' +
                                dataAPITahanan[0]['foto_tahanan']),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        dataAPITahanan[0]['nama'],
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        dataAPITahanan[0]['alamat'],
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
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
                              colors: [Colors.lightBlue, Colors.deepPurple])),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 48.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Kode Tahanan',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  dataAPITahanan[0]['kode'],
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.blueAccent),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Nomor Berkas',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        dataAPITahanan[0]['nomor_berkas'],
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Nomor Registrasi',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        dataAPITahanan[0]['nomor_registrasi'],
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Tanggal Lahir',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        dataAPITahanan[0]['tanggal_lahir'],
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Tanggal Masuk UPT',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        dataAPITahanan[0]['tanggal_masuk_upt'],
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Tanggal Mulai Ditahan',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        dataAPITahanan[0]['tanggal_mulai_ditahan'],
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Tanggal Bebas',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        dataAPITahanan[0]['tanggal_bebas'] != null ? dataAPITahanan[0]['tanggal_bebas'] : "",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Aktivitas WBP',
                        style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.lightBlue,
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: new StreamBuilder(
                        builder: (context, snapshot){
                          return dataAktivitas();
                        },
                      ),
                    )
                    
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ));
  
          },
        ));
        
        }
}

class CardAktivitas extends StatelessWidget {
  CardAktivitas({this.text, this.date});
  final String text;
  final String date;
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      date,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    new Text(
                      text,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}


  List dataAPIAkun = [
    {
      "foto_selfie": "",
      "nama": "",
      "alamat": "",
      "no_telepon": "",
      "tahanan": "",
      "kode": ""
    }
  ];

  List dataAPITahanan = [
    {
      "kode": "",
      "nama": "",
      "alamat": "",
      "kode_tahanan": "",
      "nomor_registrasi": "",
      "nomor_berkas": "",
      "tanggal_lahir": "",
      "tanggal_masuk_upt": "",
      "tanggal_mulai_ditahan": "",
      "tanggal_bebas": "",
      "foto_tahanan": ""
    }
  ];

  List dataAPIAktivitas = [
    {
     "kode_tahanan": "",
     "tanggal": "",
     "aktivitas": ""
    }
  ];

class KeluargaBloc with ChangeNotifier {
  Future<void> keluargaLog() async{
    Timer.periodic(Duration(seconds: 1), (t) async{
      try {
        await http.get("http://lapermata.site/api/data/user/detail/$kodeUsers").then(
          (a){
            dataAPIAkun = json.decode(a.body);
          },
        );
        Future.delayed(Duration(seconds: 1));
        String kodeTahanan = dataAPIAkun[0]['tahanan'];
        await http.get("http://lapermata.site/api/tahanan/$kodeTahanan").then(
          (b){
            dataAPITahanan = json.decode(b.body);
          },
        );
        String kodeRegistrasi = dataAPITahanan[0]['nomor_registrasi'];
        await http.get("http://lapermata.site/api/log/aktivitas/$kodeRegistrasi").then(
          (c){
            notifyListeners();
            dataAPIAktivitas = json.decode(c.body);
          },
        );
      } catch (e) {
        print("");
      }
    });
  }
}