//BT19CSE004
//Vedant Ghuge
//CSE A 4th Sem
//Drive Demo Link : https://drive.google.com/file/d/16mols4gqabpsJejab3XeuLt_xojCEGgc/view

//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flip_card/flip_card.dart';

void main() => runApp(MyApp());

class Theme with ChangeNotifier {
  static bool _dark = true;
  ThemeMode currentTheme() {
    return _dark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _dark = !_dark;
    notifyListeners();
  }
}

Theme currentTheme = Theme();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print('Changes');
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  void initState() {
    super.initState();
  }

  final List<WordPair> _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator (BT19CSE004)'),
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                _pushSavedold();
              }),
        ],
      ),
      floatingActionButton: Column(
          verticalDirection: VerticalDirection.up,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                heroTag: "Tag 1",
                onPressed: () {
                  currentTheme.switchTheme();
                },
                label: Text("Switch Themes"),
                icon: Icon(Icons.adb),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                heroTag: "Tag 2",
                onPressed: () {
                  if (_saved.length < 4) {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Arrrrr........'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                child: Text('You need to make 4 selections.')),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Take Me Back'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else
                    _pushSaved();
                },
                label: Text("Next"),
              ),
            ),
          ]),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Startup Name Generator (BT19CSE004)',
              ),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: frontContainer(
                            "https://picsum.photos/id/1016/250?grayscale"),
                        //frontContainer('https://i.redd.it/3xupjbo17si61.gif'),
                        back: backContainer(0),
                      ),
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: frontContainer(
                            "https://picsum.photos/id/1032/250?grayscale"),
                        //front: frontContainer('https://i.redd.it/1jv6pyno9si61.jpg'),
                        back: backContainer(1),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: frontContainer(
                            "https://picsum.photos/id/1019/250?grayscale"),
                        //front: frontContainer('https://i.redd.it/bv0d9tdv0ri61.jpg'),
                        back: backContainer(2),
                      ),
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: frontContainer(
                            "https://picsum.photos/id/1018/250?grayscale"),
                        //front: frontContainer('https://i.redd.it/0sxjpckttri61.jpg'),
                        back: backContainer(3),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Center(
                          child: RaisedButton(
                              child: Text("Go Back"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                      )
                    ],
                  )
                ]),
          );
        },
      ),
    );
  }

  Widget backContainer(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 165,
          width: 165,
          child: _buildFront(_saved.elementAt(index).asPascalCase)),
    );
  }

  Widget frontContainer(String url) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 165,
        width: 165,
        child: _buildRear(DecorationImage(image: NetworkImage(url))),
      ),
    );
  }

  Widget _buildFront(String name) {
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Colors.blue,
      faceName: name,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child: FlutterLogo(),
        ),
      ),
    );
  }

  Widget _buildRear(DecorationImage image) {
    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.blue.shade700,
      faceName: "",
      image: image,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child:
              Center(child: Text("Flutter", style: TextStyle(fontSize: 50.0))),
        ),
      ),
    );
  }

  Widget __buildLayout(
      {Key key,
      Widget child,
      String faceName,
      Color backgroundColor,
      DecorationImage image}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        image: image,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(faceName, style: TextStyle(fontSize: 20.0)),
      ),
    );
  }

  void _pushSavedold() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                currentTheme.switchTheme();
              },
              label: Text("Switch Themes"),
              icon: Icon(Icons.adb),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            if (_saved.length == 4) {
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Arrrrr........'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          SizedBox(child: Text('Only 4 Selections Allowed.')),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Take Me Back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
            _saved.add(pair);
          }
        });
      },
    );
  }
}
