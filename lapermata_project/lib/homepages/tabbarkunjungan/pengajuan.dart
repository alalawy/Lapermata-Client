import 'package:flutter/material.dart';
import 'multi_form.dart';

class PengajuanKunjungan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
       
        platform: TargetPlatform.android,
      ),
      debugShowCheckedModeBanner: false,
      home: Pengajuan(),
    );
    
  }
}

class Pengajuan extends StatefulWidget {
  @override
  _PengajuanState createState() => _PengajuanState();
}

class _PengajuanState extends State<Pengajuan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
           new MultiForm()
          
      
    );
  }
}