import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool lang = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Translate"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  lang = !lang;
                });
              },
              icon: const Icon(Icons.language))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            textBuilder(
                "What is Lorem Ipsum?",
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                lang),
            const SizedBox(
              height: 20,
            ),
            textBuilder(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                lang),
          ],
        ),
      ),
    );
  }

  FutureBuilder<Widget> textBuilder(String text, TextStyle style, bool lang) {
    return FutureBuilder(
        future: setText(text, style, lang),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ?? const Text("Loading...");
          }
          return const Text("");
        });
  }
  Future<Widget> setText(String value, TextStyle style, bool lang) async {
    if (lang) {
      final translator = GoogleTranslator();
      Translation text =
          await translator.translate(value, from: 'en', to: 'hi');
      return Text(
        text.text,
        style: style,
      );
    } else {
      return Text(
        value,
        style: style,
      );
    }
  }
}
