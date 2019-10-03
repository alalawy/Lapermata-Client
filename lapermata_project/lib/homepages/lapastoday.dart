import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lapermata_project/halamanlogin.dart';
import 'package:lapermata_project/home.dart';
import 'package:lapermata_project/homepages/detailberitaheadline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:lapermata_project/homepages/menu_kategori/store.dart';
import 'package:lapermata_project/homepages/listberita.dart';
import 'package:lapermata_project/homepages/menu_kategori/profile.dart';
import 'package:lapermata_project/homepages/menu_kategori/gallery.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:lapermata_project/homepages/belum_login.dart';

var gambarBerita =
    'https://mataraminside.com/wp-content/uploads/2019/04/Tri-Saptono1.jpg';

var textYellow = Color(0xFFf6c24d);
var iconYellow = Color(0xFFf4bf47);

var green = Color(0xFF4caf6a);
var greenLight = Color(0xFFd8ebde);

var red = Color(0xFFf36169);
var redLight = Color(0xFFf2dcdf);

var blue = Color(0xFF398bcf);
var blueLight = Color(0xFFc1dbee);

class Dashboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lapermata',
      theme: ThemeData(),
      home: BuildView(),
    );
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
    if (kodeUsers == null) {
      kodeUsers = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return kodeUsers != "" ? DashboardSL() : MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    if (kodeUsers == null) {
      kodeUsers = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightImage = MediaQuery.of(context).size.height;
    Widget imageSlider = new Container(
      height: heightImage / 3,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            NetworkImage(
                "http://images1.rri.co.id/thumbs/berita_666043_800x600_PETUGAS_LAAPAS_PERAGAKAN_BELA_DIRI.jpg"),
            NetworkImage("https://pbs.twimg.com/media/Dcbe51MVQAMaXp8.jpg"),
            NetworkImage(
                "http://infoindonesianews.com/wp-content/uploads/2018/12/IMG-20181228-WA0046.jpg"),
            NetworkImage(
                "https://3.bp.blogspot.com/-zmuhUUkJqGM/VcI-YeN59cI/AAAAAAAAC04/uSdY94bj0QA/s1600/DSC00277.JPG"),
            NetworkImage(
                "http://infopublik.id/assets/upload/headline//IMG-20190405-WA0026.jpg"),
            NetworkImage(
                "https://1.bp.blogspot.com/-scuQjFJhkgw/XHN5Ql3wJEI/AAAAAAAAFLU/m5GdU3CaHqoGYCj1tk0ud3nGatU-J7ZewCLcBGAs/s640/20190223_102754%25280%2529.jpg"),
            NetworkImage(
                "https://mataraminside.com/wp-content/uploads/2019/04/Tri-Saptono1.jpg"),
            NetworkImage(
                "https://scontent-lhr3-1.cdninstagram.com/vp/bff6b3b6d2323d0d25efb8c640b5f76c/5D9A039E/t51.2885-15/e35/54731553_1790080037763915_1008021313555459634_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com&se=8&ig_cache_key=MjAwNDAyNDI3ODk0MDcyODY1OA%3D%3D.2"),
          ],
          autoplay: true,
          autoplayDuration: Duration(seconds: 5),
          animationCurve: Curves.fastOutSlowIn,
          dotSize: 5.0,
          dotColor: Colors.blueAccent,
          dotBgColor: Colors.white70,
          dotSpacing: 20.0,
          indicatorBgPadding: 2.0,
        ),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text('Lapermata'),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'assets/fb.png',
                width: 24.0,
              ),
              onPressed: () {
                _facebookURL("lpp");
              }),
          IconButton(
              icon: Image.asset(
                'assets/ig.png',
                width: 24.0,
              ),
              onPressed: () {
                _instagramURL("lapas_mataram");
              }),
          IconButton(
              icon: Image.asset(
                'assets/tweet.png',
                width: 24.0,
              ),
              onPressed: () {
                _twitterURL("lpp_mataram");
              }),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'Panduan',
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Panduan()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Panduan',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Icon(
                          Icons.bookmark_border,
                          color: Colors.lightBlue,
                          size: 20.0,
                        ),
                      ],
                    )),
              ),
              PopupMenuItem(
                value: 'Tentang',
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TentangAplikasi()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tentang Aplikasi',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Colors.lightBlue,
                          size: 20.0,
                        ),
                      ],
                    )),
              ),
              PopupMenuItem(
                value: 'Login',
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      kodeNavBar = 1;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new HalamanLogin()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Icon(
                          Icons.account_circle,
                          color: Colors.lightBlue,
                          size: 20.0,
                        ),
                      ],
                    )),
              ),
            ];
          }),
        ],
      ),
      body: new Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              child: imageSlider,
            ),
          ),
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Column(
                children: <Widget>[
                  SelectTypeSection(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Lapas Today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Mataram, NTB',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '  HEADLINE  ',
                              style: TextStyle(
                                  backgroundColor: Colors.red[900],
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            /* SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),*/
                          ],
                        ),
                        // SizedBox(height: 10.0,),

                        // Text("Trending Topic", style: TextStyle(color: Colors.black, fontSize: 16.0,
                        // fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                      ],
                    ),
                  ),
                  BeritaHeadline(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(36.0, 16.0, 36.0, 16.0),
                    child: InkWell(
                      child: Container(
                        height: 36.0,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListBeritaSelengkapnya()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Berita Lainnya......",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Medium",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        letterSpacing: 1.0)),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Status: Anda Belum Login :-(",
                            style: TextStyle(color: Colors.pink))
                      ],
                    ),
                  ),
                  InfoAplikasi(),
                  SizedBox(
                    height: 24.0,
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

class BeritaHeadline extends StatefulWidget {
  @override
  _BeritaHeadlineState createState() => _BeritaHeadlineState();
}

class _BeritaHeadlineState extends State<BeritaHeadline> {
  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  List posts;

  Future<bool> _getPost() async {
    String serviceUrl = "http://lapermata.site/api/berita";
    var response = await http.get(serviceUrl);

    setState(() {
      posts = json.decode(response.body.toString());
      print(posts);
    });
  }

  @override
  void initState() {
    super.initState();
    this._getPost();
  }

  @override
  Widget build(BuildContext context) {
    var postdata = posts;

    return postdata != null
        ? new ListView.builder(
            //padding: new EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: new Card(
                    elevation: 0.5,
                    child: new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Image.network(
                                "http://lapermata.site/static/images/berita/" +
                                    posts[index]["gambar"],
                                height: 80.0,
                                width: 100.0,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: new Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.0, right: 3.0),
                                      child: Text(
                                        posts[index]["judul"],
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(posts[index]["tanggal"]),
                                          MaterialButton(
                                            color: Colors.pinkAccent,
                                            splashColor: Colors.pink,
                                            textColor: Colors.white,
                                            child: Text("Selengkapnya"),
                                            onPressed: () {
                                              Route route = MaterialPageRoute(
                                                  builder: (context) =>
                                                      HalamanDetail(
                                                          posts[index]));
                                              Navigator.push(context, route);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => HalamanDetail(posts[index]));
                    Navigator.push(context, route);
                  });
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class Panduan extends StatefulWidget {
  @override
  _PanduanState createState() => _PanduanState();
}

class _PanduanState extends State<Panduan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Panduan"),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Panduan Penggunaan Aplikasi Lapermata",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Menu Dashboard / Home",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      "Pada menu terdapat fitur dan Informasi mengenai Lapas Perempuan Mataram yang dapat di akses secara umum tanpa melakukan registrasi apapun, pengguna aplikasi dapat melihat berita seputar Lapas Perempuan Mataram dan Provinsi NTB secara umumnya.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      "1. Menu Gallery - Merupakan kumpulan Foto & Video Kegiatan Lapas Perempuan Mataram, yang dapat di akases secara umum serta di unduh maupun dibagikan.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "2. Menu Profile - Pada menu ini berisi tentang profile secara umum Lapas Perempuan Mataram, pemaparan Visi-Misi serta Struktur Organisasi yang ada.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "3. Menu Store - Di dalam menu ini Pengguna Apikasi LAPERMATA dapat melihat dan membeli koleksi hasil karya dan kerajinan dari Keluarga Binaan Lapas.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      "Menu Khusus",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      "Menu Khusus disini maksudnya adalah menu yang hanya ditujukan untuk keluarga atau kerabat dari Keluarga Binaan Lapas Perempuan Mataram. Berikut dibawah ini adalah Menu Khusus :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      "1. Menu Pengajuan Kunjungan Lapas Online",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "2. Menu Tinjau Kondisi Keluarga Binaan.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "3. Menu Akun Profile Pengguna",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "4. Menu Layanan Chat RealTime",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectTypeSection extends StatelessWidget {
  const SelectTypeSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GaleriLapermata()));
                  },
                  splashColor: Colors.greenAccent,
                  child: Container(
                    height: 60.0,
                    width: 80.0,
                    color: greenLight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.images,
                          color: green,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                              color: green, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  splashColor: Colors.redAccent,
                  child: Container(
                    height: 60.0,
                    width: 80.0,
                    color: redLight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.building,
                          color: red,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: red, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Store()));
                  },
                  splashColor: Colors.blueAccent,
                  child: Container(
                    height: 60.0,
                    width: 80.0,
                    color: blueLight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.cartArrowDown,
                          color: blue,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          'Store',
                          style: TextStyle(
                              color: blue, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoAplikasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 32.0, 10.0, 32.0),
      child: Column(
        children: <Widget>[
          new Text(
            'Lapermata - Aplikasi Layanan Lapas Perempuan Mataram, NTB',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Didukung oleh :',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/alphacsoft.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Alphacsoft'),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Copyright© 2019 - LAPERMATA'),
            ],
          ),
        ],
      ),
    );
  }
}

class TentangAplikasi extends StatefulWidget {
  @override
  _TentangAplikasiState createState() => _TentangAplikasiState();
}

class _TentangAplikasiState extends State<TentangAplikasi> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tentang Aplikasi"),
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(10.0, 32.0, 10.0, 32.0),
            child: Column(
              children: <Widget>[
                new Text(
                  'Lapermata - Aplikasi Layanan Lapas Perempuan Mataram, NTB',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 32.0,
                ),
                new Text(
                  'Lapermata adalah aplikasi layanan dari Lapas Perempuan Mataram - NTB, yang ditujukan sebagai fasilitas untuk mempermudah para keluaraga, kerabat dan teman dari Keluarga Binaan yang ada di Lapas Perempuan Mataram',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  'Didukung oleh :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/alphacsoft.png',
                          height: 24.0,
                          width: 24.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Alphacsoft'),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Copyright© 2019 - LAPERMATA'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardSL extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lapermata',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: MyHomePageSL(),
    );
  }
}

class MyHomePageSL extends StatefulWidget {
  @override
  _MyHomePageSLState createState() => new _MyHomePageSLState();
}

class _MyHomePageSLState extends State<MyHomePageSL> {
  @override
  Widget build(BuildContext context) {
    double heightImage = MediaQuery.of(context).size.height;
    Widget imageSlider = new Container(
      height: heightImage / 3,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            NetworkImage(
                "http://images1.rri.co.id/thumbs/berita_666043_800x600_PETUGAS_LAAPAS_PERAGAKAN_BELA_DIRI.jpg"),
            NetworkImage("https://pbs.twimg.com/media/Dcbe51MVQAMaXp8.jpg"),
            NetworkImage(
                "http://infoindonesianews.com/wp-content/uploads/2018/12/IMG-20181228-WA0046.jpg"),
            NetworkImage(
                "https://3.bp.blogspot.com/-zmuhUUkJqGM/VcI-YeN59cI/AAAAAAAAC04/uSdY94bj0QA/s1600/DSC00277.JPG"),
            NetworkImage(
                "http://infopublik.id/assets/upload/headline//IMG-20190405-WA0026.jpg"),
            NetworkImage(
                "https://1.bp.blogspot.com/-scuQjFJhkgw/XHN5Ql3wJEI/AAAAAAAAFLU/m5GdU3CaHqoGYCj1tk0ud3nGatU-J7ZewCLcBGAs/s640/20190223_102754%25280%2529.jpg"),
            NetworkImage(
                "https://mataraminside.com/wp-content/uploads/2019/04/Tri-Saptono1.jpg"),
            NetworkImage(
                "https://scontent-lhr3-1.cdninstagram.com/vp/bff6b3b6d2323d0d25efb8c640b5f76c/5D9A039E/t51.2885-15/e35/54731553_1790080037763915_1008021313555459634_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com&se=8&ig_cache_key=MjAwNDAyNDI3ODk0MDcyODY1OA%3D%3D.2"),
          ],
          autoplay: true,
          autoplayDuration: Duration(seconds: 5),
          animationCurve: Curves.fastOutSlowIn,
          dotSize: 5.0,
          dotColor: Colors.blueAccent,
          dotBgColor: Colors.white70,
          dotSpacing: 20.0,
          indicatorBgPadding: 2.0,
        ),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text('Lapermata'),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'assets/fb.png',
                width: 24.0,
              ),
              onPressed: () {
                _facebookURL("lpp");
              }),
          IconButton(
              icon: Image.asset(
                'assets/ig.png',
                width: 24.0,
              ),
              onPressed: () {
                _instagramURL("lapas_mataram");
              }),
          IconButton(
              icon: Image.asset(
                'assets/tweet.png',
                width: 24.0,
              ),
              onPressed: () {
                _twitterURL("lpp_mataram");
              }),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'Panduan',
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Panduan()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Panduan',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Icon(
                          Icons.bookmark_border,
                          color: Colors.lightBlue,
                          size: 20.0,
                        ),
                      ],
                    )),
              ),
              PopupMenuItem(
                value: 'Tentang',
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TentangAplikasi()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tentang Aplikasi',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Colors.lightBlue,
                          size: 20.0,
                        ),
                      ],
                    )),
              ),
              PopupMenuItem(
                value: 'Tutup',
                child: InkWell(
                    onTap: () => _onAlertButtonsPressed(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Logout',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                      ],
                    )),
              ),
            ];
          }),
        ],
      ),
      body: new Column(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              child: imageSlider,
            ),
          ),
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  SelectTypeSection(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Lapas Today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Mataram, NTB',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '  HEADLINE  ',
                              style: TextStyle(
                                  backgroundColor: Colors.red[900],
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            /*SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.0,
                        ),*/
                          ],
                        ),
                        // SizedBox(height: 10.0,),

                        //Text("Trending Topic", style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                      ],
                    ),
                  ),
                  BeritaHeadline(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(36.0, 16.0, 36.0, 16.0),
                    child: InkWell(
                      child: Container(
                        height: 36.0,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListBeritaSelengkapnya()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Berita Lainnya......",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Medium",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        letterSpacing: 1.0)),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Status : Anda Telah Login :-)",
                            style: TextStyle(color: Colors.pink)),
                      ],
                    ),
                  ),
                  InfoAplikasi(),
                  SizedBox(
                    height: 24.0,
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
      type: AlertType.warning,
      title: "Logout",
      desc: "Keluar Dari Lapermata ?",
      buttons: [
        DialogButton(
          child: Text(
            "Iya",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("kodeUser", "");
            kodeUsers = "";
            Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Dashboard()));
            Navigator.of(context, rootNavigator: true).pop();
          },
          gradient: LinearGradient(colors: [
            Colors.orangeAccent,
            Colors.amber,
          ]),
        ),
        DialogButton(
          child: Text(
            "Tidak",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          gradient: LinearGradient(colors: [
            Colors.amber,
            Colors.orangeAccent,
          ]),
        )
      ],
    ).show();
  }
}

_facebookURL(String $profilename) async {
  var url = 'https://web.facebook.com/lpp.lpp.589';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_instagramURL(String $profilename) async {
  var url = 'https://www.instagram.com/lpp_mataram';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_twitterURL(String $profilename) async {
  var url = 'https://www.twitter.com/lpp_mataram';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
