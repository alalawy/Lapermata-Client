import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:html/parser.dart';

class HalamanDetail extends StatefulWidget {
  var data;
  HalamanDetail(this.data);
  _HalamanDetailState createState() => _HalamanDetailState(this.data);
}

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

class _HalamanDetailState extends State<HalamanDetail> {
  var data;
  _HalamanDetailState(this.data);

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Detail Berita", style: TextStyle(fontSize: 18.0),),
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
           
            children: <Widget>[
              Image.network("http://lapermata.site/static/images/berita/" +
                  "${data['gambar']}"),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(_parseHtmlString("${data['judul']}"), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.blueAccent),),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  _parseHtmlString("${data['tanggal']}"),
                  style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ),
              

             
            ],
          ),
           Padding(
                
                padding: EdgeInsets.all(8.0),
               
                  child:  Column(
                  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_parseHtmlString("${data['isi']}"), textAlign: TextAlign.left,),

                    ],
                  )
                  
                  
               
               
              ),
              Divider(),
        ],
      ),
    );
  }
}
