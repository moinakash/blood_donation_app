import 'package:blood_donation/models/hospital_model.dart';
import 'package:blood_donation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/widget_view.dart';
import '../services/database.dart';

class IcuScreen extends StatefulWidget {
  const IcuScreen({Key? key}) : super(key: key);

  @override
  State<IcuScreen> createState() => _IcuScreenState();
}

class _IcuScreenState extends State<IcuScreen> {
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
                Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  //color: Constant.searchTopBarColor,
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    AppText.icu,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Constant.redTextColor),
                  ),
                ),
                WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
                donorListWidget()
              ],
            ),
          ),
        )



    );
  }

  Widget donorListWidget() {
    return StreamBuilder(
      stream: DatabaseService().readHospitalData(),
      //stream: DatabaseService().readUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<HospitalModel>> snapshot) {
        if (snapshot.hasError) {
          return const SingleChildScrollView(

            child: Text("Wrong"),

          );
        } else if (snapshot.hasData) {
          final hospitalData = snapshot.data!;
          return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: hospitalData.length,
              itemBuilder: (context, index) {
                final identifier = hospitalData[index];

                return DonorListCard(
                    identifier.hospitalName.toString(),
                    identifier.icuBed.toString(),
                    identifier.phone.toString(),
                    hospitalData.length-1,
                    index);
              });
        }
        else {
          return const Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,),);
        }
      },
    );
  }

  Widget DonorListCard(String hospital_name, String icu_bed, String phone, int length, int index ) {
    return Container(

      margin:  EdgeInsets.only(top: 20, left: 20, right: 20 , bottom: index == length? 20 : 0 ),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 10, bottom: 10),
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
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hospital_name, style: const TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Constant.whiteTextColor),),
            WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
            Text("আইসিইউ বেডঃ $icu_bed", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Constant.whiteTextColor),),
            Text("যোগাযোগঃ $phone", style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Constant.whiteTextColor),),

          ],
        ),
      ),
    );
  }
}
