import 'dart:ffi';

import 'package:flutter/material.dart';

import 'audio_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = 'Stop';

  late AudioPlayerUtils audioPlayerLibrary;
  late AudioPlayer player;

  Future<void> _incrementCounter() async {
    setState(() => _status = 'player started');
    player.playWithPath_(NSString(audioPlayerLibrary,
        'lib/assets_audio.mp3'));
    await Future.delayed(
      const Duration(seconds: 5),
      () => player.stopAudio(),
    );
    setState(() => _status = 'player stopped');
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var lib = DynamicLibrary.open('libaudioplayer.dylib');
    audioPlayerLibrary = AudioPlayerUtils(lib);
    await Future.delayed(Duration.zero);
    player = AudioPlayer.new1(audioPlayerLibrary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _status,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
