import 'package:clabbers/quote_list.dart';
import 'package:clabbers/searchbar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
// import 'package:scrabble/scrabble.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'feedbackform.dart';
import 'my_drawer_header.dart';


void main() => runApp(JudgeBar());

class JudgeBar extends StatelessWidget {
  JudgeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextEditingControllerExample(),
    );
  }
}

class TextEditingControllerExample extends StatefulWidget {
  TextEditingControllerExample({super.key});
  @override
  State<TextEditingControllerExample> createState() =>
      _TextEditingControllerExampleState();
}

class _TextEditingControllerExampleState extends State<TextEditingControllerExample> {
  final TextEditingController _wordController = TextEditingController();
  bool check = false;
  var word_index;

  Future<List<String>> _loadQuestions() async {
    List<String> questions = [];
    await rootBundle.loadString('assets/csvfile/scrabbleflutter.txt').then((csvlist1) {
      var csvlist2 = json.decode(csvlist1).cast<String>().toList();
      // print(csvlist2);
      _scrabfunc(csvlist2);
    },);


    return questions;
  }



  @override
  void initState() {
    _setup();
    super.initState();
    _wordController.addListener(() {
      final String text = _wordController.text.toUpperCase();
      _wordController.value = _wordController.value.copyWith(
        text: text,
      );
    });
  }

  _setup() async {
    List<String> questions = await _loadQuestions();
    // List<String> definitions = await _loadDefinitions();
    setState(() {
      var tch = questions;
      // var cht = definitions;
    });
  }

  _scrabfunc(csvlistcheck) async {
    if (_wordController.text.isEmpty) {
      return;
    }

    final inputText = _wordController.text.trim();
    final words = inputText.split(RegExp(r'\s+'));

    bool allWordsExist = true;

    setState(() {
      check = false; // Initialize check to false
    });

    print(words);

    for (final word in words) {
      final trimmedWord = word.trim(); // Trim the word
      if (!csvlistcheck.contains(trimmedWord.toUpperCase())) {
        allWordsExist = false;
        print(word + " word exists");
        break;
      }
    }
    setState(() {
      check = allWordsExist; // Set check based on the flag
    });

    if (allWordsExist) {
      // All words exist, find the index of the first word
      word_index = csvlistcheck.indexOf(words.first);
      print("All words exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Judge', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.0
        ) ,
        ),
        backgroundColor: const Color(0xff6d3fa4),
        centerTitle: true,
        // leading: GestureDetector(
        //     child: Icon(Icons.home),
        //     onTap: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => QuoteList()),
        //       );
        //     }),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            MyHeaderDrawer(),
            const SizedBox(
              height: 15.0,
            ),
            ListTile(
              title: const Center(
                child: Row(
                  children: [
                    Icon(Icons.quiz_sharp),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Quiz',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // print('quiz tapped');
                setState(() {});

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => QuoteList()));
              },
            ),
            const SizedBox(
              height: 3.0,
            ),
            ListTile(
              title: const Center(
                child: Row(
                  children: [
                    Icon(Icons.pan_tool),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Judge',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // print('judge tapped');
                setState(() {});
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => JudgeBar()));
              },
            ),
            const SizedBox(
              height: 3.0,
            ),
            ListTile(
              title: const Center(
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // print('search tapped');
                setState(() {});
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SearchEditingControllerExampleApp()));
              },
            ),
            ListTile(
              title: const Center(
                child: Row(
                  children: [
                    Icon(Icons.feedback_sharp),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // print('feedback form tapped');
                setState(() {});
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FeedbackForm()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(onTap: () => _launchURL,child: const Text('Dictionary: CSW22', style: TextStyle(fontSize: 20.0,),)),
            SizedBox(
              height: 20.0,
            ),
            Text('Check words upto 15 letters', style: TextStyle(fontSize: 20.0),),
            const SizedBox(height: 20.0),
            Container(
              width: 400,
              child: Center(
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _wordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Enter your word",
                    // hintText: "Input Text",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FloatingActionButton(
              onPressed: () {
                _loadQuestions();
                List<String> words = _wordController.text.split(' ').where((word) => word.isNotEmpty).toList();
                showDialog(
                    context: context,
                    builder: (context)=>
                    check == true?

                    AlertDialog(
                      content: Container(
                        height: 80,
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.check_circle, size: 45.0, color: Colors.green,),
                              SizedBox(height: 10,),
                              Text(words.join(', '), style: TextStyle(fontSize: 20.0, ),),
                              // Text(definition),
                            ],
                          ),
                        ),
                      ),
                    )
                        :
                    AlertDialog(
                      content: Container(
                        width: 100,
                        height: 100,
                        // color: Colors.orange,
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(Icons.sms_failed_outlined, size: 45.0, color: Colors. red),
                              SizedBox(height: 10,),
                              Text(words.join(', '), style: const TextStyle(fontSize: 20.0, ),),
                            ],
                          ),
                        ),
                      ),
                    )
                );
              },
              child: Icon(Icons.check),
              tooltip: 'Check your word!',
            ),
          ],
        ),
      ),
    );
  }
}


_launchURL() async {
  final Uri url = Uri.parse('https://en.wikipedia.org/wiki/Collins_Scrabble_Words');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
