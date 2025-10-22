import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State notifier for managing counter state
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  /// Increment the counter
  void increment() {
    state++;
  }

  /// Decrement the counter
  void decrement() {
    if (state > 0) {
      state--;
    }
  }

  /// Reset the counter
  void reset() {
    state = 0;
  }
}

/// Provider for counter state
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

