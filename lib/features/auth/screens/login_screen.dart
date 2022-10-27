import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String screenName = 'Login Screen';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneNumberController = TextEditingController();
  Country? _country;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Enter Your Phone Number',
            style: GoogleFonts.aBeeZee(
                fontSize: size.height * 0.02, color: Colors.black)),
        centerTitle: true,
      ),
      body: loginScreebody(size),
    );
  }

  Widget loginScreebody(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        const Text('We need to Verify Your Phone Number'),
        SizedBox(
          height: size.height * 0.03,
        ),
        TextButton(onPressed: pickCountry, child: const Text('Pick Country')),
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.09,
            ),
            if (_country != null) Text(('+${_country!.phoneCode}')),
            SizedBox(
              width: size.width * 0.02,
            ),
            SizedBox(
              width: size.width * 0.7,
              child: TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.5,
        ),
        ElevatedButton(
            onPressed: () {
              sendPhoneNumber();
            },
            child: const Text('Next')),
      ],
    );
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          setState(() {
            _country = country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = _phoneNumberController.text.trim();
    if (_country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${_country!.phoneCode}$phoneNumber');
    }
  }
}
