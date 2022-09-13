import 'package:blood_donation/models/all_user.dart';
import 'package:blood_donation/screens/update_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/widget_view.dart';
import '../main.dart';
import '../services/database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

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
                AppText.profileScreen,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Constant.redTextColor),
              ),
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.05),
              no_need()
            ],
          ),
        ),
      ),
    );
  }

  Widget no_need(){
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return FutureBuilder<AllUser?>(
        future: DatabaseService(uid: uid).readSingleUser(),
        builder: (context, snapshot) {

          if(snapshot.hasError){
            return Text("Something went wrong");
          }else if(snapshot.hasData){

            return Column(
              children: [

                ProfileCard(snapshot.data!.name.toString(), snapshot.data!.age.toString(),
                  snapshot.data!.bloodGroup.toString(),snapshot.data!.mobile.toString(),
                  snapshot.data!.district.toString(),
                  snapshot.data!.donationDate.toString(),),
                UpdateCard(),
                LogoutCard( ),

              ],
            );
          }else{
            return Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,),);

          }



        }
    );
  }

  Widget ProfileCard(String name, String age, String bloodGroup, String phone,
      String district, String lastDonate ) {
    return Container(

      margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
      padding: const EdgeInsets.only(top: 10, left: 30, right: 10, bottom: 10),
      decoration: BoxDecoration(
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
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text("Age : $age", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text("Blood Group : $bloodGroup", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text("District : $district", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text("Mobile : $phone", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text("Last Donate : $lastDonate", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
          ],
        ),
      ),
    );
  }

  Widget UpdateCard( ) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const UpdateScreen()),
        );
      },
      child: Container(

        margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
        padding: const EdgeInsets.only(top: 10, left: 30, right: 10, bottom: 10),
        decoration: BoxDecoration(
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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
              const Text( AppText.update, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Constant.whiteTextColor),),
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),

            ],
          ),
        ),
      ),
    );
  }

  Widget LogoutCard( ) {
    return InkWell(
      onTap: (){
        FirebaseAuth.instance.signOut();
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
      },
      child: Container(

        margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
        padding: const EdgeInsets.only(top: 10, left: 30, right: 10, bottom: 10),
        decoration: BoxDecoration(
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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
              const Text( AppText.logout, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Constant.whiteTextColor),),
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),

            ],
          ),
        ),
      ),
    );
  }

}
