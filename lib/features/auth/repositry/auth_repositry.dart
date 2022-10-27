// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:chat_app/common/common_firebase_storage.dart';
import 'package:chat_app/features/auth/screens/mobile_layout_screen.dart';
import 'package:chat_app/features/auth/screens/otp_screen.dart';
import 'package:chat_app/features/auth/screens/user_information_screen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autRepositryProvider = Provider((ref) => AuthRepositry(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepositry {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepositry({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(String phoneNumber, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (String verifcationId, int? resendToken) {
            Navigator.pushNamed(context, OtpScreen.otpScreenName,
                arguments: verifcationId);
          },
          codeAutoRetrievalTimeout: (String okay) {});
    } catch (e) {
      MySnackBar.showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOtp({
    required bool mounted,
    required BuildContext context,
    required String verifcationId,
    required String userOtp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifcationId, smsCode: userOtp);
      await auth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoScreen.screenName, (route) => false);
    } on FirebaseAuthException catch (e) {
      MySnackBar.showSnackBar(context: context, content: e.toString());
    }
  }

  void saveUserDataToFirebase(
      {required String name,
      required File? profilePic,
      required ProviderRef ref,
      required bool mounted,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = '';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepoProivider)
            .storeFileToFirebase('profile pic/$uid', profilePic);
      }

      UserModel user = UserModel(
          uid: uid,
          name: name,
          phoneNum: auth.currentUser!.uid,
          groupId: [],
          isOnline: true,
          profilePic: photoUrl);

      await firestore.collection('users').doc(uid).set(user.toMap());

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.screenName, (route) => false);
    } catch (e) {
      MySnackBar.showSnackBar(context: context, content: e.toString());
    }
  }
}
