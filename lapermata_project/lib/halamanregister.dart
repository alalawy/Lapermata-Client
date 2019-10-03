import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapermata_project/halamanlogin.dart';
import 'package:lapermata_project/home.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img1;
import 'package:image/image.dart' as Img2;
import 'package:image/image.dart' as Img3;
import 'package:image/image.dart' as Img4;
import 'validation.dart';
import 'package:random_string/random_string.dart';

ProgressDialog pr;

final kodeTahanan = TextEditingController();

class HalamanRegister extends StatefulWidget {
  @override
  _HalamanRegisterState createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> with Validation {
  final formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  _showHide() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  String nomor = '';
  String nama = '';
  String alamat = '';
  String password = '';
  String keluarga = '';
  File fileKartu;
  File filePemegangKartu;
  Future getImageGalery() async {
    var fileGlr = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img1.Image gambar = Img1.decodeImage(fileGlr.readAsBytesSync());
    Img1.Image gambarKecil = Img1.copyResize(gambar, width: 720, height: 480);

    var compresGambar =
        new File(path.toString() + randomAlphaNumeric(10).toString() + ".jpg")
          ..writeAsBytesSync(Img1.encodeJpg(gambarKecil, quality: 72));

    setState(() {
      fileKartu = compresGambar;
    });
  }

  Future getImageCamera() async {
    var filecmr = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img2.Image gambar = Img2.decodeImage(filecmr.readAsBytesSync());
    Img2.Image gambarKecil = Img2.copyResize(gambar, width: 720, height: 480);

    var compresGambar = new File("$path.jpg")
      ..writeAsBytesSync(Img2.encodeJpg(gambarKecil, quality: 72));
    setState(() {
      fileKartu = compresGambar;
    });
  }

  Future getImageGaleryDua() async {
    var gambarFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final dirTemp = await getTemporaryDirectory();
    final path = dirTemp.path;

    Img3.Image gambar = Img3.decodeImage(gambarFile.readAsBytesSync());
    Img3.Image gambarKecil = Img3.copyResize(gambar, width: 720, height: 720);

    var compresGambar =
        new File(path.toString() + randomAlphaNumeric(10).toString() + ".jpg")
          ..writeAsBytesSync(Img3.encodeJpg(gambarKecil, quality: 72));
    setState(() {
      filePemegangKartu = compresGambar;
    });
  }

  Future getImageCameraDua() async {
    var gambarFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final dirTemp = await getTemporaryDirectory();
    final path = dirTemp.path;

    Img4.Image gambar2 = Img4.decodeImage(gambarFile.readAsBytesSync());
    Img4.Image gambarKecil2 = Img4.copyResize(gambar2, width: 720, height: 360);

    var compresGambar = new File("$path.jpg")
      ..writeAsBytesSync(Img4.encodeJpg(gambarKecil2, quality: 72));
    setState(() {
      filePemegangKartu = compresGambar;
    });
  }

  TextEditingController controllernama = new TextEditingController();
  TextEditingController controlleralamat = new TextEditingController();
  TextEditingController controllerhohp = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllernamakeluarga = new TextEditingController();
  TextEditingController controllersearch = new TextEditingController();

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  List dataAPI;

  Future<String> ambildata(kode) async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://lapermata.site/api/tahanan/filter/" + kode),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPI = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    ambildata("");
  }

  List cards;
  Widget listTahanan() {
    cards = new List.generate(
        dataAPI.length,
        (i) => new Container(
                      child: new Card(
                    child: Container(
                      child: new Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Image.network(
                                "http://lapermata.site/static/images/tahanan/" +
                                    dataAPI[i]['foto_tahanan'],
                                height: 100.0,
                                width: 120.0,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              new Text(
                                dataAPI[i]['nama'],
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(
                                height: 3.0,
                              ),
                              new Text(dataAPI[i]['nomor_registrasi'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12)),
                              new RaisedButton(
                                color: dataAPI[i]['nomor_registrasi'] !=
                                        kodeTahanan.text
                                    ? Colors.grey
                                    : Colors.lightBlue,
                                textColor: Colors.white,
                                splashColor: Colors.lightBlueAccent,
                                onPressed: () async {
                                  kodeTahanan.text =
                                      dataAPI[i]['nomor_registrasi'];
                                  ambildata("");
                                },
                                child: const Text('Pilih',
                                    style: TextStyle(fontSize: 13)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))).toList();
        
    ListView dataList = ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: this.cards,
    );

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1400, allowFontScaling: true);

    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Mengirim Data...');

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/register.png"),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 235.0, bottom: 20.0),
                  child: Image.asset("assets/image_02.png",
                      height: 200.0, width: 350.0),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.0,
                        child: Image.asset("assets/logo.png",
                            width: ScreenUtil.getInstance().setWidth(120),
                            height: ScreenUtil.getInstance().setHeight(120)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        "LAPERMATA",
                        style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: ScreenUtil.getInstance().setSp(50),
                            letterSpacing: .6,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(80),
                  ),
                  new Container(
                    width: double.infinity,
                    //height: ScreenUtil.getInstance().setHeight(1880),
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
                          left: 16.0, right: 16.0, top: 10.0, bottom: 5.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Register",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Nama Lengkap",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(30))),
                            TextFormField(
                                controller: controllernama,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "Nama Lengkap Anda",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.lightBlue,
                                    )),
                                validator: validateNama,
                                onSaved: (String value) {
                                  nama = value;
                                }),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Alamat Lengkap",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(30))),
                            TextFormField(
                                controller: controlleralamat,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "Alamat Lengkap Anda",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.lightBlue,
                                    )),
                                validator: validateAlamat,
                                onSaved: (String value) {
                                  alamat = value;
                                }),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Nomor Hp Aktif",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(30))),
                            TextFormField(
                                controller: controllerhohp,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Nomor Hp Aktif",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.phone_android,
                                      color: Colors.lightBlue,
                                    )),
                                validator: validateNomor,
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
                                controller: controllerpassword,
                                obscureText: _showPassword,
                                decoration: InputDecoration(
                                    hintText: "Buat Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.lightBlue,
                                    )),
                                validator: validatePassword,
                                onSaved: (String value) {
                                  password = value;
                                }),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(5),
                            ),
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
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: new TextFormField(
                                  controller: controllersearch,
                                  decoration: new InputDecoration(
                                      hintText:
                                          "Cari Nama Anggota Keluarga Binaan",
                                      labelText: "Pencarian",
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search,
                                            color: Colors.blueAccent),
                                        onPressed: () {
                                          ambildata(controllersearch);
                                        },
                                      ),
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0))),
                                  onChanged: (String value) async {
                                    keluarga = value;
                                    setState(() {
                                      ambildata(controllersearch.text);
                                    });
                                  }),
                            ),
                            StreamBuilder(
                              builder: (context, snapshot){
                                return Container(
                                  height: 200,
                                  child: listTahanan(),
                                );
                              }),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            fileKartu == null
                                ? Column(
                                    children: <Widget>[
                                      new Text(
                                        "Tidak Ada Gambar Yang Dipilih",
                                        textAlign: TextAlign.center,
                                      ),
                                      new Text(
                                        "Silahkan Upload Gambar Dalam Bentuk Landscape",
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                : StreamBuilder(
                                    builder: (context, snapshot) {
                                      return new Image.file(fileKartu);
                                    },
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: new Column(
                                children: <Widget>[
                                  new RaisedButton(
                                      color: Colors.green,
                                      child: const Text(
                                        "Pilih Gambar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        getImageGalery();
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            filePemegangKartu == null
                                ? Column(
                                    children: <Widget>[
                                      new Text(
                                        "Tidak Ada Gambar Yang Dipilih",
                                        textAlign: TextAlign.center,
                                      ),
                                      new Text(
                                        "Silahkan Upload Gambar Dalam Bentuk Landscape",
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                : StreamBuilder(
                                    builder: (context, snapshot) {
                                      return new Image.file(filePemegangKartu);
                                    },
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: new Column(
                                children: <Widget>[
                                  new RaisedButton(
                                      color: Colors.green,
                                      child: const Text(
                                        "Pilih Gambar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        getImageGaleryDua();
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(50),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      width: ScreenUtil.getInstance()
                                          .setWidth(360),
                                      height: ScreenUtil.getInstance()
                                          .setHeight(70),
                                      decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF6078ea)
                                                    .withOpacity(.3),
                                                offset: Offset(0.0, 8.0),
                                                blurRadius: 8.0),
                                          ]),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            String fotoKartu = base64Encode(
                                                fileKartu.readAsBytesSync());
                                            String fotopemegangKartu =
                                                base64Encode(filePemegangKartu
                                                    .readAsBytesSync());

                                            String url =
                                                'http://lapermata.site/api/register';
                                            Map map = {
                                              'nama': controllernama.text,
                                              'alamat': controlleralamat.text,
                                              'no_telepon': controllerhohp.text,
                                              'password':
                                                  controllerpassword.text,
                                              'tahanan': kodeTahanan.text,
                                              'foto_selfie': fotopemegangKartu,
                                              'foto_ktp': fotoKartu
                                            };

                                            if (formKey.currentState
                                                .validate()) {
                                              print(
                                                await apiRequest(url, map),
                                              );
                                              pr.show();
                                              Future.delayed(
                                                      Duration(seconds: 2))
                                                  .then((onvalue) {
                                                pr.hide();
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      AssetGiffyDialog(
                                                    image: Image.asset(
                                                        'assets/rocket.gif'),
                                                    title: Text(
                                                      'Data Berhasil Dikirim',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    description: Text(
                                                      'Selanjutnya silahkan Verifikasi Nomor Handphone Anda dan Pastikan Nomor Handphone Anda Tetap Aktif, untuk menerima kode verifikasi.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12.0),
                                                    ),

                                                    buttonCancelColor:
                                                        Colors.green,
                                                    buttonCancelText: Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),

                                                    //Button Verifikasi Nomor
                                                    onOkButtonPressed: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              new MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                        return new HalamanRegister();
                                                      }));
                                                    },
                                                    buttonOkColor:
                                                        Colors.blueAccent,
                                                    buttonOkText: Text(
                                                      'Verifikasi Nomor',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                              });
                                            } else {
                                              return showDialog(
                                                  context: context,
                                                  child: AlertDialog(
                                                    title: new Text(
                                                        "Peringatan !"),
                                                    content: new Text(
                                                        "Silahkan isi data dengan lengkap"),
                                                  ));
                                            }
                                          },
                                          child: Center(
                                            child: Text("Kirim",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins-Bold",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    letterSpacing: 1.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          width: ScreenUtil.getInstance().setWidth(280),
                          height: ScreenUtil.getInstance().setHeight(70),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.pink,
                                Colors.orange,
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
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HalamanLogin()));
                              },
                              child: Center(
                                child: Text("Ke Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          width: ScreenUtil.getInstance().setWidth(280),
                          height: ScreenUtil.getInstance().setHeight(70),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.orange,
                                Colors.pink,
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
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar()));
                              },
                              child: Center(
                                child: Text("Lapas Today",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
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

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      title: "Pilih Media",
      buttons: [
        DialogButton(
          child: Icon(
            Icons.image,
            color: Colors.white,
          ),
          onPressed: () {
            getImageGalery();
            Navigator.pop(context);
          },
          gradient: LinearGradient(colors: [Colors.pink, Colors.blue]),
        ),
        DialogButton(
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () {
            getImageCamera();
            Navigator.pop(context);
          },
          gradient:
              LinearGradient(colors: [Colors.pinkAccent, Colors.blueAccent]),
        )
      ],
    ).show();
  }

  _onAlertButtonsPressed2(context) {
    Alert(
      context: context,
      title: "Pilih Media",
      buttons: [
        DialogButton(
          child: Icon(
            Icons.image,
            color: Colors.white,
          ),
          onPressed: () {
            getImageGaleryDua();
            Navigator.pop(context);
          },
          gradient: LinearGradient(colors: [Colors.pink, Colors.blue]),
        ),
        DialogButton(
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () {
            getImageCameraDua();
            Navigator.pop(context);
          },
          gradient:
              LinearGradient(colors: [Colors.pinkAccent, Colors.blueAccent]),
        )
      ],
    ).show();
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

class ListTahanan extends StatefulWidget {
  @override
  _ListTahananState createState() => _ListTahananState();
}

class _ListTahananState extends State<ListTahanan> {
  List dataAPI;

  Future<String> ambildata(kode) async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://lapermata.site/api/tahanan/filter/" + kode),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPI = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata("");
  }

  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: new StreamBuilder(
          builder: (context, snapshot) {
            return new ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dataAPI == null ? 0 : dataAPI.length,
                itemBuilder: (context, i) {
                  return 
                  Container(
                      child: new Card(
                    child: Container(
                      child: new Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Image.network(
                                "http://lapermata.site/static/images/tahanan/" +
                                    dataAPI[i]['foto_tahanan'],
                                height: 100.0,
                                width: 120.0,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              new Text(
                                dataAPI[i]['nama'],
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(
                                height: 3.0,
                              ),
                              new Text(dataAPI[i]['nomor_registrasi'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12)),
                              new RaisedButton(
                                color: dataAPI[i]['nomor_registrasi'] !=
                                        kodeTahanan.text
                                    ? Colors.grey
                                    : Colors.lightBlue,
                                textColor: Colors.white,
                                splashColor: Colors.lightBlueAccent,
                                onPressed: () async {
                                  kodeTahanan.text =
                                      dataAPI[i]['nomor_registrasi'];
                                  ambildata("");
                                },
                                child: const Text('Pilih',
                                    style: TextStyle(fontSize: 13)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
                });
          },
        ));
  }
}
