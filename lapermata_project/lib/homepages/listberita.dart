import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:html/parser.dart';

class Spacecraft {
  final String judul;
  final String gambar, isi, tanggal;
  Spacecraft({
    this.judul,
    this.isi,
    this.gambar,
    this.tanggal,
  });
  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      gambar: jsonData['gambar'],
      judul: jsonData['judul'],
      tanggal: jsonData['tanggal'],
      isi: jsonData['isi'],
    );
  }
}

class CustomListView extends StatelessWidget {
  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  final List<Spacecraft> spacecrafts;
  CustomListView(this.spacecrafts);
  Widget build(context) {
    return ListView.builder(
      itemCount: spacecrafts.length,
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
            //decoration: BoxDecoration(border: Border.all(color: Colors.pinkAccent)),
            padding: EdgeInsets.all(5.0),

            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      child: Image.network(
                        "http://lapermata.site/static/images/berita/" +
                            spacecraft.gambar,
                        height: 80.0,
                        width: 100.0,
                      ),
                      padding: EdgeInsets.all(1.0),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              child: Text(
                                _parseHtmlString(spacecraft.judul),
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    fontSize: 16.0),
                                textAlign: TextAlign.left,
                              ),
                              padding: EdgeInsets.all(1.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                  child: Text(
                                    _parseHtmlString(spacecraft.tanggal),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.left,
                                  ),
                                  padding: EdgeInsets.all(1.0)),
                              new MaterialButton(
                                  color: Colors.pinkAccent,
                                  textColor: Colors.white,
                                  child: Text("Selengkapnya"),
                                  onPressed: () {
                                    var route = new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new SecondScreen(value: spacecraft),
                                    );
//A Navigator is a widget that manages a set of child widgets with
//stack discipline.It allows us navigate pages.
                                    Navigator.of(context).push(route);
                                  }),
                            ],
                          ),
                        ]),
                  ),
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
        });
  }
}

//Future is n object representing a delayed computation.
Future<List<Spacecraft>> downloadJSON() async {
  final jsonEndpoint = "http://lapermata.site/api/berita/all";
  final response = await get(jsonEndpoint);
  if (response.statusCode == 200) {
    List spacecrafts = json.decode(response.body);
    return spacecrafts
        .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
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
      appBar: new AppBar(
        title: new Text(
          'Detail Berita',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                 child: ClipRRect(
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                         child: Image.network(
                    "http://lapermata.site/static/images/berita/" +
                        '${widget.value.gambar}'),
                     
                   ),

             
                padding: EdgeInsets.only(bottom: 8.0),
              ),
              Padding(
                child: new Text(
                  '${widget.value.judul}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'Terbit : ${widget.value.tanggal}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: new Text(_parseHtmlString('${widget.value.isi}')),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ListBeritaSelengkapnya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kabar Berita NTB',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.search,
            ),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
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
