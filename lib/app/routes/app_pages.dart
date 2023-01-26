
import 'package:AppsData/app/modules/dashboard/views/dashboard_view.dart';
import 'package:get/get.dart';

import '../modules/splash/view/splash_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHVIEW;

  static final routes = [
    GetPage(
      name: _Paths.SPLASHVIEW,
      page: () => const SplashView()
    ),
    GetPage(
      name: _Paths.DASHBOARDVIEW,
      page: () => const DashboardView()
    ),

  ];
}
