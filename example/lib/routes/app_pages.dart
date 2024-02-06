import 'package:get/get.dart';

import '../screen/home/home_binding.dart';
import '../screen/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  AppPages();

  final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    /*GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),*/
  ];
}
