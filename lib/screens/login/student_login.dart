import 'package:flutter/material.dart';
import 'loginform.dart';
import '../../constants.dart';
import '../components/loginsignupfooter.dart';
import 'customsigninappbar.dart';
import 'loginbody.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({
    super.key,
    required this.herotag,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Object herotag;
  final Color fgcolor;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.18,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        flexibleSpace: CustomSignInAppBar(
          herotag: herotag,
          size: size,
          fgcolor: fgcolor,
          title: title,
          icon: icon,
        ),
      ),
      body: SingleChildScrollView(
          child: LoginBody(
        title: title,
        fgcolor: fgcolor,
        formwidget: LoginForm(
          fgcolor: fgcolor,
        ),
        footerwidget: LoginSignUpFooter(
          size: size,
          msg: "Don't have an account ?",
          btntext: "Sign Up",
          fsize: 16,
          press: () {}, //Todo
        ),
      )),
    );
  }
}