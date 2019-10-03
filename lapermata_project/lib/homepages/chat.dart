import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lapermata_project/homepages/belum_login.dart';

class ChatLogin extends StatelessWidget {
  const ChatLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ChatBloc(),
      child: MaterialApp(home:  BuildView(),));
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
    kodeNavBar = 5;
  }

  @override
  Widget build(BuildContext context) {
    return kodeUsers != "" ? ChatSetelahLogin() : BelumLogin();
  }
}

class ChatSetelahLogin extends StatefulWidget {
  @override
  _ChatSetelahLoginState createState() => _ChatSetelahLoginState();
}



class _ChatSetelahLoginState extends State<ChatSetelahLogin> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.blueAccent,
  );

  TextEditingController controllerchat = new TextEditingController();

  ScrollController _scrollController = new ScrollController();
  

  @override
  void initState() {
    super.initState();
    final mBloc = Provider.of<ChatBloc>(context, listen:false);
    mBloc.chatLog();
  }


  List cards;

  Widget dataChat() {
    cards = new List.generate(
        dataAPIChat.length,
        (i) => new CardChat(
              align: dataAPIChat[i]['chat_dari'] == 1
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              date: dataAPIChat[i]['tanggal'],
              text: dataAPIChat[i]['chat'],
              color: dataAPIChat[i]['chat_dari'] == 1
                  ? Colors.white
                  : Colors.lightBlueAccent[100],
            )).toList();

    ListView dataList = ListView(
      controller: _scrollController,
      children: this.cards,
      reverse: true,
    );

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        leading: new Icon(Icons.message),
        title: new Text("Chat Dengan Admin"),
      ),
      body: Container(
          child: Stack(children: <Widget>[
        Center(
          child: new Image.asset(
            'assets/wa-bg.png',
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: StreamBuilder(
                  stream: Stream<int>.periodic(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return dataChat();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: new TextFormField(
                  controller: controllerchat,
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                      hintText: "Tulis Pesan Anda ...",
                      labelText: "Pesan",
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (controllerchat.text != "") {
                            String url = 'http://lapermata.site/api/chat/save';
                            Map map = {
                              'kode_user': kodeUsers,
                              'chat': controllerchat.text
                            };

                            apiRequestChat(url, map);

                            controllerchat.text = "";
                            _scrollController.jumpTo(100.0);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          }

                          _scrollController.jumpTo(100.0);

                          /*ambildata();
                          cards = new List.generate(
                              dataAPI.length,
                              (i) => new CardChat(
                                    align: dataAPI[i]['chat_dari'] == 1
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                    title: dataAPI[i]['chat_dari'] == 1
                                        ? "Admin"
                                        : "Anda",
                                    text: dataAPI[i]['chat'],
                                    color: dataAPI[i]['chat_dari'] == 1
                                        ? Colors.white
                                        : Colors.blue[200],
                                  )).toList();*/
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0))),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}

class CardChat extends StatelessWidget {
  CardChat({this.text, this.date, this.color, this.align});
  final String text;
  final String date;
  final Color color;
  final CrossAxisAlignment align;
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: align,
                  children: <Widget>[
                    new Text(
                      text,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    new Text(
                      date,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

Future<String> apiRequestChat(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

List dataAPIChat = [
    {
      "chat": "",
      "chat_dari": 1,
      "id": 0,
      "kode_user": "",
      "status": 1,
      "tanggal": ""
    }
  ];

class ChatBloc with ChangeNotifier {
  Future<void> chatLog() async{
    Timer.periodic(Duration(seconds: 1), (t) async{
      try {
        await http.get("http://lapermata.site/api/chat/list/$kodeUsers").then(
          (a){
            notifyListeners();
            dataAPIChat = json.decode(a.body);
          },
        );
      } catch (e) {
        print("");
      }
    });
  }
}