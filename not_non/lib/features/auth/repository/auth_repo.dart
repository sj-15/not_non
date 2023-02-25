import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/notid.dart';
import 'package:not_non/common/utils/utils.dart';
import 'package:not_non/features/auth/screens/userinformation.dart';
import 'package:not_non/model/user_model.dart';

import '../../screens/mobilelayoutscreen.dart';
import '../screens/otpscreen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

String notId = '';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserDate() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
      notId = user.notid;
    } else {
      notId = notnonid();
    }
    return user;
  }

  void singInwithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OtpScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformation.routeName,
        (route) => false,
      );
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDatatoFirebase({
    required String notid,
    required File? profilePic,
    required String abouts,
    required int known,
    required int unknown,
    required ProviderRef ref,
    required BuildContext context,
    required List<String> interests,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = 'assets/avatars/avatar1.jpg';
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MobileLayoutScreen(),
          ),
          ((route) => false));
      var user = UserModel(
        uid: uid,
        notid: notid,
        profilePic: photoUrl,
        isOnline: true,
        abouts: abouts,
        phoneNumber: auth.currentUser!.uid,
        known: known,
        unknown: unknown,
        groupId: [],
        interests: interests,
      );
      await firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
