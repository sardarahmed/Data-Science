import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 800;
    return ResponsiveScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'THE CONSEQUENCE',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(radius: 18, child: Text('A')),
                  ),
                  IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.settings_rounded),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: isWide
                  ? Row(
                      children: [
                        Expanded(child: _Hero()),
                        const SizedBox(width: 20),
                        const Expanded(child: _ActionCard()),
                      ],
                    )
                  : Column(
                      children: [
                        _Hero(),
                        const SizedBox(height: 16),
                        const _ActionCard(),
                      ],
                    ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Text(
                'This week',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: isWide
                ? SliverGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.35,
                    children: const [
                      _HowCard(),
                      _ChallengeCard(),
                      _StatsCard(),
                    ],
                  )
                : SliverList.list(
                    children: const [
                      _HowCard(),
                      SizedBox(height: 12),
                      _ChallengeCard(),
                      SizedBox(height: 12),
                      _StatsCard(),
                    ],
                  ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: .14),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: AppColors.primary.withValues(alpha: .22)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'PARTY GAME',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'One choice can\nchange everything.',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        const Text(
          'Bring your friends together. See what happens next.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
      ],
    ),
  );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard();
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          PrimaryButton(
            label: 'CREATE A ROOM',
            icon: Icons.add_rounded,
            onPressed: () => context.push('/create'),
          ),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'JOIN A ROOM',
            icon: Icons.login_rounded,
            onPressed: () => context.push('/join'),
          ),
        ],
      ),
    ),
  );
}

class _HowCard extends StatelessWidget {
  const _HowCard();
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.help_outline_rounded, color: AppColors.primary),
          const SizedBox(height: 12),
          Text('How to play', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text(
            'Choose privately. The group consequence is revealed together.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    ),
  );
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard();
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.emoji_events_rounded, color: AppColors.secondary),
          const SizedBox(height: 12),
          Text(
            'Daily challenge',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          const Text(
            'Would you erase one embarrassing memory?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    ),
  );
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.insights_rounded, color: AppColors.success),
          const SizedBox(height: 12),
          Text(
            'Your statistics',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          const Text(
            '12 choices · 3 rematches · 67% chaotic',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    ),
  );
}
