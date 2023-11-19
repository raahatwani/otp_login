// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Text('OTP VERIFIED'),
      ),
    ));
  }
}