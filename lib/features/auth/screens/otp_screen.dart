import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/utils/colorconsts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  final String verificationId;
  static String otpScreenName = 'Otpscreen';

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Enter verification Code',
            style: GoogleFonts.aBeeZee(
                fontSize: size.height * 0.02, color: Colors.black)),
        centerTitle: true,
      ),
      body: otpScreenBody(size),
    );
  }

  Widget otpScreenBody(Size size) {
    return Column(
      children: [
        Expanded(
            child: TextField(
          onChanged: (value) {
            if (value.length == 6) {
              verifyOtp(value.trim());
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorConsts.colorSecondry,
            hintText: '- - - - - -',
            border: const OutlineInputBorder(),
            constraints: BoxConstraints(
                minHeight: size.height * 0.1, minWidth: size.width * 0.7),
          ),
          keyboardType: TextInputType.number,
        )),
        Expanded(
            child: Container(
          height: 100,
          width: 100,
          color: ColorConsts.appBarColor,
        ))
      ],
    );
  }

  void verifyOtp(String userOtp) {
    ref
        .read(authControllerProvider)
        .verifyOtp(mounted, context, widget.verificationId, userOtp);
  }
}
