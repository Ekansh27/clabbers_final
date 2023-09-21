import 'dart:convert';

import 'package:clabbers/quote_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrabble/scrabble.dart';
import 'package:csv/csv.dart';
import 'package:collection/collection.dart';
import 'package:csv/csv_settings_autodetection.dart' as csvAuto;
import 'dart:math';

class SixLetterQuiz extends StatefulWidget {
  SixLetterQuiz({super.key});
  @override
  State<SixLetterQuiz> createState() => _SixLetterQuizState();
}

class _SixLetterQuizState extends State<SixLetterQuiz> {
  int i = 0;
  final TextEditingController _sixletterController = TextEditingController();
  List<String> correctGuesses = ["CORRECT GUESSES"];
  List<String> incorrectGuesses = ["INCORRECT GUESSES"];
  List<List<dynamic>> allWords = [
    ["Please wait"]
  ];
  List<List<dynamic>> quizWords = [
    ["Please wait"]
  ];
  Set<dynamic> uniqueWords = Set();
  final anagrammer = Scrabble();
  Set<dynamic> currentAnagrams = Set();
  Map<String, String> definitions = {};
  String jumbledString = '';
  bool answersRevealed = false;

  // Future<List<String>> _loadDefinitions() async {
  //   List<String> definitions = [];
  //   await rootBundle.loadString('assets/csvfile/twos.csv').then(
  //     (csvlistdef) {
  //       var csvlist2def = json.decode(csvlistdef).cast<String>().toList();
  //       // print(csvlist2def);
  //       // _scrabfuncdef(csvlist2def);
  //     },
  //   );
  //
  //   return definitions;
  // }

  void getWords() async {
    // TODO: Make Clabbers logo
    // TODO: add a loading screen after 2 press
    var d = new csvAuto.FirstOccurrenceSettingsDetector(eols: ['\r\n', '\n']);
    final x = await rootBundle.loadString("assets/csvfile/sixes.csv");
    setState(() {
      allWords = CsvToListConverter(csvSettingsDetector: d).convert(x);
      // print(allWords);
      allWords.shuffle();
      allWords.forEach((element) {
        definitions[element[0].toString()] = element[1].toString();
      });
      quizWords = allWords.sublist(0, 20);
      currentAnagrams = anagrammer.anagram(quizWords[i][0].toLowerCase());
      uniqueWords = currentAnagrams
          .where((element) => element.length == quizWords[i][0].length)
          .toSet();
      String originalString = quizWords[i][0];
      jumbledString = shuffleString(originalString);
      // print(jumbledString);
      // print(quizWords.length);
      // print(uniqueWords);
    });
  }

  void nextWord() {
    // To be called when user skips or gets all words right
    setState(() {
      if (i >= 18) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert!'),
              content: const Text('You have reached the end of the quiz \n'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Home'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QuoteList()));
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Play another'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SixLetterQuiz()));
                  },
                ),
              ],
            );
          },
        );
      }
      if (i < 18) {
        i++;
        String originalString = quizWords[i][0];
        jumbledString = shuffleString(originalString);
        currentAnagrams = anagrammer.anagram(jumbledString.toLowerCase());
        uniqueWords = currentAnagrams
            .where((element) => element.length == jumbledString.length)
            .toSet();
        correctGuesses = ["CORRECT GUESSES"];
        incorrectGuesses = ["INCORRECT GUESSES"];
        answersRevealed = false; // Reset the flag here
      }
    });
  }

  void checkWord() {
    if (_sixletterController.text == '') {
      return;
    }

    // TODO: Bind to return button on phone (listener)
    // TODO: remove auto skip, show correct answers when not gone next
    setState(() {
      if (uniqueWords.contains(_sixletterController.text.toLowerCase())) {
        if (!correctGuesses
            .contains(_sixletterController.text.toUpperCase())) {
          correctGuesses.add(_sixletterController.text.toUpperCase());
        }
        // print(equal_length_anagrams.length);
        if (correctGuesses.length - 1 == uniqueWords.length) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Container(
                height: 110,
                child: Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 45.0,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'All correct!',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Row(
                          children: [
                            SizedBox(width: 30.0),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Definitions',
                                  style: TextStyle(fontSize: 20.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: const Text('Quick Guide'),
                                    content: Text('You can check the definition of a word by pressing on it!'),
                                  ),
                                );
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Next',
                                  style: TextStyle(fontSize: 20.0)),
                              onPressed: () {
                                nextWord();
                                Navigator.of(context).pop();
                                if (i >= 18) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Alert!'),
                                        content: const Text(
                                            'You have reached the end of the quiz \n'),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            child: const Text('Home'),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuoteList()));
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            child: const Text('Play another'),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SixLetterQuiz()));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                if (i < 18) {
                                  i++;
                                  currentAnagrams =
                                      anagrammer.anagram(jumbledString.toLowerCase());
                                  uniqueWords = currentAnagrams
                                      .where((element) =>
                                  element.length == jumbledString.length)
                                      .toSet();
                                  correctGuesses = ["CORRECT GUESSES"];
                                  incorrectGuesses = ["INCORRECT GUESSES"];
                                  // print(uniqueWords);
                                  // print(currentAnagrams);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      } else {
        if (!incorrectGuesses
            .contains(_sixletterController.text.toUpperCase())) {
          incorrectGuesses.add(_sixletterController.text.toUpperCase());
        }
      }
    });

    _sixletterController.clear();
  }

  void revealAnswers() {
    setState(() {
      if (!answersRevealed) {
        Set<dynamic> revealedAnswers = uniqueWords.difference(correctGuesses.toSet());
        List<String> revealedAnswersUpperCase = revealedAnswers.map((answer) => answer.toString().toUpperCase()).toList();

        // Filter out the answers that are already correct guesses
        List<String> newRevealedAnswers = [];
        for (var answer in revealedAnswersUpperCase) {
          if (!correctGuesses.contains(answer)) {
            newRevealedAnswers.add(answer);
          }
        }

        correctGuesses.addAll(newRevealedAnswers);
        answersRevealed = true;
      }
    });
  }


  String shuffleString(String input) {
    List<String> chars = input.split('');
    chars.shuffle();
    return chars.join();
  }

  @override
  void initState() {
    super.initState();
    getWords();
    _sixletterController.addListener(() {
      final String text = _sixletterController.text.toUpperCase();
      _sixletterController.value = _sixletterController.value.copyWith(
        text: text,
      );
      if (text.length == jumbledString.length) {
        checkWord();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6 letter words',
            style: TextStyle(
              fontSize: 20,
            )),
        backgroundColor: const Color(0xff6d3fa4),
        centerTitle: true,
        leading: GestureDetector(
            child: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QuoteList()),
              );
            }),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(jumbledString,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22.0)),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 5.1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: correctGuesses
                        .map((guess) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Definition:'),
                              content: Text(definitions[guess]!),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                  ),
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          guess,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    )).toList(),
                  ),
                ),

                // Expanded(
                //   child: const SizedBox(
                //     height: 100.0,
                //   ),
                // ),

                // SizedBox(
                //   width: MediaQuery.of(context).size.width/4,
                //   height: MediaQuery.of(context).size.height/2,
                //   child: ListView.builder(
                //     itemCount: correctGuesses.length,
                //       itemBuilder: (context, index){
                //       return ListTile(
                //         title: GestureDetector(
                //             child: Text(correctGuesses[index]),
                //         ),
                //       );
                //       }
                //   ),
                // ),

                // ],
                // ),
                // ),

                Expanded(
                  child: Column(
                    children: incorrectGuesses
                        .map((guess) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(guess,
                          style: const TextStyle(fontSize: 16.0)),
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  // alignment: Alignment.center,
                  // padding: const EdgeInsets.all(6),
                  child: TextField(
                    controller: _sixletterController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Input Text",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    tooltip: 'Go next word',
                    heroTag: "next",
                    onPressed: nextWord,
                    child: Icon(Icons.skip_next),
                  ),
                ),
              ], // Children of Row
            ),
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width / 4.1),
              Visibility(
                visible: i < 19, // Change this condition based on your requirements
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${correctGuesses.length - 1} / ${uniqueWords.length}',
                      style: const TextStyle(fontSize: 22.5),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15,),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Reveal Answers', style: TextStyle(fontSize: 22.5),),
                onPressed: !answersRevealed ? revealAnswers : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
