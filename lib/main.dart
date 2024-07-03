import 'package:authentication/constants/sizes.dart';
import 'package:authentication/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: AuthenticationApp(),
    ),
  );
}

class AuthenticationApp extends ConsumerWidget {
  const AuthenticationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Authenticaiton UI',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white),
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size28,
            fontWeight: FontWeight.w800,
          ),
          titleSmall: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: Sizes.size16,
          ),
        ),
        primaryColor: const Color(0xFF1DA1F2),
      ),
    );
  }
}
