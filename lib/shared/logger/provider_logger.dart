import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    if (true) return;

    log('''{
      "provider" : "${provider.name ?? provider.runtimeType}",
      "oldValue" : $previousValue,
      "newValue" : $newValue
    }''');

    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
