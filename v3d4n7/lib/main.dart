//BT19CSE004
//Vedant Ghuge
//CSE A 4th Sem

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MaterialApp(
    title: 'First Screen (BT19CSE004)',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/second': (context) => SecondScreen(),
    },
  ));
}

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
      initialRoute: '/',
      routes: {
        '/': (context) => RandomWords(),
        '/second': (context) => SecondScreen(),
      },
      //home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  //@override
  final List<WordPair> _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator (BT19CSE004)'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
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
              onPressed: _pushSaved2,
              // onPressed: () {
              //   //Navigator.pushNamed(context, '/second');
              //   _pushSaved2();
              // },
              label: Row(
                children: [
                  Text("Next"),
                  Icon(Icons.arrow_right_alt_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
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

  void _pushSaved2() {
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

          // Widget getContainer() {
          //   return Container(
          //     height: 200,
          //     width: 200,
          //     margin: EdgeInsets.all(25.0),
          //     color: Colors.blue,
          //   );
          // }

          // return Scaffold(
          //   appBar: AppBar(
          //     backgroundColor: Colors.blueGrey[900],
          //     title: Center(
          //       child: Text(
          //         'Flutter GridView',
          //         style: TextStyle(
          //           color: Colors.blueAccent,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20.0,
          //         ),
          //       ),
          //     ),
          //   ),
          //   body: Column(children: <Widget>[
          //     Row(
          //       //ROW 1
          //       children: [
          //         getContainer(),
          //         getContainer(),
          //       ],
          //     ),
          //     Row(//ROW 2
          //         children: [
          //       getContainer(),
          //       getContainer(),
          //     ]),
          //   ]),
          // );

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
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
