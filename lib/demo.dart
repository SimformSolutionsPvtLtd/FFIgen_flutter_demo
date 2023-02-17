import 'dart:ffi';

import 'audio_player.dart';

Future<void> main() async {
  DynamicLibrary lib = DynamicLibrary.open('lib/libaudioplayer1.dylib');
  AudioPlayerUtils audioPlayerLibrary = AudioPlayerUtils(lib);
  await Future.delayed(Duration.zero);
  final player = AudioPlayer.new1(audioPlayerLibrary);

  player.playWithPath_(NSString(audioPlayerLibrary,
      'lib/assets_audio.mp3'));

  print('player started');

  await Future.delayed(
    const Duration(seconds: 5),
    () => player.stopAudio(),
  );

  print('player stopped');
}
