import 'package:blood_donation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/widget_view.dart';
import 'blood_type_list.dart';
import 'donor_list_screen.dart';

class BloodGroupScreen extends StatefulWidget {
  const BloodGroupScreen({Key? key}) : super(key: key);

  @override
  State<BloodGroupScreen> createState() => _BloodGroupScreenState();
}

class _BloodGroupScreenState extends State<BloodGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        //backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              color: Constant.blackTextColor,
              icon: const Icon(Icons.settings_rounded),
              tooltip: 'Submit Data',
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            const SizedBox(width: 10,),
          ],
        ),
        body: Container(
          color: Constant.authGreyBoxColor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [

                WidgetView().redShape(),

                WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
                const Text(
                  AppText.bloodGroup,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Constant.redTextColor),
                ),
                WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.08),
                HomeViewBtns()
              ],
            ),
          ),
        )



    );
  }

  Widget HomeViewBtns(){
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Buttons(AppText.aPositive,gotoDonorApListScreen),
              WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.15),
              Buttons(AppText.aNegative, gotoDonorAnListScreen),
            ],
          ),
          WidgetView().spaceHeight(MediaQuery.of(context).size.width * 0.08),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Buttons(AppText.bPositive,gotoDonorBpListScreen),
              WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.15),
              Buttons(AppText.bNegative,gotoDonorBnListScreen),
            ],
          ),
          WidgetView().spaceHeight(MediaQuery.of(context).size.width * 0.08),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Buttons(AppText.abPositive,gotoDonorABpListScreen),
              WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.15),
              Buttons(AppText.abNegative, gotoDonorABnListScreen),
            ],
          ),
          WidgetView().spaceHeight(MediaQuery.of(context).size.width * 0.08),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Buttons(AppText.oPositive,gotoDonorOpListScreen),
              WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.15),
              Buttons(AppText.oNegative,gotoDonorOnListScreen),
            ],
          ),
          WidgetView().spaceHeight(MediaQuery.of(context).size.width * 0.1),
        ],
      ),
    );
  }

  void gotoDonorApListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.aPositive ,)),
    );
  }

  void gotoDonorAnListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.aNegative ,)),
    );
  }

  void gotoDonorBpListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.bPositive ,)),
    );
  }

  void gotoDonorBnListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.bNegative ,)),
    );
  }

  void gotoDonorABpListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.abPositive ,)),
    );
  }

  void gotoDonorABnListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.abNegative ,)),
    );
  }

  void gotoDonorOpListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.oPositive ,)),
    );
  }

  void gotoDonorOnListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => BloodTypeList(type: AppText.oNegative ,)),
    );
  }

  Widget Buttons(String title,Function function){
    return InkWell(
      onTap: (){
        function();
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.25 ,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration:  BoxDecoration(
            color: Constant.baseColorRed,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(3, 3),
              )
            ]

        ),

        child:  Center(child: FittedBox( fit: BoxFit.cover,
          child: Text(title, textAlign:TextAlign.center, maxLines: 1,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Constant.whiteTextColor),),
        )),
      ),
    );
  }
}
