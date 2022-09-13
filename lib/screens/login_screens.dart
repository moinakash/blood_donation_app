import 'package:blood_donation/Utils/widget_view.dart';
import 'package:blood_donation/main.dart';
import 'package:blood_donation/screens/register_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/utils.dart';
import '../models/users.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  bool isStartScreen;
  LoginScreen({Key? key, required this.isStartScreen}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  String fullName = '';

  //isStartScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Constant.baseColorRed,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                hasScrollBody: false,
                    child:Column(
                      children: [
                        Transform.translate(
                            offset: Offset(-20,0),
                            child: WidgetView().lightRedShape()),
                        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
                        WidgetView().logoView(context),
                        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
                        SignInTopbar(),
                        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
                        SignInBottomBar(),
                      ],
                    ),
                )
              ]



            )));
  }


  Widget SignInTopbar(){

    return Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppText.signIn,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Constant.whiteTextColor),
            ),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.003),
           /// const FittedBox(fit: BoxFit.fitWidth,
            const FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppText.loginScreenText,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Constant.whiteTextColor),
              ),
            ),
          ],
        ));
  }

  Widget SignInBottomBar(){

    ///Expanded
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
       // height: double.infinity,
        decoration: const BoxDecoration(
          color: Constant.authGreyBoxColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0),),
        ),
        child: LoginWidget(),
      ),
    );
  }

  Widget LoginWidget() {
    return Form(
      key: formKey,
      child: Column(children: <Widget>[

        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
        WidgetView().customTextField(false,EmailController,Constant.authTextBoxColor,Constant.whiteTextColor,AppText.hintEmailText, AppText.email),
        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
        WidgetView().customTextField(true,PasswordController,Constant.authTextBoxColor,Constant.whiteTextColor,AppText.hintPasswordText,AppText.password),
        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),

        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async{ await _auth.Login(formKey, context, EmailController.text.trim(),
                PasswordController.text.trim());},
            child: const Text(AppText.logInCamelCase,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Constant.whiteTextColor
            ),),
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              primary: Constant.baseColorRed,
              shape: RoundedRectangleBorder(
                // side: const BorderSide(width: 2,color: Constant.whiteTextColor),
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),),
          ),
        ),

        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),

        RichText(
          text:  TextSpan(
            style: const TextStyle(color: Constant.blackTextColor,fontSize: 16),
            children: <TextSpan>[
              const TextSpan(text: AppText.dontHaveAccount, ),
              TextSpan(
                  text: AppText.signUp,
                  recognizer: TapGestureRecognizer()..onTap = () => goToRegisterPage(),
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Constant.redTextColor)),
            ],
          ),
        )

      ]),
    );
  }

  void goToRegisterPage(){

    if(widget.isStartScreen){
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) =>   RegisterScreen(isStartScreen: false,)),
      );

    }else{
      Navigator.of(context).pop();
    }
  }




}
