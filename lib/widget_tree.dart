import "package:flutter_application_1/auth.dart";
import "package:flutter_application_1/pages/logged_in.dart";
import "pages/login_register.dart";
import "package:flutter/material.dart";

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return LoggedIn();
        }else{
          return const LoginPage();
        }
      },
    );
  }
}