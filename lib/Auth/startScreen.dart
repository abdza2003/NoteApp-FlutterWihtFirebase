import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Auth/authScreen.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';

class startPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController().themeApp == ThemeMode.light
          ? Color.fromARGB(255, 223, 226, 228)
          : Color.fromARGB(255, 53, 52, 52),
      body: Center(
        child: SafeArea(
          child: Card(
            color: Color.fromARGB(255, 223, 226, 228),
            elevation: 10,
            margin: EdgeInsets.all(25),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/task-6.svg',
                    color: Colors.cyan[800],
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to ',
                          style: Themes()
                              .headLine1
                              .copyWith(fontSize: 25, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'NoteBad',
                          style: Themes()
                              .headLine1
                              .copyWith(fontSize: 25, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Start writing your note now',
                          style: Themes()
                              .headLine1
                              .copyWith(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ?!',
                        style: Themes()
                            .headLine1
                            .copyWith(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: authScreen(
                                pageIndex: 0,
                              ),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 300),
                            ),
                          );
                        }),
                        child: Text(
                          'Log in',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan[800],
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: authScreen(
                              pageIndex: 1,
                            ),
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 15,
                        // padding: EdgeInsets.all(20),
                        child: Text(
                          'Create account now',
                          style: Themes().headLine1.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
