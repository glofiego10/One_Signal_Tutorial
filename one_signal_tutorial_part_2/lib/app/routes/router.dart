import 'package:auto_route/auto_route.dart';
import 'package:one_signal_tutorial/app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: HomeRoute.page,
          initial: true,
          path: '/HomePage',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: DetailsRoute1.page,
          path: '/DetailsPage1',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: DetailsRoute2.page,
          path: '/DetailsPage2',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
