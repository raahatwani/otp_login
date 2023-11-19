import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var devW,devH;

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify='';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  var phone='';

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    devH= MediaQuery.of(context).size.height;
    devW=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: devW*0.05, right:devW*0.05),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              CircleAvatar(
                radius: devW*0.25,
              ),
              SizedBox(
                height: devH*0.1,
              ),
              Text(
                'Enter Mobile Number:',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: devW*0.1,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: devW*0.7,
                        child: TextField(
                          onChanged: (value){
                            phone=value;
                            print(phone);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                          maxLength: 10,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: devH*0.05,
                width: devW*0.3,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryController.text+phone}',
                          verificationCompleted: (PhoneAuthCredential credential){},
                          verificationFailed: (FirebaseException e){},
                          codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify=verificationId;
                            Navigator.pushNamed(context, 'verify');
                          },
                          codeAutoRetrievalTimeout: (String verificationId){}
                      );
                    },
                    child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}