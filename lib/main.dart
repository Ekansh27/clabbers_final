import 'package:clabbers/searchbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clabbers/quote_list.dart';

void main() {
  runApp(const SplashPage());
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrabble App',
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => QuoteList())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment(0, 1),
            //       colors: <Color>[
            //         Color(0xffb2d3f4),
            //         Color(0xffb2d3f4),
            //         Color(0xffb2d3f4),
            //         Color(0xffb2d3f4),
            //         Color(0xffb2d3f4),
            //         Color(0xffecf2f8),
            //       ],
            //   ),
            // ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(
              'assets/images/ClabbersLogo.png',
              fit: BoxFit.cover,
              ),
                   const DefaultTextStyle(
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 36,
                      // color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Text('CLABBERS', style: TextStyle(fontFamily: 'JuliusSansOne', fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 15.0,
                        ),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ],
                    ),
                   ),
              ],
            ),
          ),
          ),
      );
  }
}