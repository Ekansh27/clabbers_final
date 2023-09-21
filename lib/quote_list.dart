import 'package:clabbers/my_drawer_header.dart';
import 'package:clabbers/searchbar.dart';
import 'package:clabbers/judgebar.dart';
import 'package:clabbers/feedbackform.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:clabbers/quote.dart';
import 'package:flutter/services.dart';
import 'quote_card.dart';
// import 'package:clabbers/main.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuoteList(),
    ));

class QuoteList extends StatefulWidget {
  const QuoteList({Key? key}) : super(key: key);

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  // var currentPage = DrawerSections.quiz;
  List<List<dynamic>> _data2 = [];

  List<Quote> quotes = [
    Quote(author: 'letters', text: '2'),
    Quote(author: 'letters', text: '4'),
    Quote(author: 'letters', text: '6'),
    Quote(author: 'letters', text: '8'),
  ];
  List<Quote> quotes1 = [
    Quote(author: 'letters', text: '3'),
    Quote(author: 'letters', text: '5'),
    Quote(author: 'letters', text: '7'),
    Quote(author: 'letters', text: '9'),
  ];

  Widget quoteTemplate(quote) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              quote.text,
              style: const TextStyle(fontSize: 18.0, color: Color(0xff603dc3)),
            ),
            const SizedBox(height: 6.0),
            Text(
              quote.author,
              style: const TextStyle(fontSize: 14.0, color: Color(0xff603dc3)),
            )
          ],
        ),
      ),
    );
  }

  // List<Quote> quotes2 = [
  //   Quote(author: 'letters', text: '4'),
  //   Quote(author: 'letters', text: '7'),
  //   Quote(author: 'letters', text: '10'),
  // ];

  List<bool> isHighlighted = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    // var container;
    // if (currentPage == DrawerSections.quiz) {
    //   container = QuoteList();
    // } else if (currentPage == DrawerSections.judge) {
    //   container = TextEditingControllerExampleApp();
    // } else if (currentPage == DrawerSections.feedback) {
    //   container = FeedbackForm();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Quiz',
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

      body: Center(
        child: Container(
          width: 315,
          height: 550,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: quotes
                      .map((quote) => QuoteCard(
                            quote: quote,
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: quotes1
                      .map((quote) => QuoteCard(
                            quote: quote,
                          ))
                      .toList(),
                ),
              ),
              // Column(
              //   children: quotes2.map((quote) => QuoteCard(
              //             quote: quote,
              //           ))
              //       .toList(),
              // ),
            ],
          ),
        ),
      ),
//   );
    );
  }
}
