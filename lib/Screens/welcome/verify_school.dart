import 'package:flutter/material.dart';
import 'package:moimapp/Screens/welcome/sign_up.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/Widgets/dropdown.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/round_input_forLogin.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';

class VerifySchool extends StatefulWidget {
  String college;
  @override
  _VerifySchoolState createState() => _VerifySchoolState();
}

class _VerifySchoolState extends State<VerifySchool> {
  String schoolEmail;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController passwordTextEditingContoller =
      new TextEditingController();
  TextEditingController confirmPasswordTextEditingContoller =
      new TextEditingController();
  TextEditingController emailTextEditingContoller = new TextEditingController();

  @override
  void initState() {
    // isLoggedIn = false;
    super.initState();
  }

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              emailTextEditingContoller.text, passwordTextEditingContoller.text)
          .then((val) async {
        Map<String, String> userInfoMap = {
          'email': emailTextEditingContoller.text,
          'college': widget.college
        };

        // not sure where we are using these
        // HelperFunctions.saveUserEmailPreference(emailTextEditingContoller.text);
        // HelperFunctions.saveUserCollegePreference(widget.college);
        // HelperFunctions.saveUserNamePreference(
        //     usernameTextEditingContoller.text);
        // Constants.myUsername =await HelperFunctions.getUserNamePreference();
        // Constants.myCollege = await HelperFunctions.getUserCollegePreference();

        Constants.myEmail = emailTextEditingContoller.text;
        Constants.myCollege = widget.college;

        databaseMethods.uploadUser(
            widget.college, userInfoMap, Constants.myEmail);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignUp();
        }));
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
        //   (Route<dynamic> route) => false,
        // );
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
                          Text('Verify your ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          HighlightText(
                              text: 'College .',
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
                                  switch (widget.college) {
                                    case 'Mount Holyoke College':
                                      schoolEmail = '@mtholyoke.edu';
                                      break;
                                    default:
                                      schoolEmail = '';
                                  }
                                }),
                              ),
                            ],
                          )),

                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            // RoundedInputWithController(
                            //   size: size,
                            //   textFormField: TextFormField(
                            //     controller: usernameTextEditingContoller,
                            //     validator: (val) {
                            //       return val.isEmpty || val.length < 3
                            //           ? "Enter Username longer than three characters"
                            //           : null;
                            //     },
                            //     decoration: InputDecoration(
                            //         hintText: "Username",
                            //         icon: Icon(
                            //           Icons.person,
                            //           color: Colors.grey[900],
                            //         ),
                            //         border: InputBorder.none),
                            //   ),
                            // ),
                            SizedBox(height: 10),
                            RoundedInputWithController(
                              size: size,
                              textFormField: TextFormField(
                                controller: emailTextEditingContoller,
                                validator: (val) {
                                  return val.endsWith(schoolEmail)
                                      ? null
                                      : 'You have to use your school email to verify';
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

                      GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: Container(
                          width: size.width * 0.8,
                          child: RoundedButton(
                            text: 'Send Verification Email',
                            fillColor: Colors.grey[350],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.013),
                      // Container(
                      //     width: size.width * 0.8,
                      //     child: Row(
                      //       children: <Widget>[
                      //         BuildDivider(),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 8.0),
                      //           child: Text('or'),
                      //         ),
                      //         BuildDivider()
                      //       ],
                      //     )),
                      // SizedBox(height: size.height * 0.01),
                      // GestureDetector(
                      //   onTap: () {
                      //     _loginWithGoogle();
                      //   },
                      //   child: Container(
                      //     width: size.width * 0.8,
                      //     child: RoundedButton(
                      //       text: 'Sign Up with Google',
                      //       fillColor: Colors.grey[350],
                      //     ),
                      //   ),
                      // ),
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
    );
  }
}

// // from the other tutorial
// FirebaseAuth _auth = FirebaseAuth.instance;
// FirebaseUser _user;
// GoogleSignIn _googleSignIn = new GoogleSignIn();

// bool isSignIn = false;

// Future<void> handleSignIn() async {
//   GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//   GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken);

//   AuthResult result = (await _auth.signInWithCredential(credential));
//   _user = result.user;

//   setState(() {
//     isSignIn = true;
//   });
// }

// Future<void> googleSignOut() async {
//   await _auth.signOut().then((val) {
//     _googleSignIn.signOut();
//     setState(() {
//       isSignIn = false;
//     });
//   });
// }

//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   _loginWithGoogle() async {
//     try {
//       await _googleSignIn.signIn();
//       setState(() {
// isLoggedIn = true;
//       });
//     } catch (err) {
//       print(err.toString());
//     }
//   }
// }

Expanded BuildDivider() {
  return Expanded(
    child: Divider(color: Colors.grey[700], height: 1.5),
  );
}
