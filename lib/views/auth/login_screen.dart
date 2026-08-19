import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  void _send() {
    if (!_form.currentState!.validate()) return;
    context.read<AuthController>().startLogin('+91 ${_phone.text.trim()}');
    Navigator.pushNamed(context, AppRoutes.otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(color: Color(0x22000000), blurRadius: 16, offset: Offset(0, 8)),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(AppAssets.logo, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text('AstroChat',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                      const Text('Astrologer Partner App',
                          style: TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                const Text('Welcome Back, Astrologer',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.25)),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to manage your astrology practice.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 28),
                const Text('Mobile Number',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (v) {
                    if (v == null || v.length != 10) return 'Enter a valid 10-digit mobile number';
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: '98765 43210',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 12, right: 6),
                      child: Text('+91',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                ),
                const SizedBox(height: 22),
                AppButton(label: 'Send OTP', onTap: _send),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New astrologer? ', style: TextStyle(color: AppColors.textMuted)),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text('Register here',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(AppConstants.poweredBy,
                      style: TextStyle(
                          color: AppColors.textLight, fontSize: 11, letterSpacing: 1.2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
