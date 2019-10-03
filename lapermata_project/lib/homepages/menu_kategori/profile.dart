import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: new Profile(),
  ));
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-8.581306, 116.108912),
    zoom: 10.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      //bearing: 90.8334901395799,
      target: LatLng(-8.581306, 116.108912),
      tilt: 30.440717697143555,
      zoom: 22.151926040649414);

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  List list = List();

  ambildata() async {
    final response = await http.get("http://lapermata.site/api/profile");
    if (response.statusCode == 200) {
      this.setState(() {
        list = json.decode(response.body) as List;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    var ambildata = list;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: new Text("Profile Lapas", style: TextStyle(fontSize: 18.0),),
      ),
      body: 
      ambildata.length!=0?
       new Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child:ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                       child: Image.network(
                        "http://lapermata.site/static/images/berita/" +
                            list[0]['gambar']),
                    ),
                   
                  ),
                  Flexible(
                    flex: 1,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Visi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  _parseHtmlString(list[0]['visi']), textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Misi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  _parseHtmlString(list[0]['misi']), textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Profile Umum",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  _parseHtmlString(list[0]['profile_umum']),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Struktur Organisasi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  _parseHtmlString(list[0]['struktur']),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Lokasi Lapas",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Container(
                                    height: 240.0,
                                    width: 360.0,
                                    child: GoogleMap(
                                      mapType: MapType.hybrid,
                                      initialCameraPosition: _kGooglePlex,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller.complete(controller);
                                      },
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: InkWell(
                                    splashColor: Colors.pink,
                                
                                  child:Container(
                                    height: 32.0,
                                    width: 240.0,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                     child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.location_on,color: Colors.red,),
                                      SizedBox(width: 5.0,),
                                      Text("Lihat Lokasi Lapas", style: TextStyle(color: Colors.black),),


                                    ],
                                  ),

                                  ),
                                 
                                  onTap:  _goToTheLake,
                                ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: InkWell(
                                     splashColor: Colors.pink,
                                  
                                  child:Container(
                                    height: 32.0,
                                    width: 240.0,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                     child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/maps.png', height: 24.0, width: 24.0,),SizedBox(width: 5.0,),
                                      Text("Buka Di Google Maps", style: TextStyle(color: Colors.black),),


                                    ],
                                  ),

                                  ),
                                 
                                  onTap:  (){

                                  }
                                ),
                                ),
                                

                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Kontak Kami",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Email : lapasperempuanmataram@gmail.com",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.0),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Call Center : 0878-4444-2699",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.0),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ): new Center(
              child: CircularProgressIndicator()),

        
        

      
      
      
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
