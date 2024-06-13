import 'package:get/get.dart';
import 'package:scn_easy/view/screens/auth/signin_screen.dart';
import 'package:scn_easy/view/screens/lottery/lotto_main_page_dashbaord.dart';
import 'package:scn_easy/view/screens/splash/splash_screen.dart';

import '../view/screens/profile/profile_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String dashboard = '/dashboard';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String signIn = '/sign-in';
  static const String verification = '/verification';
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';
  static const String address = '/address';
  static const String orderSuccess = '/order-successful';
  static const String payment = '/payment';

  static String getInitialRoute() => '$initial';

  static String getDashboardRoute() => '$dashboard';

  static String getSplashRoute() => '$splash';

  static String getLanguageRoute(String page) => '$language?page=$page';

  static String getSignInRoute() => '$signIn';

  static String getProfileRoute() => '$profile';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => SignInScreen()),
    // GetPage(name: dashboard, page: () => DashboardScreen(pageIndex: 1)),
    GetPage(name: dashboard, page: () => LotteryMainPage()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
  ];
}
