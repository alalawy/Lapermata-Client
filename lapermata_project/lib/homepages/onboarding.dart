import 'package:flutter/material.dart';
import 'package:lapermata_project/home.dart';


class IntroPertama extends StatefulWidget {
  @override
  _IntroPertamaState createState() => _IntroPertamaState();
}

class _IntroPertamaState extends State<IntroPertama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new  Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightBlue, Colors.pinkAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(),
          ),


          Flexible(
            flex: 1,
            child: Center(
              child: Image.asset('assets/app.png', ),
            ),
          ),

          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: <Widget>[

                    Column(
                      children: <Widget>[
                        Text("Dapatkan Informasi Lengkap Mengenai Lapas Perempuan Kelas III Mataram - NTB", 
                        textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),),
                        SizedBox(height: 30.0,),
                    Text('Kini informasi terupdate dan lengkap dari berita, kegiatan serta aktivitas seputar Lapas Perempuan Kelas III Mataram dapat anda lihat di Aplikasi Lapermata ',textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0, color: Colors.white),),
                    SizedBox(height: 10.0,),
                      ],
                    ),
                    

                     Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: <Widget>[
                       
                         FlatButton(
                           
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new BottomNavBar()));


                          },
                          child: Text('Lewati', style: TextStyle(color: Colors.white),),
                        ),

                        FlatButton(
                          onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new IntroKedua()));


                          },
                          child: Text('Berikutnya',style: TextStyle(color: Colors.white)),
                        )
                      ],
                    )

                          
                        )
                    
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
      
    ),
    );
    
    
   
  }
}


class IntroKedua extends StatefulWidget {
  @override
  _IntroKeduaState createState() => _IntroKeduaState();
}

class _IntroKeduaState extends State<IntroKedua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
       decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightBlue, Colors.deepPurpleAccent])),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(),
          ),


          Flexible(
            flex: 1,
            child: Center(
              child: Image.asset('assets/scadule.png', ),
            ),
          ),

          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  
                  Column(
                    children: <Widget>[
                      Text('Atur Jadwal Kunjungan Anda Menjadi Lebih Mudah',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),),
                       SizedBox(height: 30.0,),
                  Text('Kini pengajuan kunjungan dapat dilakukan melalui aplikasi, dimana saja dan kapan saja sesuai keinginan anda', textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0, color: Colors.white),),
                  SizedBox(height: 10.0,),
                    ],
                  ),
                 

                   Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      FlatButton(
                         
                        onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new IntroPertama()));


                        },
                        child: Text('Sebelumnya', style: TextStyle(color: Colors.white),),
                      ),
                     
                       FlatButton(
                         
                        onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new BottomNavBar()));


                        },
                        child: Text('Lewati', style: TextStyle(color: Colors.white),),
                      ),
                      

                      FlatButton(
                        onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new IntroKetiga()));

                          
                        },
                        child: Text('Berikutnya',style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )

                        
                      )
                  
                ],
              ),
            ),
          ),


        ],
      ),
      
    ),
    );
    
    
    
  }
}


class IntroKetiga extends StatefulWidget {
  @override
  _IntroKetigaState createState() => _IntroKetigaState();
}

class _IntroKetigaState extends State<IntroKetiga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new  Container(
       decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [Colors.greenAccent, Colors.lightBlue])),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(),
          ),


          Flexible(
            flex: 1,
            child: Center(
              child: Image.asset('assets/family.png',),
            ),
          ),

          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Column(
                    children: <Widget>[
                      Text('Pantau Kondisi Keluarga Binaan',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),),
                       SizedBox(height: 30.0,),
                  Text('Dapatkan update informasi lengkap mengenai keluarga anda yang menjadi keluarga binaan Lapas Perempuan Kelas III Mataram',textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0, color: Colors.white),),
                  SizedBox(height: 10.0,),
                    ],
                  ),
                 

                   Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                     
                       FlatButton(
                         
                        onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new IntroKedua()));


                        },
                        child: Text('Sebelumnya', style: TextStyle(color: Colors.white),),
                      ),

                      FlatButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new BottomNavBar()));
                          

                          
                        },
                        child: Text('Menu Utama',style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )

                        
                      )
                  
                ],
              ),
            ),
          ),


        ],
      ),
      
    ),
    );
    
    
   
  }
}