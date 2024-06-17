import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mind_map_app/features/home/presentation/home_page.dart';
import 'package:mind_map_app/features/mind_map/data/models/mind_map.dart';
import 'package:mind_map_app/features/mind_map/presentation/mind_map_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: MindMapRoute.page),
      ];
}
