import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/widget_tree.dart';
import "globals.dart";
import "package:flutter_application_1/home_page.dart";
import "package:flutter_application_1/auth.dart";


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WidgetTree(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String clean(String word){
    String result = "";
    for(int i = 0; i<word.length; i++){
      if(word[i] != "." && word[i] != "@"){
        result += word[i];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    uid = clean(Auth().currentUser!.email!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My To-Do App"),
      ),
      body: const HomePage(),
      
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon:  Icon(Icons.home), label: "Home"),
          NavigationDestination(icon:  Icon(Icons.accessibility), label: "COMING SOON"),
        ],
        onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}

