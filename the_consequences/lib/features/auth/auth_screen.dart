import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_widgets.dart';

import 'auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final email = TextEditingController();
  final code = TextEditingController();
  bool codeSent = false;
  bool loading = false;
  int cooldown = 0;
  Timer? timer;
  String? error;

  @override
  void dispose() {
    email.dispose();
    code.dispose();
    timer?.cancel();
    super.dispose();
  }

  bool get validEmail =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.text.trim());

  void startCooldown() {
    timer?.cancel();
    setState(() => cooldown = 30);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => cooldown = cooldown > 0 ? cooldown - 1 : 0);
      if (cooldown == 0) timer?.cancel();
    });
  }

  Future<void> sendCode({bool resend = false}) async {
    if (!validEmail) {
      setState(() => error = 'Enter a valid email address.');
      return;
    }
    setState(() {
      loading = true;
      error = null;
    });
    try {
      if (resend) {
        await ref
            .read(authProfileProvider.notifier)
            .resendOtp(email.text.trim());
      } else {
        await ref.read(authProfileProvider.notifier).sendOtp(email.text.trim());
      }
      if (mounted) {
        setState(() => codeSent = true);
        startCooldown();
      }
    } catch (e) {
      if (mounted) setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> verify() async {
    if (code.text.trim().length != 6) {
      setState(() => error = 'Enter the six-digit verification code.');
      return;
    }
    setState(() {
      loading = true;
      error = null;
    });
    try {
      await ref
          .read(authProfileProvider.notifier)
          .verifyOtp(email.text.trim(), code.text.trim());
      if (mounted) context.go('/profile/setup');
    } catch (e) {
      if (mounted) {
        setState(() {
          error = e
              .toString()
              .replaceFirst('Bad state: ', '')
              .replaceFirst('StateError: ', '');
        });
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    child: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.bolt_rounded,
                size: 56,
                color: Color(0xFF8057FF),
              ),
              const SizedBox(height: 16),
              Text(
                codeSent ? 'Verify your email' : 'Welcome to The Consequence',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                codeSent
                    ? 'Enter the six-digit code sent to ${email.text.trim()}.\nDemo code: 123456'
                    : 'Sign in or create an account with a secure email code.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFA5A8BA)),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: email,
                enabled: !codeSent,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
              ),
              if (codeSent) ...[
                const SizedBox(height: 14),
                TextField(
                  controller: code,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  decoration: const InputDecoration(
                    labelText: 'Verification code',
                    prefixIcon: Icon(Icons.pin_rounded),
                  ),
                ),
              ],
              if (error != null) ...[
                const SizedBox(height: 10),
                Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
              const SizedBox(height: 18),
              if (loading)
                const LoadingWidget(label: 'Please wait...')
              else
                PrimaryButton(
                  label: codeSent ? 'VERIFY CODE' : 'SEND CODE',
                  icon: codeSent ? Icons.verified_rounded : Icons.send_rounded,
                  onPressed: codeSent ? verify : () => sendCode(),
                ),
              if (codeSent) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: cooldown == 0
                      ? () => sendCode(resend: true)
                      : null,
                  child: Text(
                    cooldown == 0
                        ? 'Resend code'
                        : 'Resend code in ${cooldown}s',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      codeSent = false;
                      code.clear();
                      error = null;
                    });
                  },
                  child: const Text('Change email'),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
