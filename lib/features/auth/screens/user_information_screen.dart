import 'dart:io';

import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/utils/colorconsts.dart';
import 'package:chat_app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);
  static const screenName = 'UserInfoScreeb';

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final userNameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.4,
                child: pickedImageOrNot(),
              ),
              Positioned(
                bottom: size.height * 0.1,
                left: size.width * 0.23,
                child: IconButton(
                  onPressed: selectImage,
                  icon: Icon(Icons.photo_camera,
                      size: size.height * 0.05,
                      color: ColorConsts.colorSecondry),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(hintText: 'Enter your name'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                storeUserDate();
              },
              child: const Icon(Icons.done)),
        ],
      ),
    ));
  }

  Widget pickedImageOrNot() {
    if (image != null) {
      return CircleAvatar(
        backgroundImage: FileImage(image!),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Colors.red,
      );
    }
  }

  void selectImage() async {
    image = await MyImagePicker.pickImageFromGallary(context);
    setState(() {});
  }

  void storeUserDate() async {
    String name = userNameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .savaUserDataToFirebase(context, name, image, mounted);
    }
  }
}
