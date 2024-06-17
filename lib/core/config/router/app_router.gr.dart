// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    MindMapRoute.name: (routeData) {
      final args = routeData.argsAs<MindMapRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MindMapPage(
          key: args.key,
          mindMap: args.mindMap,
        ),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MindMapPage]
class MindMapRoute extends PageRouteInfo<MindMapRouteArgs> {
  MindMapRoute({
    Key? key,
    required MindMap mindMap,
    List<PageRouteInfo>? children,
  }) : super(
          MindMapRoute.name,
          args: MindMapRouteArgs(
            key: key,
            mindMap: mindMap,
          ),
          initialChildren: children,
        );

  static const String name = 'MindMapRoute';

  static const PageInfo<MindMapRouteArgs> page =
      PageInfo<MindMapRouteArgs>(name);
}

class MindMapRouteArgs {
  const MindMapRouteArgs({
    this.key,
    required this.mindMap,
  });

  final Key? key;

  final MindMap mindMap;

  @override
  String toString() {
    return 'MindMapRouteArgs{key: $key, mindMap: $mindMap}';
  }
}
