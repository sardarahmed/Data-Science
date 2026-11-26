import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon ?? Icons.arrow_forward_rounded),
    label: Text(label),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
  );
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text(label),
  );
}

class PlayerAvatar extends StatelessWidget {
  final String name;
  final int avatar;
  final double size;
  final bool host;
  const PlayerAvatar({
    super.key,
    required this.name,
    required this.avatar,
    this.size = 44,
    this.host = false,
  });

  @override
  Widget build(BuildContext context) {
    const colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.success,
      Color(0xFF64A7FF),
      Color(0xFFFFCF66),
      Color(0xFFE879B8),
    ];
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: colors[avatar % colors.length],
          child: Text(
            name.isEmpty ? '?' : name.characters.first.toUpperCase(),
            style: TextStyle(
              fontSize: size * .38,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        if (host)
          Positioned(
            right: -3,
            top: -5,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFFFCF66),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star_rounded,
                size: 14,
                color: Color(0xFF3A2B00),
              ),
            ),
          ),
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String? label;
  const LoadingWidget({super.key, this.label});
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        if (label != null) ...[const SizedBox(height: 12), Text(label!)],
      ],
    ),
  );
}

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    ),
  );
}

class ResponsiveScaffold extends StatelessWidget {
  final Widget child;
  const ResponsiveScaffold({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: child,
        ),
      ),
    ),
  );
}
