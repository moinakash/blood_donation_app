import 'package:blood_donation/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/widget_view.dart';
import '../main.dart';
import '../models/all_user.dart';
import '../models/users.dart';
import '../services/database.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({Key? key}) : super(key: key);

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController NameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController DistrictController = TextEditingController();
  TextEditingController BloodGroupController = TextEditingController();
  TextEditingController MobileNumController = TextEditingController();
  TextEditingController LastDonateController = TextEditingController();

  String createdAt = "";

  Users? _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return WillPopScope(
      onWillPop: () async {

        User? user =  FirebaseAuth.instance.currentUser;
        print("data-- ${_userFromFirebaseUser(user!)!.uid}");
        await DatabaseService(uid: user.uid).deleteUserData();
        user.delete();

        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.profileAppBarColorRed,
          title: const Text(AppText.profileScreen),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.done),
              tooltip: 'Submit Data',
              onPressed: () async{
                final isValid = formKey.currentState!.validate();
                if(!isValid) return;

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context){
                      return const Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,));
                    });


                await DatabaseService(uid: user.uid).updateUserData(NameController.text.trim(),AgeController.text.trim(),
                    BloodGroupController.text.trim(),DistrictController.text.trim(),MobileNumController.text.trim(),
                    LastDonateController.text.trim(), int.parse(createdAt));

                navigatorKey.currentState!.popUntil((route) => route.isFirst);
                // handle the press
              },
            ),
          ],
        ),
        body:  FutureBuilder<AllUser?>(
            future: DatabaseService(uid: uid).readSingleUser(),
          builder: (context, snapshot) {

            if(snapshot.hasError){
              return const Text("Something went wrong");
            }else if(snapshot.hasData){
                createdAt = snapshot.data!.createdAt.toString();
              return add_info(snapshot.data!.name.toString());
            }else{
              return Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,),);

            }


          }
        )
        ,
      ),
    );
  }

  Widget add_info(String name){
    NameController.text = name;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
              WidgetView().profileTextField(false,NameController,Constant.authTextBoxColor,Constant.blackTextColor,AppText.hintNameText, AppText.name,null),

              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.05),
              const Text("Private Information" ,style: TextStyle(fontSize: 16) , textAlign: TextAlign.left,),

              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
              WidgetView().profileTextField(false,AgeController,Constant.authTextBoxColor,Constant.blackTextColor,AppText.hintAgeText, AppText.age,null),

              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
              WidgetView().profileTextField(false,BloodGroupController,Constant.authTextBoxColor,Constant.blackTextColor,AppText.hintBloodGroupText, AppText.bloodGroupName,BloodTypeFunction),


              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
              WidgetView().profileTextField(false,DistrictController,Constant.authTextBoxColor,Constant.blackTextColor,AppText.hintDistrictText, AppText.district,null),

              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
              WidgetView().profileTextField(false,MobileNumController,Constant.authTextBoxColor,Constant.blackTextColor,AppText.hintMobileNumText, AppText.mobileNum,null),

              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.03),
              WidgetView().profileTextField(false,LastDonateController,Constant.authTextBoxColor,Constant.blackTextColor,AppText.hintLastDonateText, AppText.lastDonate,LastDonateFunction),


            ],

          ),
        ),
      ),
    );
  }

   Future LastDonateFunction() async{

     DateTime? date = DateTime(1900);
     FocusScope.of(context).requestFocus(new FocusNode());

     date = await showDatePicker(
         context: context,
         initialDate:DateTime.now(),
         firstDate:DateTime(1900),
         lastDate: DateTime(2100));

     //LastDonateController.text = date!.toIso8601String();
     LastDonateController.text = DateFormat.yMMMd().format(date!);

  }
  List BloodTypeList = [
    AppText.aPositive, AppText.aNegative,
    AppText.bPositive, AppText.bNegative,
    AppText.abPositive,AppText.abNegative,
    AppText.oPositive,AppText.oNegative];

  Future BloodTypeFunction() async{

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 100),
        // title: Center(child: const Text('Select Blood Type')),
        content: Container(

          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.3,
          child: ListView.builder(itemCount: BloodTypeList.length,itemBuilder: (context , index){
            return InkWell(
              onTap: () async{

                print(BloodTypeList[index].toString());
                //  setState(() async{
                await Future.delayed(const Duration(milliseconds: 100));
                BloodGroupController.text = BloodTypeList[index].toString();

                await Future.delayed(const Duration(milliseconds: 100));
                Navigator.of(context).pop();
                //  });

              },
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
                  Text(BloodTypeList[index].toString(),style: TextStyle(fontSize: 20)),
                  WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.01),
                  Divider()
                ],
              ),
            );
          }),
        ),

      ),
    );

  }

}
