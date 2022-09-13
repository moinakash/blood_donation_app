import 'package:blood_donation/Utils/constants.dart';
import 'package:blood_donation/screens/login_screens.dart';
import 'package:blood_donation/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/widget_view.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: double.infinity,
        width: double.infinity,
        color: Constant.baseColorRed,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Transform.translate(
                offset: Offset(-20,0),
                  child: WidgetView().lightRedShape()),

              spaceHeight(MediaQuery.of(context).size.height * 0.1),
              WidgetView().logoView(context),
              spaceHeight(MediaQuery.of(context).size.height * 0.04),
              const SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            AppText.startPageHeading,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Constant.whiteTextColor
                            ),
                          )))),
              spaceHeight(MediaQuery.of(context).size.height * 0.12),
              SizedBox(
                height: 65,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {goToLoginPage();},
                  child: const Text(AppText.logIn,style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Constant.redTextColor
                  ),),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    primary: Constant.whiteTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),),
                ),
              ),

              spaceHeight(30),
              SizedBox(
                height: 65,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {goToRegisterPage();},
                  child: const Text(AppText.signIn,style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Constant.whiteTextColor
                  ),),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    primary: Constant.baseColorRed,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2,color: Constant.whiteTextColor),
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget spaceHeight(double sizes){

    return SizedBox(
      height: sizes,
    );
  }

  void goToRegisterPage(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) =>  RegisterScreen(isStartScreen: true,)),
    );
  }

  void goToLoginPage(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) =>  LoginScreen(isStartScreen: true,)),
    );
  }

}
