import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lapermata_project/homepages/aturkunjungan.dart';
import 'package:lapermata_project/homepages/lapastoday.dart';
import 'package:lapermata_project/homepages/pantaukeluarga.dart';
import 'package:lapermata_project/homepages/akun.dart';
import 'package:lapermata_project/homepages/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final Dashboard _dashboardTL = Dashboard();
  final KunjunganLogin _aturKunjunganTL =
      new KunjunganLogin();
  final PantauKeluargaLogin _pantauKeluargaTL =
      new PantauKeluargaLogin();
  final AkunLogin _akunTL = new AkunLogin();
  final ChatLogin _chatTL = new ChatLogin();

  Widget _showPage = new Dashboard();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _dashboardTL;
        break;
      case 1:
        return _aturKunjunganTL;
        break;
      case 2:
        return _pantauKeluargaTL;
        break;
      case 3:
        return _akunTL;
        break;
      case 4:
        return _chatTL;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              'No Page Found',
              style: new TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
      index: pageIndex,
      height: 55.0,
      items: <Widget>[
        Icon(
          Icons.dashboard,
          size: 24,
          color: Colors.white,
        ),
        Icon(
          Icons.bookmark_border,
          size: 24,
          color: Colors.white,
        ),
        Icon(
          Icons.favorite_border,
          size: 24,
          color: Colors.white,
        ),
        Icon(
          Icons.perm_identity,
          size: 24,
          color: Colors.white,
        ),
        Icon(
          Icons.forum,
          size: 24,
          color: Colors.white,
        ),
      ],
      color: Colors.lightBlue,
      buttonBackgroundColor: Colors.lightBlue,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int tappedIndex) {
        setState(() {
          _showPage = _pageChooser(tappedIndex);
        });
      },
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        bottomNavigationBar: curvedNavigationBar,
        body: Container(
          color: Colors.white,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}
