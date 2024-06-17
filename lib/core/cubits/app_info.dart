import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// This cubit holds the app information
class AppInfoCubit extends Cubit<PackageInfo> {
  AppInfoCubit({required PackageInfo packageInfo}) : super(packageInfo);

  /// This method updates the package info
  void updatePackageInfo(PackageInfo packageInfo)  {
    emit(packageInfo);
  }
}
