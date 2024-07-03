import 'package:authentication/Activity/activity_screen.dart';
import 'package:authentication/Setting/privacy_screen.dart';
import 'package:authentication/Setting/setting_screen.dart';
import 'package:authentication/authentication/create_account_screen.dart';
import 'package:authentication/authentication/login_screen.dart';
import 'package:authentication/authentication/repos/authentiaction_repository.dart';
import 'package:authentication/authentication/sign_up_srcreen.dart';
import 'package:authentication/navigationbar/default_screen.dart';
import 'package:authentication/navigationbar/home_screen.dart';
import 'package:authentication/profile/profile_screen.dart';
import 'package:authentication/search/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpSrcreen.routerUrl &&
            state.subloc != CreateAccountScreen.routerUrl &&
            state.subloc != LoginScreen.routerUrl) {
          return '/';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SignUpSrcreen(),
      ),
      GoRoute(
        path: SignUpSrcreen.routerUrl,
        builder: (context, state) => const SignUpSrcreen(),
      ),
      GoRoute(
        path: LoginScreen.routerUrl,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
          path: CreateAccountScreen.routerUrl,
          builder: (context, state) {
            return const CreateAccountScreen(null);
          }),
      GoRoute(
          path: DefaultScreen.routerUrl,
          builder: (context, state) {
            final tab = state.queryParams['show'] ?? 'home';
            return DefaultScreen(tab: tab);
          }),
      GoRoute(
        path: HomeScreen.routerUrl,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: SearchScreen.routerUrl,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: ActivityScreen.routerUrl,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: ProfileScreen.routerUrl,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: SettingScreen.routerUrl,
        builder: (context, state) => const SettingScreen(),
        routes: [
          GoRoute(
            path: PrivacyScreen.routerUrl,
            builder: (context, state) => const PrivacyScreen(),
          ),
        ],
      ),
    ],
  );
});
