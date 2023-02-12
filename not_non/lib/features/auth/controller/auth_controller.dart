import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/user_model.dart';
import '../repository/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserDate();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.singInwithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDatatoFirebase(
      BuildContext context,
      String notid,
      File? profilePic,
      String abouts,
      int known,
      int unknown,
      List<String> interests) {
    authRepository.saveUserDatatoFirebase(
      notid: notid,
      profilePic: profilePic,
      abouts: abouts,
      known: known,
      unknown: unknown,
      ref: ref,
      context: context,
      interests: interests,
    );
  }
}
