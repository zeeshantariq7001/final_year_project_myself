// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText extends StatefulWidget {
  const SpeechToText({Key? key}) : super(key: key);

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  final TextEditingController _textC = TextEditingController();

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    _listen();
  }

  void onRecognitionResult() => setState(() => _textC.text = _text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Confidence : ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _listen();
          onRecognitionResult();
        },
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            TextFormField(
              controller: _textC,
            ),
            Text(_textC.text)
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(onStatus: (val) {
        print("onStatus: $val");
      }, onError: (val) {
        print("onError: $val");
      });
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech!.listen(onResult: (val) {
          setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          });
        });
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech!.stop();
    }
  }
}
