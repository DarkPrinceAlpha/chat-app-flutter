import 'package:chat_app/common/widgets/loader.dart';
import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/auth/screens/mobile_layout_screen.dart';
import 'package:chat_app/features/landing/landing_page.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/routes/my_routes.dart';
import 'package:chat_app/utils/colorconsts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/widgets/error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.from(colorScheme: const ColorScheme.light()).copyWith(
        scaffoldBackgroundColor: ColorConsts.appBarColor,
        appBarTheme: AppBarTheme(
          color: ColorConsts.appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => MyRoutes.myRoutes(settings),
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return const LandingPage();
            } else {
              return const HomeScreen();
            }
          },
          error: (error, stackTrace) => ErrorScreen(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
