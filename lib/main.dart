import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048.dart';
import 'ball.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

}

enum _Game {
  BALL, GAME2048,
}

extension _GameExtension on _Game {

  String get name {
    switch (this) {
      case _Game.BALL:
        return "BALL";
      case _Game.GAME2048:
        return "2048";
    }
  }

  Widget get screen {
    switch (this) {
      case _Game.BALL:
        return BallScreen();
      case _Game.GAME2048:
        return Game2048Screen();
    }
  }

}

class _MyAppState extends State<MyApp> {

  _Game? _selectedGame;
  List<_Game> games = _Game.values;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game & Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('HomePage'),
            child: MyHomePage(
              title: 'Game & Flutter',
              onTapped: _handleGameTapped,
            ),
          ),
          if (_selectedGame != null)
            MaterialPage(
              key: ValueKey(_selectedGame),
              child: _selectedGame!.screen
            )

        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          setState(() {
            _selectedGame = null;
          });
          return true;
        },
      )

    );
  }

  void _handleGameTapped(_Game game) {
    setState(() {
      _selectedGame = game;
    });
  }
}

class MyHomePage extends StatelessWidget {


  final String title;
  final ValueChanged<_Game> onTapped;

  MyHomePage({Key? key, required this.title, required this.onTapped }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
        ),
        body: ListView(
          children: [
            for (var game in _Game.values)
              ListTile(
                title: Text(game.name),
                onTap: () => onTapped(game),
              )
          ],
        )
      //SingleChildScrollView(
      //  child: BallGame()
      // ),
    );
  }

}


class BallScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game & Flutter: BALL"),
      ),
      body: SingleChildScrollView(child: BallGame()),
    );
  }
}

class Game2048Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: Game2048()),
    );
  }
}