import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'Frontend/BottomNavBar/bottomNavBar_screen.dart';
import 'Frontend/Splash/splash_screen.dart';
import 'directionWidget.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.cubeGrid;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mowing Plowing Customer App',
      theme: ThemeData(
        scaffoldBackgroundColor: HexColor("#F1F1F1"),
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(
              primary: HexColor("#0275D8"),
            )
            .copyWith(error: Colors.red),
        // primarySwatch: HexColor("#0275D8"),
      ),
      home: UpgradeAlert(
        upgrader: Upgrader(
          showReleaseNotes: false,
          dialogStyle: UpgradeDialogStyle.cupertino,
          shouldPopScope: () => true,
        ),
        // child: Maps(),
        child: CheckAuth(),
      ),
      builder: EasyLoading.init(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      isAuth = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = BottomNavBar(
        index: null,
      );
    } else {
      child = const Splash();
    }
    return child;
  }
}
