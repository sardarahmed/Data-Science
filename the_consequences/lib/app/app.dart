import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'router.dart';
import 'theme/app_theme.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

class TheConsequenceApp extends ConsumerWidget {
  const TheConsequenceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'The Consequence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(themeModeProvider),
      routerConfig: appRouter,
    );
  }
}
