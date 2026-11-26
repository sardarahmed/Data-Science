import 'package:go_router/go_router.dart';

import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/rooms/create_room_screen.dart';
import '../features/rooms/join_room_screen.dart';
import '../features/lobby/game_lobby_screen.dart';
import '../features/gameplay/game_screen.dart';
import '../features/gameplay/consequence_reveal_screen.dart';
import '../features/gameplay/next_round_screen.dart';
import '../features/results/final_results_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/profile/profile_setup_screen.dart';
import '../features/navigation/main_shell.dart';
import '../features/groups/create_group_screen.dart';
import '../features/groups/group_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
    GoRoute(
      path: '/profile/setup',
      builder: (_, __) => const ProfileSetupScreen(),
    ),
    GoRoute(path: '/home', builder: (_, __) => const MainShell()),
    GoRoute(
      path: '/groups/create',
      builder: (_, __) => const CreateGroupScreen(),
    ),
    GoRoute(
      path: '/groups/detail',
      builder: (_, state) =>
          GroupDetailScreen(extra: state.extra as Map<String, dynamic>? ?? {}),
    ),
    GoRoute(path: '/create', builder: (_, __) => const CreateRoomScreen()),
    GoRoute(path: '/join', builder: (_, __) => const JoinRoomScreen()),
    GoRoute(path: '/lobby', builder: (_, __) => const GameLobbyScreen()),
    GoRoute(path: '/game', builder: (_, __) => const GameScreen()),
    GoRoute(
      path: '/reveal',
      builder: (_, __) => const ConsequenceRevealScreen(),
    ),
    GoRoute(path: '/next', builder: (_, __) => const NextRoundScreen()),
    GoRoute(path: '/results', builder: (_, __) => const FinalResultsScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
