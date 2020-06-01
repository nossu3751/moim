import 'package:flutter/material.dart';
import 'package:moimapp/Screens/welcome/signup.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/round_input.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            SizedBox(height: size.height * 0.05),
            RoundedInput(
              size: size,
              icon: Icons.email,
              hintText: "College Email",
            ),

            SizedBox(height: size.height * 0.01),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  // border: new Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[50]),
              width: size.width * 0.8,
              child: TextField(
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
            Container(
              width: size.width * 0.8,
              alignment: Alignment.bottomRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ),

            SizedBox(height: size.height * 0.02),
            // Button with outline
            // Container(
            //   width: size.width * 0.8,
            //   child: RaisedButton(
            //     padding: EdgeInsets.symmetric(vertical: 15),
            //     onPressed: () {},
            //     color: Colors.grey[100],
            //     child: Text('LOGIN', style: TextStyle(color: Colors.grey[700])),
            //     shape: RoundedRectangleBorder(
            //         side: BorderSide(
            //             color: Colors.grey[600],
            //             width: 1,
            //             style: BorderStyle.solid),
            //         borderRadius: BorderRadius.circular(50)),
            //   ),
            // ),
            Container(
              width: size.width * 0.8,
              child: RoundedButton(
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
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return SignUp();
                  })),
                  child: Text(
                    "Sign in",
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

  Expanded BuildDivider() {
    return Expanded(
      child: Divider(color: Colors.black, height: 1.5),
    );
  }
}
