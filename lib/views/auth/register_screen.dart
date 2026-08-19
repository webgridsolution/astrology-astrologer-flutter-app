import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _experience = TextEditingController();
  final _languages = TextEditingController(text: 'Hindi, English');
  final _specializations = TextEditingController(text: 'Vedic Astrology, Kundli, Tarot');
  final _about = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _email.dispose();
    _experience.dispose();
    _languages.dispose();
    _specializations.dispose();
    _about.dispose();
    super.dispose();
  }

  void _next() {
    if (!_form.currentState!.validate()) return;
    context.read<AuthController>().startRegister({
      'name': _name.text.trim(),
      'mobile': '+91 ${_mobile.text.trim()}',
      'email': _email.text.trim(),
      'experience': _experience.text.trim(),
      'languages': _languages.text.trim(),
      'specializations': _specializations.text.trim(),
      'about': _about.text.trim(),
    });
    Navigator.pushNamed(context, AppRoutes.otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Astrologer Registration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create your partner profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text(
                'Fill in your details. We will verify with OTP and save them to your panel.',
                style: TextStyle(color: AppColors.textMuted),
              ),
              const SizedBox(height: 22),
              AppTextField(
                label: 'Full Name',
                hint: 'Dr. Meera Sharma',
                controller: _name,
                prefix: Icons.person_outline,
                validator: (v) => (v == null || v.trim().length < 3) ? 'Enter your full name' : null,
              ),
              const SizedBox(height: 14),
              const Text('Mobile Number',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mobile,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (v) => (v == null || v.length != 10) ? 'Enter 10-digit number' : null,
                decoration: const InputDecoration(
                  hintText: '98765 10001',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12, right: 6),
                    child: Text('+91', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                ),
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Email',
                hint: 'you@astrochat.app',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                prefix: Icons.mail_outline,
                validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Years of Experience',
                hint: '8',
                controller: _experience,
                keyboardType: TextInputType.number,
                prefix: Icons.workspace_premium_outlined,
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Languages',
                hint: 'Hindi, English, Sanskrit',
                controller: _languages,
                prefix: Icons.translate,
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Specializations',
                hint: 'Vedic Astrology, Tarot, Numerology',
                controller: _specializations,
                prefix: Icons.auto_awesome,
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'About Me',
                hint: 'Share your practice, lineage and approach…',
                controller: _about,
                maxLines: 4,
                validator: (v) => (v == null || v.trim().length < 12) ? 'Write a short bio' : null,
              ),
              const SizedBox(height: 24),
              AppButton(label: 'Continue & Verify OTP', onTap: _next),
              const SizedBox(height: 16),
              const Center(
                child: Text(AppConstants.poweredBy,
                    style: TextStyle(color: AppColors.textLight, fontSize: 11, letterSpacing: 1.1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
