import 'package:clabbers/quote_list.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:scrabble/scrabble.dart';

import 'feedbackform.dart';
import 'judgebar.dart';
import 'my_drawer_header.dart';

void main() => runApp(const SearchEditingControllerExampleApp());

class SearchEditingControllerExampleApp extends StatelessWidget {
  const SearchEditingControllerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextEditingControllerExample(),
    );
  }
}

class TextEditingControllerExample extends StatefulWidget {
  const TextEditingControllerExample({super.key});

  @override
  State<TextEditingControllerExample> createState() =>
      _TextEditingControllerExampleState();
}

class _TextEditingControllerExampleState extends State<TextEditingControllerExample> {
  final TextEditingController _searchController = TextEditingController();
  List<List<dynamic>> allWords = [
    ["Please wait"]
  ];
  Map<String, String> definitions = {};

  @override
  void initState() {
    super.initState();
    getWords(); // Load the CSV file when the widget is created
    _searchController.addListener(() {
      final String text = _searchController.text.toUpperCase();
      _searchController.value = _searchController.value.copyWith(
        text: text,
      );
    });
  }

  void getWords() async {
    // TODO: Make Clabbers logo
    // TODO: add a loading screen after 2 press
    final x = await rootBundle.loadString("assets/csvfile/all_words.csv");
    setState(() {
      allWords = const CsvToListConverter().convert(x);
      allWords.forEach((element) {
        definitions[element[0].toString()] = element[1].toString();
      });
    });
  }

  void checkWord() {
    if (_searchController.text == '') {
      return;
    }
    String searchWord = _searchController.text.toUpperCase(); // Convert to uppercase
    String? definition = definitions[searchWord];

    if (definition != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(searchWord),
            content: Text(definition),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Word Not Found'),
            content: Text('The word you entered was not found in the dictionary.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff6d3fa4),
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
            const Text('Dictionary: CSW22', style: TextStyle(fontSize: 20.0,)
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Check the definition of any word', style: TextStyle(fontSize: 20.0),),
            const SizedBox(height: 20.0),
            Container(
              width: 400,
              child: Center(
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _searchController,
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
              onPressed: checkWord,
              tooltip: 'Check your word!',
              child: const Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
