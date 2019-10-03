import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lapermata_project/data_log/datalog_kunjungan.dart';
import 'package:http/http.dart' as http;
import 'package:lapermata_project/halamanlogin.dart';
import 'package:lapermata_project/homepages/tabbarkunjungan/riwayat.dart';
class DetailLogKunjungan extends StatefulWidget {
  @override
  _DetailLogKunjunganState createState() => _DetailLogKunjunganState();
}

class _DetailLogKunjunganState extends State<DetailLogKunjungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Detail Pengajuan Kunjungan', style: TextStyle(fontSize: 18.0),),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Status",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text("Tgl Kunjungan",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text("Kode User",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text("Kode Kunjungan",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.0,),
                          Flexible(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Text(":",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text(":",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text(":",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text(":",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                            ],
                          ),
                        ),
                         SizedBox(width: 5.0,),
                          Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("DISETUJUI",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold), ),
                              SizedBox(height: 10.0,),
                              Text("23-08-2019",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text("USER2230000",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                              Text("PLOGUSER81291823737 ",style: TextStyle(fontSize: 14.0), ),
                              SizedBox(height: 10.0,),
                            ],
                          ),
                        ),
                        
                      ],
                    ) ,) ,),
                    Divider(
            height: 8.0,
          ),
          SizedBox(height: 10.0,),
          Text("Detail Keluarga Binaan", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                DetailKeluargaBinaan(),
                 Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.lightBlue, Colors.deepPurple])),
          ),
        ),
          
          Text("Detail Pengunjung Utama", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),),
                DetailPengunjungUtama(),
                SizedBox(height: 10.0,),
                Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.lightBlue, Colors.deepPurple])),
          ),
        ),
        SizedBox(height: 10.0,),
          Text("Detail Pengikut", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),),
                DetailPengikut(),
                
                
                
                ],
            )
          ],
        ),
      ),
    );
  }
}

class DetailKeluargaBinaan extends StatefulWidget {
  @override
  _DetailKeluargaBinaanState createState() => _DetailKeluargaBinaanState();
}

class _DetailKeluargaBinaanState extends State<DetailKeluargaBinaan> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
      children: <Widget>[
        Column(
          children: <Widget>[
           
            SizedBox(
              height: 10.0,
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundImage: NetworkImage('http://lapermata.site/static/images/tahanan/linda%20(2).jpg'),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Aldi Mahesa Putra',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              'Kediri, Lombok Barat',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
       
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
                        'Kode Keluarga Binaan : ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '99QHENDIWUEW',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.blueAccent),
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
  @override
  _DetailPengunjungUtamaState createState() => _DetailPengunjungUtamaState();
}

class _DetailPengunjungUtamaState extends State<DetailPengunjungUtama> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
              height: 10.0,
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundImage: NetworkImage('https://korea.iyaa.com/article/2017/05/__icsFiles/thumbnail/2017/05/08/DO2.jpg'),
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
                                Text("Nama",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("Alamat",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("Jenis Kelamin",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("Relasi",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("No.Hp",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("Kartu",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.0,),
                            Flexible(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(":",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text(":",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text(":",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text(":",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text(":",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text(":",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                              ],
                            ),
                          ),
                           SizedBox(width: 5.0,),
                            Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Aldi Mahesa Putra",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal), ),
                                SizedBox(height: 10.0,),
                                Text("Kediri, Lombok Barat",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("Laki-Laki",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("Teman ",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("081907587877",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 10.0,),
                                Text("KTP ",style: TextStyle(fontSize: 14.0), ),
                                SizedBox(height: 3.0,),
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
                          child: Image.network('https://storage.lapor.go.id/app/uploads/public/5ca/186/087/5ca18608787c7443980304.jpg', height: 220.0, width: 360.0,),
                        ),
                        
                        
                        
                      ),
                      

                      

                      ],
                    ),
                        
                                          
                                         
                    ) ,
      );
  }
}
class DetailPengikut extends StatefulWidget {
  @override
  _DetailPengikutState createState() => _DetailPengikutState();
}

class _DetailPengikutState extends State<DetailPengikut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[

                        Card(
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
              backgroundImage: NetworkImage('https://korea.iyaa.com/article/2017/05/__icsFiles/thumbnail/2017/05/08/DO2.jpg'),
            ),
                              ),
                              SizedBox(width: 10.0,),


                              Flexible(
                                flex: 2,
                                                              child: Container(
                                  child: Row(
                                    children: <Widget>[
                                    Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Nama",style: TextStyle(fontSize: 12.0), ),
                               
                                Text("Alamat",style: TextStyle(fontSize: 12.0), ),
                        
                                Text("Jenis Kelamin",style: TextStyle(fontSize: 12.0), ),
                              
                                Text("Relais",style: TextStyle(fontSize: 12.0), ),
                               
                              ],
                            ),
                            SizedBox(width: 5.0,),

                                      Column(
                              children: <Widget>[
                                Text(":",style: TextStyle(fontSize: 12.0), ),
                          
                                Text(":",style: TextStyle(fontSize: 12.0), ),
                         
                                Text(":",style: TextStyle(fontSize: 12.0), ),
                               
                                Text(":",style: TextStyle(fontSize: 12.0), ),
                              
                              ],
                            ),
                             SizedBox(width: 5.0,),
                                       Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                      
                                 
                                      Text("Aldi Mahesa Putra",style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), ),
                                     
                                      Text("Kediri, Lombok Barat",style: TextStyle(fontSize: 12.0), ),
                                     
                                      Text("Teman ",style: TextStyle(fontSize: 12.0), ),
                                    
                                      Text("081907587877",style: TextStyle(fontSize: 12.0), ),
                                     
                                      ],

                                    ),

                                    ],
                                                                      
                                  ),
                                ),
                              )

                               
                              

                            ],
                          ),
                                                  ),
                        ),
                        SizedBox(height: 10.0,)



                      

                      

                      ],
                    ),
                        
                                          
                                         
                    ) ,
      );
  }
}
