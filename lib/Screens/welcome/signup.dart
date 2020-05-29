import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/Widgets/dropdown.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/round_input.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
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
                        DropDown(),
                      ],
                    )),

                // RoundedInput(
                //   size: size,
                //   icon: Icons.school,
                //   hintText: "College",
                // ),
                SizedBox(height: 10),
                RoundedInput(
                  size: size,
                  icon: Icons.email,
                  hintText: "College Email",
                ),
                SizedBox(height: 10),
                RoundedInput(
                  size: size,
                  icon: Icons.person,
                  hintText: "Username",
                ),
                SizedBox(height: 10),
                RoundedInput(
                  size: size,
                  icon: Icons.lock,
                  hintText: "Password",
                ),
                SizedBox(height: 10),
                RoundedInput(
                  size: size,
                  icon: Icons.lock,
                  hintText: "Confirm Password",
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  width: size.width * 0.8,
                  child: RoundedButton(
                    text: 'SIGNUP',
                    fillColor: Colors.grey[350],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
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

final collegeSelected = TextEditingController();
String selectCollege = '';
final List<String> colleges = [
  'Mount Holyoke College',
  'Brandeis University',
  'Umass Amherst',
  'Boston University'
];
