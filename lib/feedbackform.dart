import 'package:clabbers/quote_list.dart';
import 'package:clabbers/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'judgebar.dart';
import 'my_drawer_header.dart';


void main() => runApp(FeedbackForm());

class FeedbackForm extends StatelessWidget {
  FeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Timber(),
    );
  }
}

class Timber extends StatefulWidget {
  Timber({super.key});
  @override
  State<Timber> createState() =>
      _TimberState();
}

class _TimberState extends State<Timber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Feedback Form',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
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

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () => _launchURL(),
                child: const Text(
                  'Google Form',
                  style: TextStyle(
                    fontSize: 24,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0,),
            const Text('Or mail to: aroraekansh2706@gmail.com', style: TextStyle(fontSize: 16.0),)
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  final Uri url = Uri.parse('https://forms.gle/NncTnuDA1cdEwESA6');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}


      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //           padding: EdgeInsets.all(16),
      //           decoration: BoxDecoration(
      //             color: Colors.lightGreen,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: const Text(
      //             'https://forms.gle/NncTnuDA1cdEwESA6!',
      //             style: TextStyle(
      //               fontSize: 24,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       // SizedBox(height: 16),
      //
      //     ],
      //   ),
      // ),


