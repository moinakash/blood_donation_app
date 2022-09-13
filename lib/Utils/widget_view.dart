import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class WidgetView{

  Widget logoView(BuildContext context){

    return Image.asset(
        'assets/icons/app_icon.jpg',
        height: MediaQuery.of(context).size.width * 0.4,
        width: MediaQuery.of(context).size.width * 0.4,
        fit: BoxFit.cover
      //'assets/icons/logo.png',
    );

  }

  Widget customTextField(bool isPasswordType,TextEditingController
  _controller, Color _fillColor, Color _hintTextColor,
      String _hintText,String function,){

    return  Container(
      child: TextFormField(
        scrollPadding:  EdgeInsets.only(
            bottom: function==AppText.search ? 0 : 400),
        controller: _controller,
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

        validator: (value){
          switch (function) {
            case AppText.email:
              {
                if( value != null && !EmailValidator.validate(value)){
                  return AppText.emailValidationText;
                }else{
                  return null;
                }

              }
            case AppText.password:
              {
                if(value != null && value.length < 6){
                  return AppText.passwordValidationText;
                }else{
                  return null;
                }
              }
            case AppText.name:
              {

                if( value !=null && value.isEmpty){
                  return AppText.nameValidationText;
                }else{
                  return null;
                }
              }
          }
          return null;

        },

      ),
    );
  }

  Widget profileTextField(bool isPasswordType,TextEditingController
  _controller, Color _fillColor, Color _hintTextColor,
      String _hintText,String function, Function? onTapFunction){

    return  TextFormField(
      scrollPadding: const EdgeInsets.only(
          bottom: 400),
      controller: _controller,
      obscureText: isPasswordType,
      decoration: InputDecoration(
          isDense: true,
          hintText: _hintText,
          hintStyle: TextStyle(color: _hintTextColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Constant.blackTextColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Constant.blackTextColor),
        ),

      ),

      keyboardType: function == AppText.age ? TextInputType.phone : function == AppText.mobileNum ? TextInputType.phone : null,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      onTap: () async{ onTapFunction!();},
      autovalidateMode: AutovalidateMode.onUserInteraction,

      validator: (value){
        switch (function) {

          case AppText.age:
            {
              if(value != null &&  value.length > 3  || value!.isEmpty || int.parse(value) <= 0 ){
                return AppText.ageValidationText;
              }else{
                return null;
              }
            }

          case AppText.mobileNum:
            {
              if(value != null &&  value.length > 11 || value!.length < 11 || value.isEmpty || int.parse(value) <= 0 ){
                return AppText.mobileValidationText;
              }else{
                return null;
              }
            }
          case AppText.name:
            {

              if( value !=null && value.isEmpty){
                return AppText.nameValidationText;
              }else{
                return null;
              }
            }
        }
        return null;

      },

    );
  }


  Align redShape(){

    return  Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 130,
        width: 150,
        decoration: BoxDecoration(
          color: Constant.baseColorRed,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(150)
          ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(1, 1),
              )
            ]
        ),
      ),
    );
  }

  Align lightRedShape(){

    return  Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 130,
        width: 150,
        decoration: const BoxDecoration(
            color: Constant.alphaRed,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(150)
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.3),
            //     spreadRadius: 1,
            //     blurRadius: 5,
            //     offset: const Offset(1, 1),
            //   )
            // ]
        ),
      ),
    );
  }


  Widget spaceHeight(double sizes) {
    return SizedBox(
      height: sizes,
    );
  }

  Widget spaceWidth(double sizes) {
    return SizedBox(
      width: sizes,
    );
  }

}