import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tabbarkunjungan/pengajuan.dart' as pengajuan;
import './tabbarkunjungan/riwayat.dart' as riwayat;
import 'package:lapermata_project/homepages/belum_login.dart';

class KunjunganLogin extends StatelessWidget {
  const KunjunganLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => KunjunganBloc(),
        child: MaterialApp(
          home: BuildView(),
        ));
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
    kodeNavBar = 2;
  }

  @override
  Widget build(BuildContext context) {
    return kodeUsers != "" ? AturKunjunganLogin() : BelumLogin();
  }
}

class AturKunjunganLogin extends StatefulWidget {
  @override
  _AturKunjunganLoginState createState() => _AturKunjunganLoginState();
}

class _AturKunjunganLoginState extends State<AturKunjunganLogin>
    with SingleTickerProviderStateMixin {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.blueAccent,
  );
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            'Pengajuan Kunjungan',
            style: TextStyle(fontSize: 18.0),
          ),
          bottom: new TabBar(
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            controller: controller,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(
                  Icons.border_color,
                  size: 20.0,
                ),
                text: 'Form Pengajuan',
              ),
              new Tab(
                icon: new Icon(
                  Icons.view_list,
                  size: 20.0,
                ),
                text: 'Riwayat Pengajuan',
              ),
            ],
          ),
        ),
        body: new Container(
          child: new TabBarView(
            controller: controller,
            children: <Widget>[
              new pengajuan.PengajuanKunjungan(),
              new riwayat.Riwayat(),
            ],
          ),
        ));
  }
}

class KunjunganBloc with ChangeNotifier {
  Future<void> kunjunganLog() async {
    Timer.periodic(Duration(seconds: 1), (t) async {
      try {
        print("");
      } catch (e) {
        print("");
      }
    });
  }
}
