import 'package:flutter_test/flutter_test.dart';
import 'package:open_mind/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TextFieldDialogDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
