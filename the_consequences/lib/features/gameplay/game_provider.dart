import 'package:flutter_riverpod/legacy.dart';

import 'game_state.dart';

final gameProvider = ChangeNotifierProvider<GameState>((ref) => GameState());
