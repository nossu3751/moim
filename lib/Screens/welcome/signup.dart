import 'package:flutter/material.dart';
import 'package:moimapp/Screens/messages/message_home.dart';
import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/Widgets/dropdown.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/round_input_forLogin.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';

class SignUp extends StatefulWidget {
  String college;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingContoller = new TextEditingController();
  TextEditingController usernameTextEditingContoller =
      new TextEditingController();
  TextEditingController passwordTextEditingContoller =
      new TextEditingController();
  TextEditingController confirmPasswordTextEditingContoller =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              emailTextEditingContoller.text, passwordTextEditingContoller.text)
          .then((val) {
        Map<String, String> userInfoMap = {
          'name': usernameTextEditingContoller.text,
          'email': emailTextEditingContoller.text,
          'college': widget.college,
        };
        databaseMethods.uploadUserInfo(widget.college, userInfoMap);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MessageHome()),
          (Route<dynamic> route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(child: Container(child: CircularProgressIndicator()))
          : Center(
              child: Container(
                width: size.width * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/Moim_logo.png',
                        height: size.height * 0.1,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        children: <Widget>[
                          Text('Create your ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          HighlightText(
                              text: 'Account .',
                              fontStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),

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
                              DropDown(
                                college: widget.college,
                                selected: (String val) => setState(() {
                                  widget.college = val;
                                }),
                              ),
                              // DropDown(college: widget.college),
                            ],
                          )),

                      SizedBox(height: 10),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
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
                            RoundedInputWithController(
                              size: size,
                              textFormField: TextFormField(
                                controller: emailTextEditingContoller,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Enter correct Email";
                                },
                                decoration: InputDecoration(
                                    hintText: "College Email",
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.grey[900],
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(height: 10),
                            RoundedInputWithController(
                              size: size,
                              textFormField: TextFormField(
                                obscureText: true,
                                controller: passwordTextEditingContoller,
                                validator: (val) {
                                  return val.length < 6
                                      ? "Enter Password longer than 6 characters"
                                      : null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.grey[900],
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(height: 10),
                            RoundedInputWithController(
                              size: size,
                              textFormField: TextFormField(
                                obscureText: true,
                                controller: confirmPasswordTextEditingContoller,
                                validator: (val) {
                                  return (val !=
                                          passwordTextEditingContoller.text)
                                      ? "Password doesn't match"
                                      : null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Confirm Password",
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

                      SizedBox(height: 10),
                      // RoundedInput(
                      //   size: size,
                      //   icon: Icons.lock,
                      //   hintText: "Confirm Password",
                      // ),
                      // SizedBox(height: size.height * 0.04),
                      GestureDetector(
                        onTap: () => signMeUp(),
                        child: Container(
                          width: size.width * 0.8,
                          child: RoundedButton(
                            text: 'Sign Up',
                            fillColor: Colors.grey[350],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.013),
                      Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: <Widget>[
                              BuildDivider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('or'),
                              ),
                              BuildDivider()
                            ],
                          )),
                      SizedBox(height: size.height * 0.01),
                      GestureDetector(
                        onTap: () => signMeUp(),
                        child: Container(
                          width: size.width * 0.8,
                          child: RoundedButton(
                            text: 'Sign Up with Google',
                            fillColor: Colors.grey[350],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an Account? "),
                          GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return WelcomeScreen();
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
    );
  }
}

Expanded BuildDivider() {
  return Expanded(
    child: Divider(color: Colors.grey[700], height: 1.5),
  );
}
