import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Auth/AuthMiddleware.dart';
import 'package:sampleproject/Auth/startScreen.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/Locale/localeController.dart';
import 'package:sampleproject/Locale/myLocale.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/screen/homePageScreen.dart';
import 'package:sampleproject/screen/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pref = await SharedPreferences.getInstance();

  runApp(todo());
}

class todo extends StatefulWidget {
  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  ThemeController s1 = Get.put(ThemeController());
  LocaleControllar s3 = Get.put(LocaleControllar());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
      ],
      child: GetMaterialApp(
        locale: s3.getLoclae,
        translations: myLocale(),
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        themeMode: s1.themeApp,
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => startPageScreen(), middlewares: [
            AuthMiddleware(),
          ]),
          GetPage(name: '/welcomeScreen', page: () => welcomeScreen()),
          GetPage(name: '/welcomeScreen', page: () => homePageScreen()),
        ],
      ),
    );
  }
}
