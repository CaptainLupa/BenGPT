import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  if (!Platform.isWindows && !Platform.isMacOS) {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(const BenGPT());
}

class BenGPT extends StatefulWidget {
  const BenGPT({super.key});

  @override
  State<BenGPT> createState() => _BenGPTState();
}

class _BenGPTState extends State<BenGPT> {
  final random = Random();
  String answer = "";
  List<Text> history = [];
  List<String> responses = [
    "Check OPSWiki",
    "It's on OPSWiki",
    "*Stares at you for 8 seconds*",
    "Did you check OPSWiki yet?",
    "I put it on OPSWiki yesterday",
  ];
  TextEditingController controller = TextEditingController();

  void processQuestion(value) {
    controller.text = "";

    setState(() {
      answer = responses[random.nextInt(responses.length)];
      history.insert(0, Text("You: " + value + "\nBen: " + answer));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextField question = TextField(
      decoration: const InputDecoration(
          hintText: "Ask Ben a question:", border: OutlineInputBorder()),
      onSubmitted: processQuestion,
      controller: controller,
    );

    return MaterialApp(
        title: "BenGPT",
        home: Scaffold(
            appBar: AppBar(title: const Text("BenGPT")),
            body: ListView(
              children: [
                Column(
                    children:
                        history.length > 1 ? history.sublist(1) : List.empty()),
                //const Spacer(flex: 2),
                Center(child: Text(answer)),
                //const Spacer(flex: 1),
                Align(alignment: Alignment.bottomCenter, child: question),
              ],
            )));
  }
}
