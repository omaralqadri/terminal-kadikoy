import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_kadikoy/core/providers/locale_provider.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

/// Widget to toggle between languages
class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String languageCode) {
        ref.read(localeProvider.notifier).changeLocale(languageCode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: AppConstants.englishCode,
          child: Row(
            children: [
              if (locale.languageCode == AppConstants.englishCode)
                const Icon(Icons.check, size: 20)
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              const Text('English'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: AppConstants.turkishCode,
          child: Row(
            children: [
              if (locale.languageCode == AppConstants.turkishCode)
                const Icon(Icons.check, size: 20)
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              const Text('Türkçe'),
            ],
          ),
        ),
      ],
    );
  }
}

