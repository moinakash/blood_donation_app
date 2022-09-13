import 'dart:math';

import 'package:blood_donation/screens/login_screens.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';
import '../Utils/utils.dart';
import '../Utils/widget_view.dart';
import '../services/auth.dart';

class RegisterScreen extends StatefulWidget {
  bool isStartScreen;
   RegisterScreen({Key? key, required this.isStartScreen}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  String fullName = '';

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
                        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
                        WidgetView().logoView(context),
                        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
                        SignUpTopbar(),
                        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
                        SignUpBottomBar(),

                      ],
                    ),
                  )
                ]



            ))
    );
  }

  Widget SignUpTopbar(){

    return Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            const Text(
              AppText.createAccount,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Constant.whiteTextColor),
            ),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.003),
            const FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppText.signUpScreenText,
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

  Widget SignUpWidget(){

    return Form(
      key: formKey,
      child: Column(children: <Widget>[


        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
        WidgetView().customTextField(false,NameController,Constant.authRedBoxColor,Constant.whiteTextColor,AppText.hintNameText, AppText.name),
        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
        WidgetView().customTextField(false,EmailController,Constant.authRedBoxColor,Constant.whiteTextColor,AppText.hintEmailText, AppText.email),
        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
        WidgetView().customTextField(true,PasswordController,Constant.authRedBoxColor,Constant.whiteTextColor,AppText.hintPasswordText, AppText.password),
        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
        WidgetView().customTextField(true,ConfirmPasswordController,Constant.authRedBoxColor,Constant.whiteTextColor,AppText.hintConfirmPasswordText, AppText.password),

        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),

        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async{

              if(PasswordController.text.trim()==ConfirmPasswordController.text.trim()){
                int CreatedAt = DateTime.now().millisecondsSinceEpoch;
                await _auth.SignUp(formKey,context,NameController.text.trim(),
                    EmailController.text.trim(),
                    PasswordController.text.trim() , CreatedAt);
              }else{
                Utils.showSnackbar("Password Not Matched");

              }


            },
            child: const Text(AppText.signUp,style: TextStyle(
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
              const TextSpan(text: AppText.alreadyHaveAccount, ),
              TextSpan(
                  text: AppText.signInCamelCase,
                  recognizer: TapGestureRecognizer()..onTap = () => goToLoginPage(),
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Constant.redTextColor)),
            ],
          ),
        ),

        WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),

      ]),
    );
  }

  Widget SignUpBottomBar(){

    ///Expanded
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        // height: double.infinity,
        decoration: const BoxDecoration(
          color: Constant.authGreyBoxColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0),),
        ),
        child: SignUpWidget(),
      ),
    );
  }

  goToLoginPage() {

    if(widget.isStartScreen){
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) =>   LoginScreen(isStartScreen: false,)),
      );

    }else{
      Navigator.of(context).pop();
    }

   // Navigator.of(context).pop();


  }


}
