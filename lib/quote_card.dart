import 'package:clabbers/sevenletterquiz.dart';
import 'package:clabbers/sixletterquiz.dart';
import 'package:clabbers/threeletterquiz.dart';
import 'package:clabbers/twoletterquiz.dart';
import 'package:flutter/material.dart';
import 'package:clabbers/quote.dart';
import 'package:scrabble/scrabble.dart';
import 'dart:core';

import 'eightletterquiz.dart';
import 'fiveletterquiz.dart';
import 'fourletterquiz.dart';
import 'nineletterquiz.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  QuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              if (quote.text == '2') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TwoLetterQuiz()));
              }
              else if (quote.text == '3') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ThreeLetterQuiz()));
              }
              else if (quote.text == '4') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FourLetterQuiz()));
              }
              else if (quote.text == '5') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FiveLetterQuiz()));
              }
              else if (quote.text == '6') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SixLetterQuiz()));
              }
              else if (quote.text == '7') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SevenLetterQuiz()));
              }
              else if (quote.text == '8') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => EightLetterQuiz()));
              }
              else if (quote.text == '9') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NineLetterQuiz()));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quote.text,
                    style: const TextStyle(
                      fontSize: 35.0,
                        color: Color(0xff6d3fa4)
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(quote.author,
                      style: const TextStyle(
                        fontSize: 16.0,
                          color: Color(0xff6d3fa4)
                      )),
                  // const SizedBox(height: 8.0),
                ],
              ),
            )
        ),
      ),
    );
  }
}
