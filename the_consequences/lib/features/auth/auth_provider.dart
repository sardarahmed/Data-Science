import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../core/services/auth_service.dart';
import '../../data/models/profile.dart';

final authServiceProvider = Provider<AuthService>((ref) => DemoAuthService());

final authProfileProvider =
    StateNotifierProvider<AuthProfileController, UserProfile?>(
      (ref) => AuthProfileController(ref.watch(authServiceProvider)),
    );

class AuthProfileController extends StateNotifier<UserProfile?> {
  final AuthService _service;

  AuthProfileController(this._service) : super(null) {
    _load();
  }

  Future<void> _load() async {
    state = await _service.getProfile();
  }

  Future<void> sendOtp(String email) => _service.sendOtp(email);

  Future<UserProfile> verifyOtp(String email, String otp) async {
    final profile = await _service.verifyOtp(email, otp);
    state = profile;
    return profile;
  }

  Future<void> resendOtp(String email) => _service.resendOtp(email);

  Future<void> saveProfile(UserProfile profile) async {
    state = await _service.saveProfile(profile);
  }

  Future<void> logout() async {
    await _service.logout();
    state = null;
  }
}
