// ignore_for_file: deprecated_member_use, unused_field, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:TesUjian/helper/getStorage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/local.dart';
import 'package:http/http.dart' as http;
import 'package:TesUjian/helper/paths.dart';

import 'package:record/record.dart';

class RecorderQoliyahView extends StatefulWidget {
  final Function onSaved;
  final Function onDuplicate;
  final int number;

  const RecorderQoliyahView(
      {Key key, @required this.onSaved, this.onDuplicate, this.number})
      : super(key: key);
  @override
  _RecorderQoliyahViewState createState() => _RecorderQoliyahViewState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}
LocalFileSystem fs = LocalFileSystem();

class _RecorderQoliyahViewState extends State<RecorderQoliyahView> {
  IconData _recordIcon = Icons.mic_none;
  String _recordText = 'Click To Start';
  RecordingState _recordingState = RecordingState.UnSet;
  bool _isRecording = false;

  // Record Properties
  final _audioRecorder = Record();

  @override
  void initState() {
    super.initState();

    _audioRecorder.hasPermission().then((hasPermission) {
      if (hasPermission) {
        _recordingState = RecordingState.Set;
        _recordIcon = Icons.mic;
        _recordText = 'Record';
      }
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.UnSet;
    _audioRecorder.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RaisedButton(
          onPressed: () async {
            await _onRecordButtonPressed();
            setState(() {});
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 60,
            height: 50,
            child: Icon(
              _recordIcon,
              size: 20,
            ),
          ),
        ),
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Padding(
        //       child: Text(_recordText),
        //       padding: const EdgeInsets.all(8),
        //     ))
      ],
    );
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_recordingState) {
      case RecordingState.Set:
        await _recordVoice();
        break;

      case RecordingState.Recording:
        await _stopRecording();
        _recordingState = RecordingState.Stopped;
        _recordIcon = Icons.fiber_manual_record;
        _recordText = 'Record new one';
        break;

      case RecordingState.Stopped:
        await _recordVoice();
        break;

      case RecordingState.UnSet:
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please allow recording from settings.'),
        ));
        break;
    }
  }

  _initRecorder() async {
    // Directory appDirectory = await getApplicationDocumentsDirectory();
    // String filePath =
    //     appDirectory.path + '/' + widget.number.toString() + '.aac';
  }

  _startRecording() async {
    // await audioRecorder.start();
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath =
        appDirectory.path + '/' + widget.number.toString() + '.aac';
    await _audioRecorder.start(
      path: filePath, // required
      encoder: AudioEncoder.AAC, // by default
      bitRate: 128000, // by default
    );

    bool isRecording = await _audioRecorder.isRecording();
    setState(() {
      _isRecording = isRecording;
    });
    // await audioRecorder.current(channel: 0);
  }

  _stopRecording() async {
    await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
    });
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath =
        appDirectory.path + '/' + widget.number.toString() + '.aac';
    print('tempat ' + filePath);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${Paths.BASEURL}${Paths.PRAKTEKIBADAH_UPDATEJAWABAN}"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('filename',
        File(filePath).readAsBytes().asStream(), File(filePath).lengthSync(),
        filename: 'Qoliyah' +
            GetStorage().read(ID_MURID).toString() +
            filePath.split("/").last));
    request.headers.addAll(headers);
    request.fields.addAll({
      "id": widget.number.toString(),
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      // final respStr = await response.stream.bytesToString();
      // var hasil = json.decode(respStr);
      return widget.onSaved('Qoliyah' +
          GetStorage().read(ID_MURID).toString() +
          filePath.split("/").last);
    }
  }

  Future<void> _recordVoice() async {
    if (await _audioRecorder.hasPermission()) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      String filePath =
          appDirectory.path + '/' + widget.number.toString() + '.aac';
      File file = fs.file(filePath);
      if (await file.exists()) {
        print("A file already exists at the path :" + filePath);
        widget.onDuplicate();
      } else if (!await file.parent.exists()) {
        print("The specified parent directory does not exist");
      } else {
        await _initRecorder();

        await _startRecording();
        _recordingState = RecordingState.Recording;
        _recordIcon = Icons.stop;
        _recordText = 'Recording';
      }
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please allow recording from settings.'),
      ));
    }
  }
}
