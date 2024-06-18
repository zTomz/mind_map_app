import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  late final PackageInfo packageInfo;

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
