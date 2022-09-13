import 'package:blood_donation/models/hospital_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/all_user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({ this.uid});

  // collection reference
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users_db');

  Future<void> updateUserData(String name, String age, String bloodGroup, String district,
      String mobile, String donationDate, int createdAt) async {

      final allUser = AllUser(
          id: uid,
          name: name,
          name_lc: name.toLowerCase(),
          age: age,
          bloodGroup: bloodGroup,
          district: district,
          mobile: mobile,
          donationDate: donationDate,
          createdAt : createdAt
      );

      final json = allUser.toJson();
      return await usersCollection.doc(uid).update(json);

  }

  Future<void> saveUserData(String name, String age,String bloodGroup, String district,
      String mobile, String donationDate, int createdAt) async {

    final allUser = AllUser(
        id: uid,
        name: name,
        name_lc: name.toLowerCase(),
        age: age,
        bloodGroup: bloodGroup,
        district: district,
        mobile: mobile,
        donationDate: donationDate,
        createdAt : createdAt
    );

    final json = allUser.toJson();

    return await usersCollection.doc(uid).set(json);
  }

  Future<void> deleteUserData() async {
    return await usersCollection.doc(uid).delete();
  }
  
  // Stream<List<AllUser>> readUsers() => FirebaseFirestore.instance.collection('users_db')
  // //.where('age', isEqualTo: "A")
  // .orderBy('createdAt',descending: true)
  // .snapshots()
  // .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());

  Stream<List<HospitalModel>> readHospitalData() => FirebaseFirestore.instance.collection('hospital_db')
  .snapshots()
  .map((snapshot) => snapshot.docs.map((doc) => HospitalModel.fromJson(doc.data())).toList());

  Stream<List<AllUser>> readUsers(String SearchText) {

    if(SearchText.isEmpty){
      return FirebaseFirestore.instance.collection('users_db')
          .orderBy('createdAt',descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());
    }

    if(SearchText[0].toUpperCase()== SearchText[0]){

      return FirebaseFirestore.instance.collection('users_db')
         // .orderBy('createdAt',descending: false)
          .where("name", isGreaterThanOrEqualTo: SearchText,isLessThanOrEqualTo: "$SearchText\uf7ff")
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());

    }else{

      return FirebaseFirestore.instance.collection('users_db')
         // .orderBy('createdAt',descending: false)
          .where("name_lc", isGreaterThanOrEqualTo: SearchText,isLessThanOrEqualTo: "$SearchText\uf7ff")
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());

    }


  }


  // Stream<List<AllUser>> readUsersByTypes(String type, String SearchText) => FirebaseFirestore.instance.collection('users_db')
  //
  //     .where('bloodGroup', isEqualTo: type)
  //     .where("name", isGreaterThanOrEqualTo: SearchText,isLessThanOrEqualTo: "$SearchText\uf7ff")
  //     .where("name_lc", isGreaterThanOrEqualTo: SearchText,isLessThanOrEqualTo: "$SearchText\uf7ff")
  //     //.orderBy('createdAt',descending: false)
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());

  Stream<List<AllUser>> readUsersByTypes(String type, String SearchText) {

    if(SearchText.isEmpty){

      return FirebaseFirestore.instance.collection('users_db')

          .where('bloodGroup', isEqualTo: type)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());


    }

    if(SearchText[0].toUpperCase()== SearchText[0]){

      return FirebaseFirestore.instance.collection('users_db')

          .where('bloodGroup', isEqualTo: type)
          .where("name", isGreaterThanOrEqualTo: SearchText,isLessThanOrEqualTo: "$SearchText\uf7ff")
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());

    }else{

      return FirebaseFirestore.instance.collection('users_db')
          .where('bloodGroup', isEqualTo: type)
          .where("name_lc", isGreaterThanOrEqualTo: SearchText,isLessThanOrEqualTo: "$SearchText\uf7ff")
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AllUser.fromJson(doc.data())).toList());
    }

  }

  Future<AllUser?> readSingleUser() async{
    final User = FirebaseFirestore.instance.collection('users_db').doc(uid);
    final snapshot = await User.get();

    if(snapshot.exists){

      return AllUser.fromJson(snapshot.data()!);
    }
  }

  Future<AllUser?> readSingleUser2() async{
    final User = FirebaseFirestore.instance.collection('users_db').doc(uid);
    final snapshot = await User.get();

    if(snapshot.exists){

      return AllUser.fromJson(snapshot.data()!);
    }
  }

}
