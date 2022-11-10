// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../components/loginsignupfooter.dart';
import '../../components/userloginheader.dart';

class StudentLoginBody extends StatelessWidget {
  const StudentLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.only(
              top: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(30, 30, 30, 1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -5),
                  color: kStudentColor.withOpacity(0.9),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: UserLoginHeader(
                    size: size,
                    bradius: 30.0,
                    bgcolor: kBackgroundColor,
                    shcolor: Color.fromRGBO(10, 10, 10, 1),
                    fgcolor: kStudentColor,
                    icon: Icons.school,
                    title: "Student Login",
                    fsize: 16,
                    press: () {
                      Navigator.pop(context);
                    },
                    iconbg: kPrimaryColor,
                  ),
                ),
                Expanded(flex: 14, child: Container() //StudentLoginForm(),
                    ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.1,
          child: LoginSignUpFooter(
            size: size,
            msg: "Don't have an account ?",
            btntext: "Sign Up",
            fsize: 16,
            press: () {}, //Todo
          ),
        )
      ],
    );
  }
}
