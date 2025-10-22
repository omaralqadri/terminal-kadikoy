import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';
import 'package:terminal_kadikoy/core/providers/locale_provider.dart';
import 'package:terminal_kadikoy/features/home/providers/counter_provider.dart';
import 'package:terminal_kadikoy/features/home/widgets/counter_display.dart';
import 'package:terminal_kadikoy/features/home/widgets/language_selector.dart';

/// Home screen of the application
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final locale = ref.watch(localeProvider);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.homeTitle),
        actions: const [
          LanguageSelector(),
          SizedBox(width: AppConstants.paddingMedium),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome message
              Text(
                localizations.welcomeMessage,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingXLarge),

              // Counter display
              CounterDisplay(count: counter),
              const SizedBox(height: AppConstants.paddingLarge),

              // Counter label
              Text(
                localizations.counterLabel,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingXLarge),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decrement button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(counterProvider.notifier).decrement();
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text(''),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingLarge),

                  // Reset button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(counterProvider.notifier).reset();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                  const SizedBox(width: AppConstants.paddingLarge),

                  // Increment button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(counterProvider.notifier).increment();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(''),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingXLarge),

              // Current language display
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.language, color: AppColors.primary),
                      const SizedBox(width: AppConstants.paddingSmall),
                      Text(
                        'Current Language: ${locale.languageCode.toUpperCase()}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        tooltip: localizations.incrementButton,
        child: const Icon(Icons.add),
      ),
    );
  }
}

