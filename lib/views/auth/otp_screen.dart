import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _digits = List.generate(6, (_) => TextEditingController());
  final _nodes = List.generate(6, (_) => FocusNode());
  int _seconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _digits) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _code => _digits.map((e) => e.text).join();

  Future<void> _verify() async {
    final auth = context.read<AuthController>();
    final ok = await auth.verifyOtp(_code);
    if (!mounted) return;
    if (ok) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? 'Invalid OTP. Please try again.'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pending = context.watch<AuthController>().pending;
    final mobile = pending?.mobile ?? 'your number';

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Verify Your Number',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'Enter the 6-digit OTP sent to $mobile.\nDemo OTP: ${AppConstants.mockOtp}',
              style: const TextStyle(color: AppColors.textMuted, height: 1.45),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 48,
                  child: TextField(
                    controller: _digits[i],
                    focusNode: _nodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onChanged: (v) {
                      if (v.isNotEmpty && i < 5) _nodes[i + 1].requestFocus();
                      if (v.isEmpty && i > 0) _nodes[i - 1].requestFocus();
                      if (_code.length == 6) _verify();
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 22),
            AppButton(label: 'Verify & Continue', onTap: _verify),
            const SizedBox(height: 16),
            Center(
              child: _seconds > 0
                  ? Text('Resend OTP in 00:${_seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: AppColors.textMuted))
                  : TextButton(
                      onPressed: () {
                        for (final c in _digits) {
                          c.clear();
                        }
                        _nodes.first.requestFocus();
                        _startTimer();
                      },
                      child: const Text('Resend OTP'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
