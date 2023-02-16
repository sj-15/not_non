import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/model/user_model.dart';

final searchRepositoryProvider = Provider(
  (ref) => SearchRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class SearchRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  SearchRepository({required this.auth, required this.firestore});

  Future<UserModel?> getInterest() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user = UserModel.fromMap(userData.data()!);

    return user;
  }

  Future<List<InterestsModel?>> searchUser(
      String interest, BuildContext context) async {
    var userCollection = await firestore.collection('users').get();
    int index = 0;
    List<InterestsModel?> users = [];
    for (var document in userCollection.docs) {
      var userData = UserModel.fromMap(document.data());
      List<String> interests = userData.interests;
      for (String topic in interests) {
        if (topic == interest && userData.uid != auth.currentUser?.uid) {
          users.insert(
            index,
            InterestsModel(
              notid: userData.notid,
              profilePic: userData.profilePic,
              interests: userData.interests,
            ),
          );
          index++;
        }
      }
    }
    return users;
  }
}
