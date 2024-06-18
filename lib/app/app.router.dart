// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/home/home_view.dart' as _i2;
import 'package:open_mind/ui/views/mind_map/mind_map_view.dart' as _i3;
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart' as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i6;

class Routes {
  static const homeView = '/home-view';

  static const mindMapView = '/mind-map-view';

  static const all = <String>{
    homeView,
    mindMapView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.mindMapView,
      page: _i3.MindMapView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.MindMapView: (data) {
      final args = data.getArgs<MindMapViewArguments>(nullOk: false);
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.MindMapView(key: args.key, mindMap: args.mindMap),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MindMapViewArguments {
  const MindMapViewArguments({
    this.key,
    required this.mindMap,
  });

  final _i4.Key? key;

  final _i5.MindMap mindMap;

  @override
  String toString() {
    return '{"key": "$key", "mindMap": "$mindMap"}';
  }

  @override
  bool operator ==(covariant MindMapViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.mindMap == mindMap;
  }

  @override
  int get hashCode {
    return key.hashCode ^ mindMap.hashCode;
  }
}

extension NavigatorStateExtension on _i6.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMindMapView({
    _i4.Key? key,
    required _i5.MindMap mindMap,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.mindMapView,
        arguments: MindMapViewArguments(key: key, mindMap: mindMap),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMindMapView({
    _i4.Key? key,
    required _i5.MindMap mindMap,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.mindMapView,
        arguments: MindMapViewArguments(key: key, mindMap: mindMap),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
