import 'package:chat_app/features/auth/screens/login_screen.dart';
import 'package:chat_app/utils/colorconsts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              r'assets/images/landigbg.PNG',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: myBoxDecoration(size),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: myBoxDecoration(size),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            textAlign: TextAlign.center,
                            'Read our Privacy Policy.Tap "Agree and Continue" .',
                            style: GoogleFonts.aBeeZee(
                                fontSize: size.height * 0.02)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        child: const Text('Agree and Continue'),
                        onPressed: () => navigateToLoginScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  myBoxDecoration(Size size) {
    return BoxDecoration(
        color: ColorConsts.appBarColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.height * 0.03),
            topRight: Radius.circular(size.height * 0.03)));
  }

  navigateToLoginScreen() {
    Navigator.pushNamed(context, LoginScreen.screenName);
  }
}
