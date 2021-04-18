//import 'dart:developer';
import 'dart:math';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import "package:hovering/hovering.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BT19CSE004 Pintrest Clone',
      theme: ThemeData(primarySwatch: Colors.redAccent[600]),
      home: MyHomePage(title: 'This is a Title'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 20;
  ScrollController _scrollController;
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 20;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 10;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      //print(_scrollController.position.maxScrollExtent);
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <
          200) _incrementCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.grey[300],
          backgroundColor: Colors.white,
          //title: Text(widget.title),
          title: Text("Pinterest Clone"),
          actions: <Widget>[
            getButtons(
                child: Icon(Icons.menu), onpresssed: onPressed, minWidth: 50),
            getButtons(
                child: Icon(Icons.home_outlined),
                onpresssed: onPressed,
                minWidth: 50,
                //color: Colors.red ,
                hoverColor: Colors.red),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: false,
                  cursorColor: Colors.black,
                  // style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined),
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: 'Search',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            getButtons(
                child: Icon(Icons.add_alert),
                onpresssed: onPressed,
                minWidth: 50,
                textColor: Colors.red,
                hoverColor: Colors.red),
            //getButtons(child: Text("Reset"), onpresssed: _resetCounter),
            getButtons(child: Text("Login"), onpresssed: onPressed),
            getButtons(
                child: Icon(Icons.person),
                onpresssed: onPressed,
                minWidth: 50,
                textColor: Colors.grey,
                hoverColor: Colors.grey),
          ]),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          crossAxisCount: 4,
          itemCount: _counter,
          itemBuilder: (BuildContext context, int index) =>
              new Container(child: new ImageBox()),
          // new Container(child: new Text("Image Here")),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
      //floatingActionButton: FloatingActionButton(onPressed: _incrementCounter),
    );
  }

  Padding getButtons(
      {child,
      onpresssed,
      Color hoverTextColor,
      Color hoverColor,
      Color textColor,
      Color color,
      double minWidth}) {
    return Padding(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // color: Color.fromRGBO(5, 5, 5, .5),
      padding: const EdgeInsets.all(8.0),
      child: HoverButton(
        minWidth: minWidth,
        color: color != null ? color : Colors.white,
        hoverTextColor: hoverTextColor != null ? hoverTextColor : Colors.white,
        hoverColor: hoverColor != null ? hoverColor : Colors.black,
        textColor: textColor != null ? textColor : Colors.black,
        onpressed: onpresssed,
        child: child,
      ),
    );
  }
}

class ImageBox extends StatefulWidget {
  // ImageBox(String url);
  ImageBox();
  @override
  _ImageBoxState createState() => _ImageBoxState();
}

int temp = 0;
int countGIF = 0;
int offset = 0;
int limit = 25;

void incrementOffset() {
  offset = offset + limit;
}

int getCount() {
  if (countGIF == limit) {
    incrementOffset();
    countGIF = 0;
  }
  return countGIF++;
}

Future<List<String>> fetchTrending(var test) async {
  if (test != null) return test;
  var response = await http.get(
      "https://api.giphy.com/v1/gifs/trending?api_key=S2caek9KgSdfHo7OqPQwdV9POlLEgSs1&limit=" +
          limit.toString() +
          "&rating=G&offset=" +
          offset.toString());
  var parsed = json.decode(response.body);
  List<Map<String, dynamic>> images =
      parsed["data"].cast<Map<String, dynamic>>();
  return images.map<String>((image) {
    return image["images"]["original"]["url"];
    // return image["images"]["preview_gif"]["url"];
  }).toList();
}

bool truefalse() {
  final random = Random();
  // return true;
  return random.nextBool();
}

class _ImageBoxState extends State<ImageBox> {
  _ImageBoxState();
  var links;
  bool offstage = true;
  final bool gif = truefalse();
  final int count = getCount();

  String url =
      "https://picsum.photos/${400 + 100 * (temp++ % 7).round()}/${600 + 100 * (temp % 5).round()}";
  //var imglink;

  void toggle(PointerEvent details) {
    setState(() {
      this.offstage = !this.offstage;
    });
  }

  Widget build(BuildContext context) {
    final imglink = url.toString();
    // print(url);
    //print(imglink);
    return Container(
      child: MouseRegion(
          onEnter: toggle,
          onExit: toggle,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: gif
                ? FutureBuilder(
                    future: fetchTrending(links),
                    builder: (context, giff) {
                      if (giff.hasData) {
                        links = giff.data;
                        final link = links[count];
                        //print(link);
                        return Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Image.network(
                                  link,
                                  fit: BoxFit.fill,
                                  color: Color.fromRGBO(20, 20, 20, 0.5),
                                  colorBlendMode: this.offstage
                                      ? BlendMode.color
                                      : BlendMode.darken,
                                  // loadingBuilder:
                                  //     (context, child, loadingProgress) {
                                  //   if (loadingProgress == null) return child;

                                  //   return Image.asset("loading.gif");
                                  //   // return Center(
                                  //   //   child: CircularProgressIndicator(
                                  //   //     value: loadingProgress
                                  //   //                 .expectedTotalBytes !=
                                  //   //             null
                                  //   //         ? loadingProgress
                                  //   //                 .cumulativeBytesLoaded /
                                  //   //             loadingProgress
                                  //   //                 .expectedTotalBytes
                                  //   //         : null,
                                  //   //   ),
                                  //   // );
                                  // },
                                ),
                              ),
                              buttonBox(),
                            ]);
                      } else
                        return Image.asset("loading.gif");
                    },
                  )
                : Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                        Container(
                          width: double.infinity,
                          child: Image.network(
                            imglink,
                            fit: BoxFit.fill,
                            color: Color.fromRGBO(100, 100, 100, 0.5),
                            colorBlendMode: this.offstage
                                ? BlendMode.color
                                : BlendMode.darken,
                            // loadingBuilder: (context, child, loadingProgress) {
                            //   if (loadingProgress == null) return child;

                            //   return Image.asset("loading.gif");
                            //   // return Center(
                            //   //   child: CircularProgressIndicator(
                            //   //     value: loadingProgress.expectedTotalBytes !=
                            //   //             null
                            //   //         ? loadingProgress.cumulativeBytesLoaded /
                            //   //             loadingProgress.expectedTotalBytes
                            //   //         : null,
                            //   //   ),
                            //   // );
                            // },
                          ),
                        ),
                        buttonBox(),
                      ]),
          )),
    );
  }

  buttonBox() {
    return Offstage(
      offstage: this.offstage,
      child: Container(
        color: Color.fromRGBO(66, 66, 66, 0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IconButton(
              //     color: Colors.white,
              //     icon: Icon(Icons.file_download),
              //     onPressed: onPressed),
              // IconButton(
              //     color: Colors.white,
              //     icon: Icon(Icons.source_outlined),
              //     onPressed: onPressed),
              // IconButton(
              //     color: Colors.white,
              //     icon: Icon(Icons.share),
              //     onPressed: onPressed),
              // IconButton(
              //     color: Colors.white,
              //     icon: Icon(Icons.more_horiz_outlined),
              //     onPressed: onPressed),

              getButton(icon: Icon(Icons.file_download)),
              getButton(icon: Icon(Icons.source_outlined)),
              getButton(icon: Icon(Icons.share)),
              getButton(icon: Icon(Icons.more_horiz_outlined)),
            ],
          ),
        ),
      ),
    );
  }

  ClipOval getButton({Icon icon, onTap}) {
    return ClipOval(
      child: Material(
        color: Color.fromRGBO(200, 200, 200, 0.75),
        child: InkWell(
          splashColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      decoration:
          //color: Colors.white,
          InputDecoration(
        focusColor: Colors.white,
        border: InputBorder.none,
        hintText: 'Search',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

void onPressed() {}
