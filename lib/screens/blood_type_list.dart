import 'package:blood_donation/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/widget_view.dart';
import '../models/all_user.dart';
import '../services/database.dart';

class BloodTypeList extends StatefulWidget {
  String type;

  BloodTypeList({Key? key, required this.type}) : super(key: key);

  @override
  State<BloodTypeList> createState() => _BloodTypeListState();
}

class _BloodTypeListState extends State<BloodTypeList> {
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Constant.whiteTextColor,
          ),
          backgroundColor: Colors.transparent,

          elevation: 0,
          actions: <Widget>[
            IconButton(
              color: Constant.whiteTextColor,
              icon: const Icon(Icons.settings_rounded),
              tooltip: 'Submit Data',
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const ProfileScreen()),
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
            child: Column(
              children: [
                Container(

                  color: Constant.searchTopBarColor,
                  height: 200, child:
                Column(
                  children: [

                    WidgetView().redShape(),
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Container(

                        margin: const EdgeInsets.only(bottom: 15),
                        // margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),

                        decoration: BoxDecoration(

                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(1, 1),
                              )
                            ]

                        ),
                        child: searchTextField(
                            false, SearchController, Constant.searchBoxColor,
                            Constant.redTextColor, AppText.hintSearchText,
                            AppText.search),
                      ),
                    ),
                  ],
                ),
                ),
                Flexible(child: SingleChildScrollView(child: donorListWidget())),
              ],
            ))

    );
  }

  Widget donorListWidget() {
    return StreamBuilder(
      stream: DatabaseService().readUsersByTypes(widget.type, SearchController.text),
      builder: (BuildContext context, AsyncSnapshot<List<AllUser>> snapshot) {
        if (snapshot.hasError) {
          return SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },

                  child: const Text("Logout"),
                ),


              ],
            ),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.05),
              const Text(
                AppText.donorList,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Constant.redTextColor),
              ),
              WidgetView().spaceHeight(MediaQuery.of(context).size.height * 0.02),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: user.length,
                  itemBuilder: (context, index) {
                    final identifier = user[index];

                    return DonorListCard(
                        identifier.name.toString(), identifier.age.toString(),
                        identifier.bloodGroup.toString(),
                        identifier.mobile.toString(),
                        identifier.district.toString(),
                        identifier.donationDate.toString(),
                        user.length-1,
                        index);
                  }),
              user.isEmpty ? const Text(
                AppText.noDataFound,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Constant.authTextBoxColor),
              ): SizedBox()


            ],
          );
        }
        else {
          return const Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,),);
        }
      },
    );
  }

  Widget DonorListCard(String name, String age, String bloodGroup, String phone,
      String district, String lastDonate, int length, int index ) {
    return Container(

      margin:  EdgeInsets.only(top: 20, left: 20, right: 20 , bottom: index == length? 20 : 0 ),
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
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Constant.whiteTextColor),),
                Text("Age : $age", style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Constant.whiteTextColor),),
                Text("District : $district", style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Constant.whiteTextColor),),
                Text("Mobile : $phone", style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Constant.whiteTextColor),),

                Text("Last Donate : $lastDonate", style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Constant.whiteTextColor),),
              ],
            ),
          ),
          WidgetView().spaceWidth(MediaQuery.of(context).size.width * 0.02),
          Container(
            //color: Colors.blue,
              width: MediaQuery.of(context).size.width * 0.4 - 90 - MediaQuery.of(context).size.width * 0.04,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(bloodGroup,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Constant.whiteTextColor),),
              )),
        ],
      ),
    );
  }

  Widget searchTextField(bool isPasswordType,TextEditingController
  _controller, Color _fillColor, Color _hintTextColor,
      String _hintText,String function,){

    return  Container(
      child: TextFormField(
        scrollPadding:  EdgeInsets.only(
            bottom: function==AppText.search ? 0 : 400),
        controller: _controller,
        onChanged: (value){
          setState(() {
            TextSelection previousSelection = _controller.selection;
            _controller.text = value;
            _controller.selection = previousSelection;
          });


        },
        obscureText: isPasswordType,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            isDense: true,
            fillColor: _fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: _hintText,
            hintStyle: TextStyle(color: _hintTextColor)
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,


      ),
    );
  }
}
