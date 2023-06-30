import "package:flutter_application_1/globals.dart";
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_application_1/auth.dart";
import "package:flutter_application_1/main.dart";

class LoggedIn extends StatefulWidget {
  LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userId() {
    return Text("Welcome:)${user?.email}");
  }

  Widget buttons() {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              setState((){loggedin = true;});
            },
            child: const Text("Continue")),
        ElevatedButton(onPressed: signOut, child: const Text("Sign Out"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return !loggedin ? Scaffold(
        appBar: AppBar(title: _userId()),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [buttons()],
            ))) : const RootPage();
  }
}
