import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/launch/launch_screen.dart';
import '../../args_class.dart';
import 'loginform.dart';
import '../../constants.dart';
import '../components/loginsignupfooter.dart';
import '../components/customsigninappbar.dart';
import 'loginbody.dart';
import '../signup/user_signup.dart';

class StudentLoginScreen extends StatelessWidget {
  static String routeName = '/student_login';
  const StudentLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    final arguments =
        ModalRoute.of(context)?.settings.arguments as LoginSignUpArguments;
    Size size = MediaQuery.of(context).size; // Available screen size
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushReplacementNamed(context, LaunchScreen.routeName);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDark ? kGrey30 : kLGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: kHeaderHeight.h,
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            herotag: arguments.herotag,
            size: size,
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            press: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LaunchScreen.routeName, (Route<dynamic> route) => false);
            },
          ),
        ),
        body: LoginBody(
          formwidget: LoginForm(
            userIndex: 0,
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            homeroute: StudentLoginScreen.routeName,
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDark ? kBackgroundColor : kLBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0.w, -2.h),
                color: isDark ? kBlack15 : kLGrey50,
              ),
            ],
          ),
          height: 70.h,
          child: Center(
            child: LoginSignUpFooter(
              size: size,
              msg: "Don't have an account ?",
              btntext: "Sign Up",
              fsize: 16,
              press: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                LoginSignUpArguments args = LoginSignUpArguments(
                  "",
                  arguments.fgcolor,
                  arguments.title,
                  arguments.icon,
                );

                Navigator.pushNamed(
                  context,
                  UserSignUpScreen.routeName,
                  arguments: args,
                );
              }, //Todo_Navigation
            ),
          ),
        ),
      ),
    );
  }
}
