import 'dart:developer';

import 'package:bloc/bloc.dart';

/// Observer for blocs
class MindMapObserver extends BlocObserver {
  const MindMapObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    log('${bloc.runtimeType} $change');
  }
}
