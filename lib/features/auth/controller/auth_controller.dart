// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:chat_app/features/auth/repositry/auth_repositry.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepositry = ref.watch(autRepositryProvider);
    return AuthController(authRepositry: authRepositry, ref: ref);
  },
);

final userDataAuthProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserData();
  },
);

class AuthController {
  final AuthRepositry authRepositry;
  final ProviderRef ref;
  AuthController({
    required this.authRepositry,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepositry.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNum) {
    authRepositry.signInWithPhone(phoneNum, context);
  }

  void verifyOtp(bool mounted, BuildContext context, String verifcationId,
      String userOtp) {
    authRepositry.verifyOtp(
        mounted: mounted,
        context: context,
        verifcationId: verifcationId,
        userOtp: userOtp);
  }

  void savaUserDataToFirebase(
    BuildContext context,
    String name,
    File? profilePic,
    bool mounted,
  ) {
    authRepositry.saveUserDataToFirebase(
        name: name,
        profilePic: profilePic,
        ref: ref,
        context: context,
        mounted: mounted);
  }
}
