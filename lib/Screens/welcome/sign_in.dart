import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Screens/homepage.dart';
import 'package:moimapp/Screens/welcome/verify_school.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/round_input_forLogin.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';
import 'dart:developer' as developer;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String text = '';
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingContoller = new TextEditingController();
  TextEditingController passwordTextEditingContoller = new TextEditingController();

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailPreference(emailTextEditingContoller.text);

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(
              emailTextEditingContoller.text, passwordTextEditingContoller.text)
          .then((val) {
        if (val == null) {
          setState(() {
            text = "User doesn't exist";
          });
        } else if (val == 'email not verified') {
          setState(() {
            text = "Validate your email address";
          });
        } else {
          uploadUserInfo();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (Route<dynamic> route) => false,
          );
        }
      });
    }
  }

  uploadUserInfo() async {
//    String debugUserName;
//    String debugCollege;
//    String debugFirstName;
//    String debugEmail;
    var college = await DatabaseMethods.getCollegeByEmail(emailTextEditingContoller.text);

    developer.log(college);

    await databaseMethods
        .getUserByEmail(college, emailTextEditingContoller.text)
        .then((val) async {
      snapshotUserInfo = val;
      await HelperFunctions.saveUserLogInPreference(true);
      await HelperFunctions.saveUserNamePreference(
          snapshotUserInfo.documents[0].data['username']);
      await HelperFunctions.saveUserCollegePreference(college);
      await HelperFunctions.saveUserFirstNamePreference(
          snapshotUserInfo.documents[0].data['first_name']);
      await HelperFunctions.saveUserEmailPreference(
          snapshotUserInfo.documents[0].data['email']);
    });

//    debugUserName = await HelperFunctions.getUserNamePreference();
//    debugUserName = await HelperFunctions.getUserCollegePreference();
//    debugUserName = await HelperFunctions.getUserFirstNamePreference();
//    debugUserName = await HelperFunctions.getUserEmailPreference();
//
//    developer.log(debugUserName);
//    developer.log(debugCollege);
//    developer.log(debugFirstName);
//    developer.log(debugEmail);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/Moim_logo.png',
              height: size.height / 7.5,
            ),
            SizedBox(height: size.height * 0.03),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * 0.01),
                  Text(
                    text,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                  RoundedInputWithController(
                    size: size,
                    textFormField: TextFormField(
                      controller: emailTextEditingContoller,
                      validator: (val) {},
                      decoration: InputDecoration(
                          hintText: "College Email",
                          icon: Icon(
                            Icons.email,
                            color: Colors.grey[900],
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        // border: new Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100]),
                    width: size.width * 0.8,
                    child: TextFormField(
                      controller: passwordTextEditingContoller,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey[900],
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.8,
              alignment: Alignment.bottomRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            Container(
              width: size.width * 0.8,
              child: RoundedButton(
                press: () => signIn(),
                text: 'Sign In',
                fillColor: Colors.grey[350],
              ),
            ),
            SizedBox(height: size.height * 0.01),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an Account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => VerifySchool()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
