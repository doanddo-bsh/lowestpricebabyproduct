import 'package:flutter/material.dart';
import 'component/color_component.dart';
import 'pages/first_page/first_page_main.dart';
// import 'package:flutter_provider/flutter_provider.dart';
import 'package:provider/provider.dart';
import 'component/provider_selected_list.dart';
// void main() => runApp(const MyApp());
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // <- 이거
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Selected()),
          ],
          child: MyApp(),
        ),
  );
}

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
