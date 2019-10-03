import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:unicorndial/unicorndial.dart';

String imageBesar = "";
String keteranganFoto = "";

void main() {
  runApp(new MaterialApp(
    home: new GaleriLapermata(),
  ));
}

class GaleriLapermata extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<GaleriLapermata> {
  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  List dataAPI;

  Future<String> ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("http://lapermata.site/api/gallery"),
        headers: {"Accept": "aplication/json"});
    this.setState(() {
      dataAPI = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'Gallery',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: Container(
        child: new Column(children: <Widget>[
          //SizedBox(height: 8.0,),
          Container(
            //height: 320.0,
            child: new ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(100.0)),
              child: GambarBesar(gambar: imageBesar),
            ),
          ),

          SizedBox(
            height: 8.0,
          ),
          new Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(20.0),
                   boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8.0,
                                    offset: Offset(0.0, 8.0))]
                ),
               child:  CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(icon: Icon(Icons.share, color:Colors.lightBlue,),
               
                onPressed: (){

                },),
              ),


              ),
             
               SizedBox(
                width: 8.0,
              ),

              Container(
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(20.0),
                   boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8.0,
                                    offset: Offset(0.0, 8.0))]
                ),
               child:  CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(icon: Icon(Icons.cloud_download, color:Colors.lightBlue,),
               
                onPressed: (){

                },),
              ),


              ),
               
              
              SizedBox(
                width: 8.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(23.0),
                    topLeft: Radius.circular(23.0),
                    bottomRight: Radius.circular(2.0),
                    topRight: Radius.circular(2.0)),
                child: Container(
                  height: 46.0,
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Center(
                      child: Text(
                        keteranganFoto,
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
          SizedBox(
            height: 5.0,
          ),

          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: new Container(
                child: GridView.builder(
                    itemCount: dataAPI == null ? 0 : dataAPI.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 10.0))
                              ]),
                          child: new InkWell(
                            splashColor: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {
                              setState(() {
                                imageBesar =
                                    "http://lapermata.site/static/images/gallery/" +
                                        dataAPI[i]['gambar'];
                                keteranganFoto = dataAPI[i]['judul'];
                              });
                            },
                            child: new ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: new Image.network(
                                "http://lapermata.site/static/images/gallery/" +
                                    dataAPI[i]['gambar'],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class GambarBesar extends StatelessWidget {
  GambarBesar({this.gambar});
  final String gambar;
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Image.network(gambar),
    );
  }
}
