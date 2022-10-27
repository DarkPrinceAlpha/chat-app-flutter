import 'package:chat_app/features/auth/screens/login_screen.dart';
import 'package:chat_app/features/auth/screens/mobile_layout_screen.dart';
import 'package:chat_app/features/auth/screens/otp_screen.dart';
import 'package:chat_app/features/auth/screens/user_information_screen.dart';
import 'package:chat_app/features/landing/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_route_animator/page_route_animator.dart';

class MyRoutes {
  static Route myRoutes(RouteSettings settings) {
    if (settings.name == LoginScreen.screenName) {
      return PageRouteAnimator(
        child: const LoginScreen(),
        routeAnimation: RouteAnimation.bottomToTopWithFade,
        settings: settings,
        curve: Curves.easeInOutBack,
        duration: const Duration(seconds: 1),
      );
    } else if (settings.name == OtpScreen.otpScreenName) {
      final verificationId = settings.arguments as String;
      return PageRouteAnimator(
        child: OtpScreen(
          verificationId: verificationId,
        ),
        routeAnimation: RouteAnimation.bottomToTopWithFade,
        settings: settings,
        curve: Curves.easeInOutBack,
        duration: const Duration(seconds: 1),
      );
    } else if (settings.name == UserInfoScreen.screenName) {
      return PageRouteAnimator(
          child: const UserInfoScreen(),
          routeAnimation: RouteAnimation.bottomRightToTopLeft);
    } else if (settings.name == HomeScreen.screenName) {
      return PageRouteAnimator(
          settings: settings,
          child: const HomeScreen(),
          routeAnimation: RouteAnimation.topLeftToBottomRight);
    } else {
      return PageRouteAnimator(
          settings: settings,
          child: const LandingPage(),
          routeAnimation: RouteAnimation.fadeAndScale,
          curve: Curves.slowMiddle);
    }
  }
}
