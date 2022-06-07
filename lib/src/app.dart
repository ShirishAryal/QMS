import 'package:flutter/material.dart';
import 'package:qms/src/screens/bottom_nav_screens/bottom_nav.dart';
import './router/route.dart';
import './utils/theme_color.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QMS',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      onGenerateRoute: QMSRouter.generateRoute,
      initialRoute: "/login",
      // "/bottomnav",
      home: const MainScreen(),
    );
  }
}
