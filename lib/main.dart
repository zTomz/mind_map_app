import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map_app/core/config/bloc_observer.dart';
import 'package:mind_map_app/core/config/router/app_router.dart';
import 'package:mind_map_app/core/cubits/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const MindMapObserver();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  runApp(
    BlocProvider(
      create: (context) => AppInfoCubit(packageInfo: packageInfo),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static AppRouter appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mind Map App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
    );
  }
}
