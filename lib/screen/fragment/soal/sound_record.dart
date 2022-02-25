// import 'package:flutter/material.dart';
// import 'package:flutter_sound_lite/public/flutter_sound_Recorder.dart';
// import 'package:permission_handler/permission_handler.dart';

// final pathToSaveAudio = 'audio_test.aac';

// class SoundRecorder {
//   FlutterSoundRecorder _soundRecorder;
//   bool _isRecorderInitialised = false;

//   bool get isRecording => _soundRecorder.isRecording;

//   Future init() async {
//     _soundRecorder = FlutterSoundRecorder();

//     await _soundRecorder.openAudioSession();

//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Mohon izinkan akses microphon');
//     }

//     await _soundRecorder.closeAudioSession();
//     _isRecorderInitialised = true;
//   }

//   void dispose() {
//     if(!_isRecorderInitialised) return;
//     _soundRecorder.closeAudioSession();
//     _soundRecorder = null;
//     _isRecorderInitialised = false;
//   }

//   Future _record() async {
//     if (!_isRecorderInitialised) return;

//     await _soundRecorder.startRecorder(
//       toFile: pathToSaveAudio
//     );
//   }

//   Future _stop() async {
//     if (!_isRecorderInitialised) return;

//     await _soundRecorder.stopRecorder();
//   }

//   Future togglePlaying() async {
//     if (_soundRecorder.isStopped) {
//       await _record();
//     } else {
//       await _stop();
//     }
//   }
// }
