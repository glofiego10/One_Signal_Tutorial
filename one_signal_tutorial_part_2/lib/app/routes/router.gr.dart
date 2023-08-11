// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:one_signal_tutorial/screens/details/screen_details_1.dart'
    as _i1;
import 'package:one_signal_tutorial/screens/details/screen_details_2.dart'
    as _i2;
import 'package:one_signal_tutorial/screens/home/home.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    DetailsRoute1.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DetailsPage1(),
      );
    },
    DetailsRoute2.name: (routeData) {
      final args = routeData.argsAs<DetailsRoute2Args>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DetailsPage2(
          key: args.key,
          textNotification: args.textNotification,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DetailsPage1]
class DetailsRoute1 extends _i4.PageRouteInfo<void> {
  const DetailsRoute1({List<_i4.PageRouteInfo>? children})
      : super(
          DetailsRoute1.name,
          initialChildren: children,
        );

  static const String name = 'DetailsRoute1';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DetailsPage2]
class DetailsRoute2 extends _i4.PageRouteInfo<DetailsRoute2Args> {
  DetailsRoute2({
    _i5.Key? key,
    required String textNotification,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          DetailsRoute2.name,
          args: DetailsRoute2Args(
            key: key,
            textNotification: textNotification,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute2';

  static const _i4.PageInfo<DetailsRoute2Args> page =
      _i4.PageInfo<DetailsRoute2Args>(name);
}

class DetailsRoute2Args {
  const DetailsRoute2Args({
    this.key,
    required this.textNotification,
  });

  final _i5.Key? key;

  final String textNotification;

  @override
  String toString() {
    return 'DetailsRoute2Args{key: $key, textNotification: $textNotification}';
  }

  Map<String, dynamic> toJson() {
    return {
      'textNotification': textNotification,
    };
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
