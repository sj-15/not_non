import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:not_non/features/auth/controller/auth_controller.dart';
import 'package:not_non/firebase_options.dart';
import 'package:not_non/router.dart';
import 'common/widgets/error.dart';
import 'common/widgets/loader.dart';
import 'features/landing/screens/landingscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/screens/mobilelayoutscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '!non',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return const LandingScreen();
            }
            return MobileLayoutScreen(
              notid: user.notid,
            );
            // return const EditProfile();
          },
          error: (err, trace) {
            return ErrorScreen(
              error: err.toString(),
            );
          },
          loading: () => const Loader()),
    );
  }
}
