import 'package:flutter/material.dart';
import 'package:flutter_email_pgp/global.dart';
import 'package:flutter_email_pgp/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: MyColors.white),
          fillColor: MyColors.darkWhite,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.blue),
          ),
        ),
      ),
      routes: {
        "/": (context) => const LoginScreen(),
      },
    );
  }
}
