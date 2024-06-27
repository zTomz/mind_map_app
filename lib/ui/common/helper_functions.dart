import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// This function adds all licenses of software used in this project to
/// the `LicenseRegistry`
Future<void> addLicenses() async {
  // Add font licenses
  final fontLicenseText = await rootBundle.loadString(
    'assets/fonts/license.txt',
  );
  LicenseRegistry.addLicense(
    () => Stream<LicenseEntry>.value(
      LicenseEntryWithLineBreaks(
        <String>['Satoshi Font', 'Clash Display Font'],
        fontLicenseText,
      ),
    ),
  );
}
