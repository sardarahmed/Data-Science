import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../data/models/profile.dart';

abstract interface class AuthService {
  Future<bool> get isAuthenticated;
  Future<void> sendOtp(String email);
  Future<UserProfile> verifyOtp(String email, String otp);
  Future<void> resendOtp(String email);
  Future<void> logout();
  Future<UserProfile?> getProfile();
  Future<UserProfile> saveProfile(UserProfile profile);
}

class DemoAuthService implements AuthService {
  static const demoOtp = '123456';
  static const profileKey = 'demo_profile';
  UserProfile? _profile;

  @override
  Future<bool> get isAuthenticated async => _profile != null;

  @override
  Future<void> sendOtp(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<UserProfile> verifyOtp(String email, String otp) async {
    if (otp != demoOtp) {
      throw StateError('Invalid code. Use 123456 in demo mode.');
    }
    _profile ??= UserProfile(
      id: 'demo-user',
      username: 'alex',
      displayName: 'Alex',
      email: email,
      bio: 'Making choices and facing consequences.',
      createdAt: DateTime.now(),
      totalMatches: 12,
      totalWins: 3,
      totalPoints: 1840,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      profileKey,
      '${_profile!.id}|${_profile!.username}|${_profile!.displayName}|${_profile!.email}|${_profile!.bio}|${_profile!.createdAt.toIso8601String()}|${_profile!.totalMatches}|${_profile!.totalWins}|${_profile!.totalPoints}',
    );
    return _profile!;
  }

  @override
  Future<void> resendOtp(String email) => sendOtp(email);

  @override
  Future<void> logout() async {
    _profile = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(profileKey);
  }

  @override
  Future<UserProfile?> getProfile() async {
    if (_profile != null) return _profile;
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(profileKey);
    if (value == null) return null;
    final parts = value.split('|');
    if (parts.length != 9) return null;
    _profile = UserProfile(
      id: parts[0],
      username: parts[1],
      displayName: parts[2],
      email: parts[3],
      bio: parts[4],
      createdAt: DateTime.tryParse(parts[5]) ?? DateTime.now(),
      totalMatches: int.tryParse(parts[6]) ?? 0,
      totalWins: int.tryParse(parts[7]) ?? 0,
      totalPoints: int.tryParse(parts[8]) ?? 0,
    );
    return _profile;
  }

  @override
  Future<UserProfile> saveProfile(UserProfile profile) async {
    _profile = profile;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      profileKey,
      '${profile.id}|${profile.username}|${profile.displayName}|${profile.email}|${profile.bio}|${profile.createdAt.toIso8601String()}|${profile.totalMatches}|${profile.totalWins}|${profile.totalPoints}',
    );
    return profile;
  }
}

class SupabaseAuthService implements AuthService {
  final supabase.SupabaseClient client;

  SupabaseAuthService(this.client);

  @override
  Future<bool> get isAuthenticated async => client.auth.currentUser != null;

  @override
  Future<void> sendOtp(String email) =>
      client.auth.signInWithOtp(email: email, shouldCreateUser: true);

  @override
  Future<void> resendOtp(String email) async {
    await client.auth.resend(email: email, type: supabase.OtpType.signup);
  }

  @override
  Future<UserProfile> verifyOtp(String email, String otp) async {
    await client.auth.verifyOTP(
      email: email,
      token: otp,
      type: supabase.OtpType.email,
    );
    final user = client.auth.currentUser;
    if (user == null) {
      throw StateError('Verification did not create a session.');
    }
    final profile = await getProfile();
    if (profile != null) {
      return profile;
    }
    throw StateError('Profile setup is required.');
  }

  @override
  Future<void> logout() => client.auth.signOut();

  @override
  Future<UserProfile?> getProfile() async {
    final user = client.auth.currentUser;
    if (user == null) return null;
    final row = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    if (row == null) return null;
    return UserProfile(
      id: row['id'] as String,
      username: row['username'] as String,
      displayName: row['display_name'] as String,
      email: user.email ?? '',
      avatarUrl: row['avatar_url'] as String?,
      bio: (row['bio'] as String?) ?? '',
      createdAt: DateTime.parse(row['created_at'] as String),
      totalMatches: (row['total_matches'] as num?)?.toInt() ?? 0,
      totalWins: (row['total_wins'] as num?)?.toInt() ?? 0,
      totalPoints: (row['total_points'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  Future<UserProfile> saveProfile(UserProfile profile) async {
    await client.from('profiles').upsert({
      'id': profile.id,
      'username': profile.username,
      'display_name': profile.displayName,
      'avatar_url': profile.avatarUrl,
      'bio': profile.bio,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
    return profile;
  }
}
