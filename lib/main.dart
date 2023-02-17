import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/matchProvider.dart';
import 'providers/pageProvider.dart';
import 'providers/showUnitProvider.dart';
import 'components/topBar.dart';
import 'components/bottomBar.dart';
import 'pages/app.dart';
import 'pages/records.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Matches()),
      ChangeNotifierProvider(create: (context) => Pages()),
      ChangeNotifierProvider(create: (context) => ShowUnit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pages = const [MainApp(), RecordPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: TopBar()),
        body: pages[context.watch<Pages>().pageIndex],
        bottomNavigationBar: BottomBar());
  }
}
