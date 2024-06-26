// TODO: Create an app icon

import 'package:flutter/material.dart';
import 'package:open_mind/app/app.bottomsheets.dart';
import 'package:open_mind/app/app.dialogs.dart';
import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/app/app.router.dart';
import 'package:open_mind/services/app_info_service.dart';
import 'package:open_mind/ui/common/helper_functions.dart';
import 'package:open_mind/ui/common/theme.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  await locator<AppInfoService>().init();

  await addLicenses();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      theme: MaterialTheme().light(),
      darkTheme: MaterialTheme().darkMediumContrast(),
    );
  }
}
