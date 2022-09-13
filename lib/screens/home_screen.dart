import 'package:blood_donation/Utils/constants.dart';
import 'package:blood_donation/models/all_user.dart';
import 'package:blood_donation/screens/blood_group_screen.dart';
import 'package:blood_donation/screens/donor_list_screen.dart';
import 'package:blood_donation/screens/hospital_screen.dart';
import 'package:blood_donation/screens/info_screen.dart';
import 'package:blood_donation/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/widget_view.dart';
import '../services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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

              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.05),
              const Text(
                AppText.homePage,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Constant.redTextColor),
              ),
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.18),
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
              Buttons(AppText.bloodGroup,gotoBloodGroupScreen),
              WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.05),
              Buttons(AppText.donorList, gotoDonorListScreen),
            ],
          ),
          WidgetView().spaceHeight(MediaQuery.of(context).size.width * 0.05),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Buttons(AppText.hospital,gotoHospitalScreen),
              WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.05),
              Buttons(AppText.info,gotoInfoScreen),
            ],
          )
        ],
      ),
    );
  }

  void gotoDonorListScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const DonorListScreen()),
    );
  }

  void gotoBloodGroupScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const BloodGroupScreen()),
    );
  }

  void gotoHospitalScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const HospitalScreen()),
    );
  }

  void gotoInfoScreen(){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const InfoScreen()),

    );
  }

  Widget Buttons(String title,Function function){
    return InkWell(
      onTap: (){
        function();
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.35 ,
        width: MediaQuery.of(context).size.width * 0.35,
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

        child:  Center(child: Text(title, textAlign:TextAlign.center,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Constant.whiteTextColor),)),
      ),
    );
  }

}
