import 'package:flutter/material.dart';
import 'component/color_component.dart';
import 'pages/first_page/first_page_main.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tracking price of baby product',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color1),
        useMaterial3: true,
      ),
      home: const FirstPageMain(),
    );
  }
}
