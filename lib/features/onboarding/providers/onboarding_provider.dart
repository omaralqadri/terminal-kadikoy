import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_kadikoy/features/onboarding/models/onboarding_item.dart';

/// State for onboarding
class OnboardingState {
  final int currentPage;
  final List<OnboardingItem> items;

  const OnboardingState({
    required this.currentPage,
    required this.items,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingItem>? items,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      items: items ?? this.items,
    );
  }

  bool get isLastPage => currentPage >= items.length - 1;
  int get totalPages => items.length;
}

/// Notifier for onboarding state
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(_initialState);

  /// Fixed onboarding data (will be replaced with API data later)
  static final OnboardingState _initialState = OnboardingState(
    currentPage: 0,
    items: const [
      OnboardingItem(
        title: 'onboarding_screen_1_title',
        description: 'onboarding_screen_1_description',
        imageUrl: 'assets/images/onboarding/onboarding_1.png',
      ),
      OnboardingItem(
        title: 'onboarding_screen_2_title',
        description: 'onboarding_screen_2_description',
        imageUrl: 'assets/images/onboarding/onboarding_2.png',
      ),
      OnboardingItem(
        title: 'onboarding_screen_3_title',
        description: 'onboarding_screen_3_description',
        imageUrl: 'assets/images/onboarding/onboarding_3.png',
      ),
    ],
  );

  /// Move to next page
  void nextPage() {
    if (!state.isLastPage) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  /// Move to previous page
  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  /// Go to specific page
  void goToPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      state = state.copyWith(currentPage: page);
    }
  }

  /// Skip to last page
  void skipToEnd() {
    state = state.copyWith(currentPage: state.totalPages - 1);
  }

  /// Reset to first page
  void reset() {
    state = state.copyWith(currentPage: 0);
  }

  /// Load onboarding data from API (for future implementation)
  Future<void> loadFromApi() async {
    // TODO: Implement API call when backend is ready
    // final response = await api.getOnboardingItems();
    // state = state.copyWith(items: response);
  }
}

/// Provider for onboarding state
final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});

