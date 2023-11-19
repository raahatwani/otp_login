// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'NextPage.dart';
import 'phone.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage({super.key});
  TextEditingController otpController = TextEditingController();

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code='';
  bool showResend=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: devH * 0.2, bottom: devH * 0.05, left: devW * 0.2),
                child: CircleAvatar(
                  radius: devW * 0.25,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: devW * 0.05),
                child: Text(
                  'Enter OTP:',
                  style: TextStyle(fontSize: devH * 0.02),
                ),
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin) => print(pin),
                onChanged: (value){
                  code=value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: devW * 0.4),
                child: ElevatedButton(
                    onPressed: () async{
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider
                            .credential(
                            verificationId: MyPhone.verify, smsCode: code);
                        await auth.signInWithCredential(credential);
                        Navigator.push( context,
                            MaterialPageRoute(builder: (_) => NextPage()));
                      }
                      catch(e){
                        showResend=true;
                      }
                    },
                    child: Text('Get Started')),
              ),
              showResend?ElevatedButton(onPressed: (){}, child: Text('Resend Code')): SizedBox(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MyPhone()));
        }, child: Text('Back'),),
      )
    );
  }
}