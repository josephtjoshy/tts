import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  String result = "", output = "Listening";

  Future _listen() async {
    await speechToText.initialize(
      onStatus: (val) => print("LISTENING"),
      onError: (val) => print("ERROR"),
    );
    await speechToText.listen(
      onResult: (val) => setState(() {
        result = val.recognizedWords;
      }),
    ).then((value) => speak());
  }

  Future speak() async {
    if (result.toLowerCase() == 'hi') {
      setState(() {
        output = "Heloooo";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _listen();
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
            ),
            Text("$result"),
            Text("$output"),
          ],
        ),
      ),
    );
  }
}
