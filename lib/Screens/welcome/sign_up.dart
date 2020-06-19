import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Screens/homepage.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/Widgets/dropdown_general.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/round_input_forLogin.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';
import 'package:moimapp/helper/constants.dart';

class SignUp extends StatefulWidget {
  String schoolYear;
  String college;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController passwordTextEditingContoller =
      new TextEditingController();
  TextEditingController confirmPasswordTextEditingContoller =
      new TextEditingController();
  TextEditingController firstNameTextEditingContoller =
      new TextEditingController();
  TextEditingController lastNameTextEditingContoller =
      new TextEditingController();
  TextEditingController usernameTextEditingContoller =
      new TextEditingController();

  TextEditingController majorTextEditingContoller = new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> userInfoMap = {
        'first_name': firstNameTextEditingContoller.text,
        'last_name': lastNameTextEditingContoller.text,
        'username': usernameTextEditingContoller.text,
        'school_year': widget.schoolYear,
      };

      HelperFunctions.saveUserFirstNamePreference(
          firstNameTextEditingContoller.text);
      HelperFunctions.saveUserNamePreference(usernameTextEditingContoller.text);
      HelperFunctions.saveUserLogInPreference(true);
      databaseMethods.uploadUserAccountInfo(
          Constants.myCollege, userInfoMap, Constants.myEmail);
    }
  }

  bool _isUserEmailVerified = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    // got this from stackoverflow
    // https://stackoverflow.com/questions/57192651/flutter-how-to-listen-to-the-firebaseuser-is-email-verified-boolean
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        await FirebaseAuth.instance.currentUser()
          ..reload();
        var user = await FirebaseAuth.instance.currentUser();
        if (user.isEmailVerified) {
          setState(() {
            _isUserEmailVerified = user.isEmailVerified;
          });
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isUserEmailVerified
        ? Scaffold(
            body: Center(
              child: Container(
                width: size.width * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text('Create your ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      HighlightText(
                          text:
                              '${Constants.myCollege.replaceAll('College', '').replaceAll('University', '')}Moim Account .',
                          fontStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: size.height * 0.03),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RoundInputWithController(
                                  size: size,
                                  textFormField: TextFormField(
                                    controller: firstNameTextEditingContoller,
                                    validator: (val) {},
                                    decoration: InputDecoration(
                                        hintText: "First Name",
                                        border: InputBorder.none),
                                  ),
                                ),
                                RoundInputWithController(
                                  size: size,
                                  textFormField: TextFormField(
                                    controller: lastNameTextEditingContoller,
                                    validator: (val) {},
                                    decoration: InputDecoration(
                                        hintText: "Last Name",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),
                            // TODO: username has to be unique
                            RoundedInputWithController(
                              size: size,
                              textFormField: TextFormField(
                                controller: usernameTextEditingContoller,
                                validator: (val) {
                                  return val.isEmpty || val.length < 3
                                      ? "Enter Username longer than three characters"
                                      : null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Username",
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.grey[900],
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),

                            SizedBox(height: 10),

                            Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[100]),
                                width: size.width * 0.8,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.school),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    DropDownGeneral(
                                      items: <String>[
                                        'Freshman                   ',
                                        'Sophomore',
                                        'Junior',
                                        'Senior'
                                      ],
                                      selected: widget.schoolYear,
                                      select: (String val) => setState(
                                        () {
                                          widget.schoolYear = val;
                                        },
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            // TODO: Implement major? should be drop down
                            // RoundedInputWithController(
                            //   size: size,
                            //   textFormField: TextFormField(
                            //     controller: majorTextEditingContoller,
                            //     validator: (val) {},
                            //     decoration: InputDecoration(
                            //         hintText: "Major",
                            //         icon: Icon(
                            //           Icons.import_contacts,
                            //           color: Colors.grey[900],
                            //         ),
                            //         border: InputBorder.none),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          signMeUp();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          child: RoundedButton(
                            text: 'Sign Up',
                            fillColor: Colors.grey[350],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.013),
                      SizedBox(height: size.height * 0.013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an Account? "),
                          GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignIn();
                            })),
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  size: size.height * 0.1,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HighlightText(
                        text: 'Verification Email ',
                        fontStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text('has been sent',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text('Please check your inbox',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ),
          );
  }
}

class RoundInputWithController extends StatelessWidget {
  final TextFormField textFormField;

  const RoundInputWithController(
      {Key key, @required this.size, this.textFormField})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.grey[100]),
        width: size.width * 0.39,
        child: textFormField);
  }
}
