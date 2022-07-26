import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Auth/authScreen.dart';
import 'package:sampleproject/Locale/localeController.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/controller/showStyle.dart';
import 'package:sampleproject/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  ThemeController s1 = Get.find();

  LocaleControllar s3 = Get.find();
  bool isLoading = false;
  String? idKey = pref.getString('key');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('/newAccount/$idKey/user')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DocumentSnapshot> s1 = snapshot.data!.docs;

              return !s1.isEmpty
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: (() {
                              /*  Navigator.push(
                                context,
                                PageTransition(
                                  child: myAccountScreen(idKey: widget.idKey),
                                  type: PageTransitionType.leftToRight,
                                  duration: Duration(milliseconds: 300),
                                ),
                              ); */
                            }),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isLoading == false
                                    ? Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.cyan[700],
                                            child: (s1[0] as dynamic)[
                                                        'image_url'] !=
                                                    ''
                                                ? ClipOval(
                                                    child: CachedNetworkImage(
                                                      height: 110,
                                                      width: 110,
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          (s1[0] as dynamic)[
                                                              'image_url'],
                                                      placeholder:
                                                          (context, url) =>
                                                              Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          AnimatedOpacity(
                                                            duration:
                                                                Duration.zero,
                                                            opacity: .5,
                                                            child: SvgPicture
                                                                .asset(
                                                              'images/task-6.svg',
                                                              width: 60,
                                                              height: 60,
                                                            ),
                                                          ),
                                                          CircularProgressIndicator(
                                                            color: Colors
                                                                .cyan[700],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Stack(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 55,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: AnimatedOpacity(
                                                          duration:
                                                              Duration.zero,
                                                          opacity: .5,
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .user,
                                                            size: 60,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Transform.translate(
                                            offset: Offset(-10, 0),
                                            child: SizedBox(
                                              width: 50,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  alignment: Alignment.center,
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white10),
                                                ),
                                                onPressed: () {
                                                  changeImage();
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: ThemeController()
                                                              .themeApp ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 55,
                                            backgroundColor: Colors.white,
                                            child: AnimatedOpacity(
                                              duration: Duration.zero,
                                              opacity: .5,
                                              child: Icon(
                                                FontAwesomeIcons.user,
                                                size: 60,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          CircularProgressIndicator(
                                            color: Colors.cyan[700],
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${(s1[0] as dynamic)['userName']}',
                                  style: Themes().headLine3,
                                ),
                                Text(
                                  '${(s1[0] as dynamic)['email']}',
                                  style: Themes().headLine3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text('');
            },
          ),
          SizedBox(
            width: 250,
            child: Divider(
              color: Colors.black,
              thickness: 1.2,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          getCardInf(context, '29'.tr, Icons.home, () {}),
          SizedBox(
            height: 5,
          ),
          getCardInf(context, '30'.tr, Icons.language, () {
            s3.getLoclae == Locale('en')
                ? s3.ChamgeLocale('ar')
                : s3.ChamgeLocale('en');
            Get.back();
          }),
          SizedBox(
            height: 5,
          ),
          getCardInf(context, '31'.tr, Icons.logout, () async {
            await pref.clear();
            Get.off(() => authScreen(pageIndex: 0));
          }),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  changeImage() async {
    final ImagePicker _picker = ImagePicker();
    File? pickedImage;

    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image == null) {
      return;
    }

    setState(() {
      isLoading = true;

      pickedImage = File(image.path);
    });
    Random x = Random();

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('81Zhw25MnocXb5Q5uHHNTCyoxx12${x.nextInt(100)}.jpg');

    ///
    ////
    var urlImage;
    if (pickedImage != null) {
      await ref.putFile(pickedImage!);
      urlImage = await ref.getDownloadURL();
      await ref.putFile(pickedImage!);
    } else {
      urlImage =
          'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
    }
    await FirebaseFirestore.instance
        .collection('newAccount')
        .doc('$idKey')
        .collection('user')
        .doc('personalInf')
        .update({
      'image_url': urlImage,
    });
    setState(() {
      isLoading = false;
    });
  }
}

Widget getCardInf(
    BuildContext context, String label, IconData icon, void addFunc()) {
  return InkWell(
    onTap: (() {
      addFunc();
    }),
    child: Card(
      color: Colors.cyan[800],
      child: ListTile(
        leading: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    ),
  );
}
