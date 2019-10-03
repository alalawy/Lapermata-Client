import 'package:flutter/material.dart';
import 'package:lapermata_project/halamanlogin.dart';
import 'package:lapermata_project/validation.dart';
import 'empty_state.dart';
import 'form.dart';
import 'user.dart';
import 'form_pengikut.dart';
import 'user_pengikut.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'package:lapermata_project/homepages/belum_login.dart';

ProgressDialog pr;

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

List<UserPengikutForm> usersPengikut = [];
DateTime _date = new DateTime.now();
final kodeTahanan = TextEditingController();
final tanggalKunjungan = TextEditingController();

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];
  bool show = true;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2023));

    if (picked != null && picked != _date) {
      tanggalKunjungan.text = picked.toString();
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  final kodePengunjung = TextEditingController();
  final kodeUser = TextEditingController();

  Future<void> getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    kodeUser.text = prefs.getString('kodeUser');
  }

  @override
  Widget build(BuildContext context) {
    listener();
    getDataLocal();
    _fetchData();

    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Mengirim Data...');

    try {
      kodeTahanan.text = list[0]['tahanan'];
    } catch (e) {
      kodeTahanan.text = "";
    }
    double heightScreen = MediaQuery.of(context).size.height;

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        child:Column(
          children: <Widget>[ Container(
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Isi Formulir",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    FlatButton(
                      color: Colors.lightBlue,
                      splashColor: Colors.white,
                      child: Text(
                        "KIRIM",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        var allValid = true;
                        users.forEach(
                            (form) => allValid = allValid && form.isValid());
                        usersPengikut.forEach(
                            (form) => allValid = allValid && form.isValid());
                        if (allValid && users.length >= 1) {
                          onSave();

                          tampilDialog(context);
                        } else {
                          showDialog(
                              context: context,
                              child: new AlertDialog(
                                title: new Text(
                                  "Tidak Ada Data Atau Data Anda Belum Lengkap !",
                                  style: TextStyle(
                                      color: Colors.lightBlue, fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                                content: new Text(
                                  'Mohon Periksa Kembali Data Pengajuan Anda',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
           
            Flexible(
              flex: 1,
              child:  Container(
                
                child: new SingleChildScrollView(
                  //physics: NeverScrollableScrollPhysics(),
                 
                  child: Container(
                    
                      
                      child: users.length <= 0
                          ? Container(
                             height: heightScreen/1.5,
                             child:Center(
                              child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: EmptyState(
                                title: 'Opss !!',
                                message:
                                    'Silahkan Tambahkan Formulir Pengajuan Kunjungan Anda',
                              ),
                            )
                             )
                           
                            
                              )
                          : new Container(
                           color: Colors.black12,
                             child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Material(
                                    elevation: 1,
                                    clipBehavior: Clip.antiAlias,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Form(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          AppBar(
                                            leading: Icon(Icons.group),
                                            elevation: 0,
                                            title: Text('Set Kunjungan'),
                                            backgroundColor:
                                                Theme.of(context).accentColor,
                                            centerTitle: true,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            child: TextFormField(
                                              enabled: false,
                                              controller: kodeUser,
                                              decoration: InputDecoration(
                                                labelText: 'Kode User',
                                                hintText: 'Kode User',
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 24),
                                            child: TextFormField(
                                              enabled: false,
                                              controller: kodeTahanan,
                                              decoration: InputDecoration(
                                                labelText: 'Kode Tahanan',
                                                hintText: 'Kode Tahanan',
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 24),
                                            child: TextFormField(
                                              enabled: false,
                                              controller: tanggalKunjungan,
                                              decoration: InputDecoration(
                                                hintText: "Tanggal Kunjungan",
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 24),
                                              child: RaisedButton(
                                                color: Colors.lightBlue,
                                                textColor: Colors.white,
                                                child: new Text(
                                                    "Pilih Tanggal Kunjungan"),
                                                onPressed: () {
                                                  _selectDate(context);
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                new ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  addAutomaticKeepAlives: true,
                                  itemCount: users.length,
                                  itemBuilder: (_, i) => users[i],
                                ),
                                new ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  addAutomaticKeepAlives: true,
                                  itemCount: usersPengikut.length,
                                  itemBuilder: (_, i) => usersPengikut[i],
                                ),
                              ],
                            )
                          )
                          
                          ),
                ),
              ),
            ),
          
            
          ],
        ),
      ),
      floatingActionButton: show
          ? new FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: onAddForm,
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.white,
            )
          : new FloatingActionButton(
              child: Icon(Icons.people),
              onPressed: onAddFormPengikut,
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.white,
            ),
    );
  }

  void listener() {
    if (users.length <= 0)
      show = true;
    else
      show = false;

    setState(() {});
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  void onDeletePengikut(UserPengikut _userPengikut) {
    setState(() {
      var find = usersPengikut.firstWhere(
        (it) => it.userPengikut == _userPengikut,
        orElse: () => null,
      );
      if (find != null) usersPengikut.removeAt(usersPengikut.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on add form
  void onAddFormPengikut() {
    setState(() {
      var _userPengikut = UserPengikut();
      usersPengikut.add(UserPengikutForm(
        userPengikut: _userPengikut,
        onDelete: () => onDeletePengikut(_userPengikut),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      usersPengikut.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        String url = 'http://lapermata.site/api/kunjungan/pengunjung/utama';
        Map map = {
          'kode': kodeUser.text,
          'jenis_kartu': data[0].kartuid,
          'nomor_kartu': data[0].nomorid,
          'nama': data[0].fullname,
          'jenis_kelamin': data[0].jk,
          'relasi': data[0].hubkeluarga,
          'alamat': data[0].alamat,
          'no_telepon': data[0].nohp,
          'kamar_kunjungan': '-',
          'keterangan': '-',
          'foto_ktp': data[0].foto_ktp,
          'foto_pengunjung': data[0].foto_selfie
        };
        print(apiRequestUtama(url, map));
      }
    }
  }
}

List list = List();

_fetchData() async {
  final response = await http
      .get("http://lapermata.site/api/data/user/detail/" + kodeUsers);
  if (response.statusCode == 200) {
    list = json.decode(response.body) as List;
    kodeTahanan.text = list[0]['tahanan'];
    //kodeTahanan.text = response.body.toString();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

void saveLog() {
  String urlLogKunjungan = 'http://lapermata.site/api/kunjungan/log';
  Map mapLogKunjungan = {
    'kode': kodeUsers,
    'tanggal_kunjungan': _date.toString(),
    'kode_tahanan': kodeTahanan.text,
    'kode_pengunjung_utama': kodePengunjung.text,
  };
  print(apiRequest(urlLogKunjungan, mapLogKunjungan));

  var dataPengikut = usersPengikut.map((it) => it.userPengikut).toList();
  for (var i = 0; i < dataPengikut.length; i++) {
    String urlPengikut =
        'http://lapermata.site/api/kunjungan/pengunjung/pengikut';
    Map mapPengikut = {
      'id_diikuti': kodePengunjung.text,
      'jenis_kartu': dataPengikut[i].kartuid,
      'nomor_kartu': dataPengikut[i].nomorid,
      'nama': dataPengikut[i].fullname,
      'jenis_kelamin': dataPengikut[i].jk,
      'relasi': dataPengikut[i].hubkeluarga,
      'alamat': dataPengikut[i].alamat,
      'foto_ktp': dataPengikut[i].foto_ktp_pengikut,
      'foto_pengunjung': dataPengikut[i].foto_selfie_pengikut
    };
    print(apiRequest(urlPengikut, mapPengikut));
  }
}

Future<String> apiRequestUtama(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  kodePengunjung.text = reply;
  saveLog();
  httpClient.close();
  return reply;
}

Future<Widget> tampilDialog(context) async {
  pr.show();
  Timer _timer;

  _timer = new Timer(const Duration(milliseconds: 3000), () {
    pr.hide();
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/rocket.gif'),
              title: Text(
                'Pengajuan Berhasil Dikirim, Silahkan Cek Detail Pengajuan Pada Menu Riwayat Pengajuan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              onOkButtonPressed: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new MultiForm();
                }));

                Navigator.of(context, rootNavigator: true).pop();
              },
              buttonOkText: Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
              buttonCancelText: Text(
                'Kembali',
                style: TextStyle(color: Colors.white),
              ),
            ));
  });
}
