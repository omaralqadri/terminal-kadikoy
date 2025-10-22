/// Model for onboarding screen items
/// Ready for API integration with fromJson/toJson methods
class OnboardingItem {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  /// Create OnboardingItem from JSON (for API integration)
  factory OnboardingItem.fromJson(Map<String, dynamic> json) {
    return OnboardingItem(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  /// Convert OnboardingItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  /// Create a copy with modified fields
  OnboardingItem copyWith({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return OnboardingItem(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

