// ignore_for_file: prefer_typing_uninitialized_variables, avoid_unnecessary_containers, unused_import, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otp_login/otp.dart';

import 'constants.dart';
import 'phone.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => VerifyPage()
    },
  ));
}