import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class BrandBanner extends StatelessWidget {
  final bool compact;
  final String? subtitle;
  final String? supportingText;

  const BrandBanner({
    super.key,
    this.compact = false,
    this.subtitle,
    this.supportingText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final subheading = subtitle ?? AppConstants.appTagline;
    final details = supportingText ?? AppConstants.appDescription;

    return compact
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BrandMark(size: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subheading,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.78),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      details,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BrandMark(size: 68),
              const SizedBox(height: 18),
              Text(
                AppConstants.appName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subheading,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.82),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                details,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.64),
                ),
              ),
            ],
          );
  }
}

class _BrandMark extends StatelessWidget {
  final double size;

  const _BrandMark({required this.size});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.34),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.24),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.key_rounded,
        size: size * 0.46,
        color: colorScheme.onPrimary,
      ),
    );
  }
}