import 'dart:io';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker {
  static Future<File?> pickImageFromGallary(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      MySnackBar.showSnackBar(context: context, content: e.toString());
    }
    return image;
  }
}
