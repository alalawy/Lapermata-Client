import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lapermata_project/homepages/tabbarkunjungan/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img1;
import 'package:image/image.dart' as Img2;
import 'package:image/image.dart' as Img3;
import 'package:image/image.dart' as Img4;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:random_string/random_string.dart';

typedef OnDelete();

final foto_ktp_utama = TextEditingController();
final foto_selfie_utama = TextEditingController();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  List<UserForm> users = [];
  File fileKartu;
  File filePemegangKartu;
  Future getImageGalery() async {
    var fileGlr = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img1.Image gambar = Img1.decodeImage(fileGlr.readAsBytesSync());
    Img1.Image gambarKecil = Img1.copyResize(gambar, width: 720, height: 480);

    var compresGambar = new File(path.toString()+randomAlphaNumeric(10).toString()+".jpg")
      ..writeAsBytesSync(Img1.encodeJpg(gambarKecil, quality: 72));

    setState(() {
      fileKartu = compresGambar;
      String fotoKartu = base64Encode(fileKartu.readAsBytesSync());
      widget.user.foto_ktp = fotoKartu;
    });
  }

  Future getImageCamera() async {
    var filecmr = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img2.Image gambar = Img2.decodeImage(filecmr.readAsBytesSync());
    Img2.Image gambarKecil = Img2.copyResize(gambar, width: 720, height: 480);

    var compresGambar = new File("$path.jpg")
      ..writeAsBytesSync(Img2.encodeJpg(gambarKecil, quality: 36));
    setState(() {
      fileKartu = compresGambar;

      String fotoKartu = base64Encode(fileKartu.readAsBytesSync());
      widget.user.foto_ktp = fotoKartu;
    });
  }

  Future getImageGaleryDua() async {
    var gambarFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final dirTemp = await getTemporaryDirectory();
    final path = dirTemp.path;

    Img3.Image gambar = Img3.decodeImage(gambarFile.readAsBytesSync());
    Img1.Image gambarKecil = Img1.copyResize(gambar, width: 720, height: 720);

    var compresGambar = new File(path.toString()+randomAlphaNumeric(10).toString()+".jpg")
      ..writeAsBytesSync(Img1.encodeJpg(gambarKecil, quality: 72));

    setState(() {
      filePemegangKartu = compresGambar;
      String fotoPemegangKartu =
          base64Encode(filePemegangKartu.readAsBytesSync());
      widget.user.foto_selfie = fotoPemegangKartu;

    });
  }

  Future getImageCameraDua() async {
    var gambarFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final dirTemp = await getTemporaryDirectory();
    final path = dirTemp.path;

    Img4.Image gambar2 = Img4.decodeImage(gambarFile.readAsBytesSync());
    Img4.Image gambarKecil2 = Img4.copyResize(gambar2, width: 720, height: 480);

    var compresGambar = new File("$path.png")
      ..writeAsBytesSync(Img4.encodeJpg(gambarKecil2, quality: 36));
    setState(() {
      filePemegangKartu = compresGambar;

      String fotoPemegangKartu =
          base64Encode(filePemegangKartu.readAsBytesSync());
      widget.user.foto_selfie = fotoPemegangKartu;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1400, allowFontScaling: true);

    _onAlertButtonsPressed(context) async {
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
              Navigator.of(context, rootNavigator: true).pop();
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
              Navigator.of(context, rootNavigator: true).pop();
            },
            gradient:
                LinearGradient(colors: [Colors.pinkAccent, Colors.blueAccent]),
          )
        ],
      ).show();
    }

    _onAlertButtonsPressed2(context) async {
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
              Navigator.of(context, rootNavigator: true).pop();
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
              Navigator.of(context, rootNavigator: true).pop();
            },
            gradient:
                LinearGradient(colors: [Colors.pinkAccent, Colors.blueAccent]),
          )
        ],
      ).show();
    }

    return new Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(16),
            child: Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Form(
                key: form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      leading: Icon(Icons.group),
                      elevation: 0,
                      title: Text('Formulir Pengunjung Utama'),
                      backgroundColor: Theme.of(context).accentColor,
                      centerTitle: true,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: widget.onDelete,
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                      child: FormBuilderDropdown(
                        initialValue: widget.user.kartuid,
                        onChanged: (val) => widget.user.kartuid = val,
                        attribute: "Kartu ID",
                        decoration:
                            InputDecoration(labelText: 'Kartu Identitas'),
                        hint: Text('Kartu Identitas'),
                        validators: [FormBuilderValidators.required()],
                        items: ['KTP', 'SIM', 'PASPOR']
                            .map((kartu) => DropdownMenuItem(
                                value: kartu, child: Text("$kartu")))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 16.0, right: 16),
                      child: TextFormField(
                        initialValue: widget.user.nomorid,
                        onSaved: (val) => widget.user.nomorid = val,
                        validator: (val) =>
                            val.length > 9 ? null : 'Nomor terlalu pendek',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Nomor Identitas',
                            hintText: 'Nomor Identitas'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                      child: TextFormField(
                        initialValue: widget.user.fullname,
                        onSaved: (val) => widget.user.fullname = val,
                        validator: (val) =>
                            val.length > 3 ? null : 'Nama terlalu pendek',
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          hintText: 'Nama Lengkap',
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 10.0),
                      child: FormBuilderRadio(
                        initialValue: widget.user.jk,
                        onChanged: (val) => widget.user.jk = val,
                        decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                        leadingInput: true,
                        attribute: "best_language",
                        validators: [FormBuilderValidators.required()],
                        options: [
                          "Laki-Laki",
                          "Perempuan",
                        ]
                            .map((lang) => FormBuilderFieldOption(value: lang))
                            .toList(growable: false),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                      child: FormBuilderDropdown(
                        initialValue: widget.user.hubkeluarga,
                        onChanged: (val) => widget.user.hubkeluarga = val,
                        attribute: "Hubungan Keluarga",
                        decoration:
                            InputDecoration(labelText: 'Hubungan Keluarga'),
                        hint: Text('Hubungan Keluarga'),
                        validators: [FormBuilderValidators.required()],
                        items: [
                          'Ayah',
                          'Suami',
                          'Ibu',
                          'Anak',
                          'Saudara',
                          'Paman',
                          'Bibi',
                          'Teman',
                          'Teman Dekat',
                          'Lainnya'
                        ]
                            .map((hub) => DropdownMenuItem(
                                value: hub, child: Text("$hub")))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 10.0),
                      child: TextFormField(
                        initialValue: widget.user.foto_selfie,
                        onSaved: (val) => widget.user.alamat = val,
                        validator: (val) => val.length > 3
                            ? null
                            : 'Nama alamat terlalu pendek',
                        decoration: InputDecoration(
                            labelText: 'Alamat',
                            hintText: 'Desa/Kelurahan, Kecamatan'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0, left: 10.0),
                      child: TextFormField(
                        initialValue: widget.user.nohp,
                        onSaved: (val) => widget.user.nohp = val,
                        validator: (val) =>
                            val.length > 9 ? null : 'Nomor terlalu pendek',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Nomor Handphone',
                            hintText: 'Nomor Handphone'),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text('Kirim Foto Anda'),
                        SizedBox(
                          height: 10.0,
                        ),
                        fileKartu == null
                            ? Column(
                                children: <Widget>[
                                  new Text(
                                    "Pilih Foto Kartu Identitas Anda",
                                    textAlign: TextAlign.center,
                                  ),
                                  new Text(
                                    "Silahkan Upload Gambar Dalam Bentuk Landscape",
                                    style: TextStyle(color: Colors.blueAccent),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : StreamBuilder(
                                  builder: (context, snapshot){
                                    return new Image.file(fileKartu);
                                  },),
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
                                    "Pilih Foto Anda Memegang Kartu Identitas",
                                    textAlign: TextAlign.center,
                                  ),
                                  new Text(
                                    "Silahkan Upload Gambar Dalam Bentuk Landscape",
                                    style: TextStyle(color: Colors.blueAccent),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : StreamBuilder(
                                  builder: (context, snapshot){
                                    return new Image.file(filePemegangKartu);
                                  },),
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
                        Text(
                            'Jika Berkunjung Lebih Dari 1 Orang, Klik Tombol Hijau'),
                        SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }

  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
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
}
