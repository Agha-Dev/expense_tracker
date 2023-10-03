import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/helpers/helper_ui.dart';
import 'package:expense_tracker/screens/bottom_nav_bar/nav_bar.dart';
import 'package:expense_tracker/screens/signin/sign_in.dart';
import 'package:expense_tracker/screens/signup/widgets/signup_widgets.dart';
import 'package:expense_tracker/services/auth_services.dart';
import 'package:expense_tracker/services/navigation_services.dart';
import 'package:flutter/material.dart';

import '../../helpers/helper_buttons.dart';
import '../../helpers/helper_fields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController username = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  String emailCheck = "";
  bool showPass=false;
  bool obsText=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                  strokeWidth: 2,
                ),
              )
            :  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              verticalSpaceresponsive(0.1, context),
              Image.asset(
                "assets/icons/logo.png",
                height: 140,
                width: 118,
              ),
              verticalSpaceresponsive(0.04, context),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      customtextfields(
                          false,
                          "Email",
                          "Email",
                          email,
                          false,
                          TextInputType.emailAddress,showPass,(){}),
                      verticalSpaceresponsive(0.01, context),
                      customtextfields(
                          false,
                          "Username",
                          "Username",
                          username,
                          false,
                          TextInputType.emailAddress,showPass,(){
                           
                          }),
                      verticalSpaceresponsive(0.01, context),
                      customtextfields(obsText, "Password", "Password", pass, true,
                          TextInputType.text,showPass,(){
                             setState(() {
                            showPass = !showPass;
                             obsText=!obsText;
                            print(showPass);
});
                          }),
                      verticalSpaceresponsive(0.05, context),
                      mainButton(context,"Sign up",()async{
                        if(formKey.currentState!.validate()){
                           setState(() {
                                                        loading = true;
                                                      });
                                                      final res = Auth()
                                                        ..signup(
                                                            email.text.trim(),
                                                            pass.text
                                                                .trim(),
                                                            username.text
                                                                .trim(),);
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      if (res == 300) {
                                                        showSnackbarText(
                                                            "Not Registered",
                                                            context);
                                                      } else {
                                                        Nav.pushNav(context,
                                                             CustomBottomBar());
                                                      }
                        }
                      }),
                      verticalSpaceresponsive(0.08, context),
                      titleNavigation( "Don’t have an account?","Sign in",(){Nav.pushNav(context,const LoginScreen());}),
                      verticalSpaceresponsive(0.01, context),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}