import 'package:blood_donation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/widget_view.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
                WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.02),
                infoCard( ),
                WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.08),
                descriptionWidget( )

              ],
            ),
          ),
        )



    );
  }

  Widget infoCard( ) {
    return InkWell(
      onTap: (){

      },
      child: Container(

        margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
        padding: const EdgeInsets.only(top: 10, left: 30, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Constant.searchTopBarColor,
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
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              //  WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.0005),
              Text( AppText.info, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Constant.whiteTextColor),),
              // WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.0005),

            ],
          ),
        ),
      ),
    );
  }

  Widget descriptionWidget(){
    return Container(
        margin: const EdgeInsets.only( left: 20, right: 20 ),
        child: const Text(AppText.helpLine, style: TextStyle(fontSize: 23),));
  }
}
