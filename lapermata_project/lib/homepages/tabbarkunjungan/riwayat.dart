import 'dart:async';
import 'dart:convert';
//import 'detaillogkunjungan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lapermata_project/halamanlogin.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lapermata_project/homepages/belum_login.dart';

class Riwayat extends StatelessWidget {
  const Riwayat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => KeluargaBloc(),
        child: MaterialApp(
          home: RiwayatPengajuan(),
        ));
  }
}

class DetailKeluargaBinaan extends StatefulWidget {
  var data;
  DetailKeluargaBinaan(this.data);
  @override
  _DetailKeluargaBinaanState createState() =>
      _DetailKeluargaBinaanState(this.data);
}

final kodePengunjungUtama = TextEditingController();

class _DetailKeluargaBinaanState extends State<DetailKeluargaBinaan> {
  var data;
  _DetailKeluargaBinaanState(this.data);

  String news = '';

  List dataAPITahanan = [
    {
      "nama": "",
      "alamat": "",
      "foto_tahanan": "",
      "nomor_registrasi": "",
      "kode": ""
    }
  ];

  List dataAPILog = [
    {
      "kode_tahanan": "",
    }
  ];

  Future<void> ambildataLog() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(
            "http://lapermata.site/api/kunjungan/log/list/" + kodeUsers),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPILog = json.decode(hasil.body);
    });
    await Future.delayed(const Duration(seconds: 1));
    ambildata();
  }

  Future<void> ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://lapermata.site/api/tahanan/" +
            dataAPILog[0]['kode_tahanan']),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPITahanan = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    super.initState();
    this.ambildataLog();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          dataAPITahanan[0]['kode'] != ""
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(
                          "http://lapermata.site/static/images/tahanan/" +
                              dataAPITahanan[0]['foto_tahanan']),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      dataAPITahanan[0]['nama'],
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      dataAPITahanan[0]['alamat'],
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              : CircularProgressIndicator(),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Kode Keluarga Binaan : ' + dataAPITahanan[0]['kode'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          kodeTahanan.text,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DetailPengunjungUtama extends StatefulWidget {
  var data;
  DetailPengunjungUtama(this.data);
  @override
  _DetailPengunjungUtamaState createState() =>
      _DetailPengunjungUtamaState(this.data);
}

class _DetailPengunjungUtamaState extends State<DetailPengunjungUtama> {
  var data;

  _DetailPengunjungUtamaState(this.data);

  List dataAPIUtama = [
    {
      "nama": "",
      "alamat": "",
      "jenis_kelamin": "",
      "relasi": "",
      "kode": "",
      "no_telepon": "",
      "jenis_kartu": "",
      "foto_pengunjung": "",
      "foto_ktp": "",
    }
  ];

  Future<void> ambildataPengunjungUtama() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(
            "http://lapermata.site/api/kunjungan/log/detail/utama/" + data),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPIUtama = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    super.initState();
    ambildataPengunjungUtama();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: dataAPIUtama[0]['kode'] != ""
          ? Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  CircleAvatar(
                    radius: 70.0,
                    backgroundImage: NetworkImage(
                        "http://lapermata.site/static/images/kunjungan/" +
                            dataAPIUtama[0]['foto_pengunjung']),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Alamat",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Jenis Kelamin",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Relasi",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "No.Hp",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Kartu",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              ":",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ":",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ":",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ":",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ":",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ":",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dataAPIUtama[0]['nama'],
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              dataAPIUtama[0]['alamat'],
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              dataAPIUtama[0]['jenis_kelamin'],
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              dataAPIUtama[0]['relasi'],
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              dataAPIUtama[0]['no_telepon'],
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              dataAPIUtama[0]['jenis_kartu'],
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        "http://lapermata.site/static/images/kunjungan/" +
                            dataAPIUtama[0]['foto_ktp'],
                        height: 220.0,
                        width: 360.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}

class DetailPengikut extends StatefulWidget {
  var data;
  DetailPengikut(this.data);
  @override
  _DetailPengikutState createState() => _DetailPengikutState(this.data);
}

class _DetailPengikutState extends State<DetailPengikut> {
  var data;

  _DetailPengikutState(this.data);

  List dataAPIPengikut = [
    {
      "nama": "",
      "alamat": "",
      "jenis_kelamin": "",
      "relasi": "",
      "foto_pengunjung": "",
    }
  ];

  Future<void> ambildataPengunjungUtama() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(
            "http://lapermata.site/api/kunjungan/log/detail/pengikut/" + data),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPIPengikut = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    super.initState();

    ambildataPengunjungUtama();
  }

  Widget dataPengikutList() {
    List cards = new List.generate(
        dataAPIPengikut.length,
        (i) => new PengikutCard(
            foto: dataAPIPengikut[i]['foto_pengunjung'],
            nama: dataAPIPengikut[i]['nama'],
            alamat: dataAPIPengikut[i]['alamat'],
            jenisKelamin: dataAPIPengikut[i]['jenis_kelamin'],
            relasi: dataAPIPengikut[i]['relasi'])).toList();

    ListView dataList = ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: cards);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            dataAPIPengikut.length > 0 ? dataPengikutList() : Container(),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}

class PengikutCard extends StatelessWidget {
  final String foto;
  final String nama;
  final String alamat;
  final String jenisKelamin;
  final String relasi;

  PengikutCard(
      {this.foto, this.nama, this.alamat, this.jenisKelamin, this.relasi});

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(
                    "http://lapermata.site/static/images/kunjungan/" + foto),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          "Alamat",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          "Jenis Kelamin",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          "Relasi",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          ":",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          ":",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          ":",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          ":",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          nama,
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          alamat,
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          jenisKelamin,
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          relasi,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RiwayatPengajuan extends StatefulWidget {
  @override
  _RiwayatPengajuanState createState() => _RiwayatPengajuanState();
}

class _RiwayatPengajuanState extends State<RiwayatPengajuan> {
  var kodeKeluargaBinaan;

  var loading = false;

  Future<void> hapusLog(kodeHapus) async {
    http.Response hasil = await http.get(
        Uri.encodeFull(
            "http://lapermata.site/api/kunjungan/log/deletep/" + kodeHapus),
        headers: {"Accept": "aplication/json"});
    this.setState(() {});
    await Future.delayed(const Duration(seconds: 1));
  }

  _onAlertButtonsPressed(context, kodeHapus) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Hapus Pengajuan ",
      desc: "Apakah Pengajuan Ini Akan Dihapus ?",
      buttons: [
        DialogButton(
          child: Text(
            "Iya",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            hapusLog(kodeHapus);
            Navigator.of(context, rootNavigator: true).pop();
          },
          gradient: LinearGradient(colors: [
            Colors.deepPurpleAccent,
            Colors.lightBlue,
          ]),
        ),
        DialogButton(
          child: Text(
            "Tidak",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          gradient: LinearGradient(colors: [
            Colors.lightBlue,
            Colors.deepPurpleAccent,
          ]),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final mBloc = Provider.of<KeluargaBloc>(context, listen: false);
    mBloc.keluargaLog();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
          body: StreamBuilder(
            builder: (context, snapshot) {
              return listLogData();
            },
          ),
        );
  }

  List dataGenerateLog;

  Widget statusData(int i){
    if(dataAPILog[i]['status'] == 0){
      return Text('DIAJUKAN', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 14.0, color: Colors.black38));
    }
    else if(dataAPILog[i]['status'] == 1){
        return Text("DISETUJUI", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 14.0, color: Colors.black));
    }
    else {
        return Text("DATANG", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 14.0, color: Colors.black));
    }
  }

  Widget listLogData() {
    dataGenerateLog = new List.generate(
        dataAPILog.length,
        (i) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.lightBlue.withOpacity(.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Text("Kode Pengunjung Utama"),
                              // Text(dataLog.kodePngunjungUtama.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                              // Text("Kode Keluarga Binaan"),
                              //Text(dataLog.kodeTahanan.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Kode Log Kunjungan"),
                              Text(dataAPILog[i]['kode'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0)),
                              Text("Tanggal Kunjungan"),
                              Text(dataAPILog[i]['tanggal_kunjungan'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue,
                                      fontSize: 13.0)),
                              SizedBox(
                                height: 5.0,
                              ),

                              InkWell(
                                  child: Container(
                                height: 30.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) => new Scaffold(
                                                        appBar: new AppBar(
                                                          backgroundColor:
                                                              Colors.lightBlue,
                                                          title: Text(
                                                            'Detail Pengajuan Kunjungan',
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ),
                                                        ),
                                                        body: Container(
                                                          child: ListView(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Flexible(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                "Status",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                "Tgl Kunjungan",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                "Kode User",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                "Kode Kunjungan",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 28.0,
                                                                              ),
                                                                              Text(
                                                                                "Kode Pengunjung Utama",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                "Kode Keluarga Binaan",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5.0,
                                                                        ),
                                                                        Flexible(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Text(
                                                                                ":",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                ":",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                ":",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                ":",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 28.0,
                                                                              ),
                                                                              Text(
                                                                                ":",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 28.0,
                                                                              ),
                                                                              Text(
                                                                                ":",
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5.0,
                                                                        ),
                                                                        Flexible(
                                                                          flex:
                                                                              3,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              statusData(i),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                dataAPILog[i]['tanggal_kunjungan'],
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                dataAPILog[i]['kode_user'],
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                dataAPILog[i]['kode'],
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                dataAPILog[i]['kode_pengunjung_utama'],
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              Text(
                                                                                dataAPILog[i]['kode_tahanan'],
                                                                                style: TextStyle(fontSize: 14.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      height:
                                                                          8.0,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.0,
                                                                    ),
                                                                    Text(
                                                                      "Detail Keluarga Binaan",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      "( Yang Akan Dikunjungi/Jenguk )",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.0,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                    DetailKeluargaBinaan(
                                                                        dataAPILog[i]
                                                                            [
                                                                            'kode_tahanan']),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          right:
                                                                              20.0,
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              10.0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            4.0,
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
                                                                    Text(
                                                                      "Detail Pengunjung Utama",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.lightBlue),
                                                                    ),
                                                                    DetailPengunjungUtama(
                                                                        dataAPILog[i]
                                                                            [
                                                                            'kode_pengunjung_utama']),
                                                                    SizedBox(
                                                                      height:
                                                                          10.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          right:
                                                                              20.0,
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              10.0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            4.0,
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
                                                                    SizedBox(
                                                                      height:
                                                                          10.0,
                                                                    ),
                                                                    Text(
                                                                      "Detail Pengikut",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.lightBlue),
                                                                    ),
                                                                    DetailPengikut(
                                                                        dataAPILog[i]
                                                                            [
                                                                            'kode_pengunjung_utama']),
                                                                    SizedBox(
                                                                      height:
                                                                          10.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          right:
                                                                              20.0,
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              10.0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            4.0,
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
                                                                    Text(
                                                                      "QR Code",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.lightBlue),
                                                                    ),
                                                                    dataAPILog[i]['status'] == 1 ? new QrImage(
                                                                      data: dataAPILog[
                                                                              i]
                                                                          [
                                                                          'kode'],
                                                                      size:
                                                                          250.0,
                                                                    ) : SizedBox(),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )));
                                    },
                                    child: Center(
                                      child: Text(
                                        "Detail Selengkapnya",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Status"),
                          statusData(i),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: dataAPILog[i]['status'] == 0
                              ? CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    splashColor: Colors.red,
                                    onPressed: () {
                                      _onAlertButtonsPressed(
                                          context, dataAPILog[i]['kode']);
                                    },
                                  ),
                                )
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList();

    ListView dataList = ListView(
      children: this.dataGenerateLog,
    );

    return dataList;
  }
}

List dataAPILog = [
  {
    "kode_tahanan": "",
    "kode": "",
    "kode_user": "",
    "tanggal_kunjungan": "",
    "kode_pengikut_utama": "",
    "status": ""
  }
];

List dataAPITahanan = [
  {
    "nama": "",
    "alamat": "",
    "foto_tahanan": "",
    "nomor_registrasi": "",
    "kode": ""
  }
];

class KeluargaBloc with ChangeNotifier {
  Future<void> keluargaLog() async {
    Timer.periodic(Duration(seconds: 1), (t) async {
      try {
        await http
            .get("http://lapermata.site/api/kunjungan/log/list/$kodeUsers")
            .then(
          (a) {
            dataAPILog = json.decode(a.body);
          },
        );
        Future.delayed(Duration(seconds: 1));
        String kodeTahanan = dataAPILog[0]['kode_tahanan'];
        await http.get("http://lapermata.site/api/tahanan/$kodeTahanan").then(
          (b) {
            notifyListeners();
            dataAPITahanan = json.decode(b.body);
          },
        );
      } catch (e) {
        print("");
      }
    });
  }
}
