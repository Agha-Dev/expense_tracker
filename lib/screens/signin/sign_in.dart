import 'package:expense_tracker/screens/bottom_nav_bar/nav_bar.dart';
import 'package:expense_tracker/screens/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/screens/expenses/expenses_main.dart';
import 'package:expense_tracker/screens/signup/sign_up.dart';
import 'package:expense_tracker/services/auth_services.dart';
import 'package:flutter/material.dart';
import '../../constants/constant_colors.dart';
import '../../helpers/helper_buttons.dart';
import '../../helpers/helper_fields.dart';
import '../../helpers/helper_ui.dart';
import '../../services/navigation_services.dart';
import '../../services/size_config_services.dart';
import 'widgets/signin_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
   bool showPass=false;
   bool obsText=true;
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  String emailCheck = "";
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
              verticalSpaceresponsive(0.05, context),
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
                      verticalSpaceresponsive(0.005, context),
                      // rightText("Forgot Password",(){}),
                      verticalSpaceresponsive(0.04, context),
                      mainButton(context,"Sign in",() async{
                             setState(() {
                                  loading = true;
                                  
                                });
                              
                               
                                  final res = await Auth().signin(
                                      email.text.trim(), pass.text.trim());
                                  setState(() {
                                    loading = false;
                                  });
                                  if (res == 200) {
                                    Nav.pushNav(
                                        context,  CustomBottomBar());
                                  } else {
                                    showSnackbarText(
                                        "Invalid Credentials", context);
                                  }
                                
                            },),
                      verticalSpaceresponsive(0.08, context),
                      titleNavigation( "Don’t have an account?","Sign up",(){ Nav.pushNav(context, const SignupScreen());}),
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