import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';

class isEmptyList extends StatefulWidget {
  const isEmptyList({Key? key}) : super(key: key);

  @override
  State<isEmptyList> createState() => _isEmptyListState();
}

class _isEmptyListState extends State<isEmptyList> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 0,
      position: 0,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 1500),
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RefreshIndicator(
              onRefresh: () async {
                // await s2.getNotes();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/addNote.svg',
                      height: MediaQuery.of(context).size.height / (5.2),
                      width: MediaQuery.of(context).size.width / (5.2),
                      color: Colors.cyan[700],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width / (1.4),
                      child: Text(
                        '27'.tr,
                        style: Themes().headLine3.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width / (22.6),
                              color:
                                  ThemeController().themeApp == ThemeMode.light
                                      ? Colors.black.withOpacity(.6)
                                      : Colors.white.withOpacity(.6),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
