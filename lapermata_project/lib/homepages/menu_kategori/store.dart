import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class Spacecraft {
  final String nama, gambar, detail, link;
  int harga;

  Spacecraft({
    this.nama,
    this.gambar,
    this.detail,
    this.harga,
    this.link,
  });
  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      nama: jsonData['nama_barang'],
      detail: jsonData['detail'],
      gambar: jsonData['gambar'],
      harga: jsonData['harga'],
      link: jsonData['link'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<Spacecraft> spacecrafts;
  CustomListView(this.spacecrafts);
  Widget build(context) {
    return GridView.builder(
      itemCount: spacecrafts.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, int currentIndex) {
        return createViewItem(spacecrafts[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Spacecraft spacecraft, BuildContext context) {
    return new ListTile(
        title: new Card(
          elevation: 5.0,
          child: new Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                     child: Image.network(
                    "http://lapermata.site/static/images/store/" +
                        spacecraft.gambar,
                    height: 110.0,
                  ),
                  ),
                 
                  padding: EdgeInsets.only(bottom: 4.0),
                ),
                Padding(
                    child: Text(
                      spacecraft.nama,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(1.0)),
                Row(
                  children: <Widget>[
                    Text(
                      "Rp",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        spacecraft.harga.toString(),
                        style: new TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
//We start by creating a Page Route.
//A MaterialPageRoute is a modal route that replaces the entire
//screen with a platform-adaptive transition.
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SecondScreen(value: spacecraft),
          );
//A Navigator is a widget that manages a set of child widgets with
//stack discipline.It allows us navigate pages.
          Navigator.of(context).push(route);
        },
        
        
        );
        
  }
}

//Future is n object representing a delayed computation.
Future<List<Spacecraft>> downloadJSON() async {
  final jsonEndpoint = "http://lapermata.site/api/store";
  final response = await get(jsonEndpoint);
  if (response.statusCode == 200) {
    List spacecrafts = json.decode(response.body);
    return spacecrafts
        .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
        .toList();
  } else
    throw Exception('Gagal menghubungkan ke server');
}

class SecondScreen extends StatefulWidget {
  final Spacecraft value;
  SecondScreen({Key key, this.value}) : super(key: key);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Detail Produk', style: TextStyle(fontSize: 18.0),), backgroundColor: Colors.lightBlue,),
      body: new ListView(
        children: <Widget>[
          Container(
            child: new Center(
              child: Column(
                children: <Widget>[
                  Padding(

                   child: ClipRRect(
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                      child: Image.network(
                        "http://lapermata.site/static/images/store/" +
                            '${widget.value.gambar}'),
                     
                   ),
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Padding(
                    child: new Text(
                      _parseHtmlString('${widget.value.nama}'),
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Rp",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _parseHtmlString('${widget.value.harga.toString()}'),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text('Deskripsi Produk',  style: new TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    child: new Text(
                      _parseHtmlString(' ${widget.value.detail}'),
                      style: new TextStyle(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),

                 
                      Padding(
                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                     child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: RaisedButton(
                        splashColor: Colors.greenAccent,
                        onPressed: () {
                            _lppcollections("lppmataramcollec");

                          
                        },
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 80.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Pesan Sekarang",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontFamily: "SF-Pro-Display-Bold"),
                            ),
                            SizedBox(width: 5.0,),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child:  Image.asset('assets/tokopedia.png', height: 24.0, width: 24.0),
                            ),
                           
                          
                          ],
                        ),
                      ),
                  ),
                   ),
                    


                   
                 
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Kunjungi Store Kami, Hanya di'),
                  SizedBox(
                    height: 10.0,
                  ),
                  IconButton(
                    icon: Image.asset('assets/tokopediaa.png'),
                    iconSize: 200.0,
                    onPressed: () {
                      _tokopedia("lppmataramcollec");
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _lppcollections(String $profilename) async {
    var url = "${widget.value.link}";
    const urllpp = "https://www.tokopedia.com/lppmataramcollec/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

_tokopedia(String $profilename) async {
  var url = 'https://www.tokopedia.com/lppmataramcollec';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw launch(url);
  }
}

class Store extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Store Produk', style: TextStyle(fontSize: 18.0),),
        backgroundColor: Colors.lightBlue,
      ),
      body: new Center(
//FutureBuilder is a widget that builds itself based on the latest snapshot
// of interaction with a Future.
        child: new FutureBuilder<List<Spacecraft>>(
          future: downloadJSON(),
//we pass a BuildContext and an AsyncSnapshot object which is an
//Immutable representation of the most recent interaction with
//an asynchronous computation.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Spacecraft> spacecrafts = snapshot.data;
              return new CustomListView(spacecrafts);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
//return  a circular progress indicator.
            return new CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(Store());
}
