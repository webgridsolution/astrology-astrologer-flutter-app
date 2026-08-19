import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController name;
  late final TextEditingController mobile;
  late final TextEditingController email;
  late final TextEditingController about;
  late final TextEditingController exp;
  late final TextEditingController langs;
  late final TextEditingController specs;

  @override
  void initState() {
    super.initState();
    final a = context.read<AuthController>().astrologer;
    name = TextEditingController(text: a.name);
    mobile = TextEditingController(text: a.mobile);
    email = TextEditingController(text: a.email);
    about = TextEditingController(text: a.about);
    exp = TextEditingController(text: '${a.experienceYears}');
    langs = TextEditingController(text: a.languages.join(', '));
    specs = TextEditingController(text: a.specializations.join(', '));
  }

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    email.dispose();
    about.dispose();
    exp.dispose();
    langs.dispose();
    specs.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await context.read<AuthController>().updateProfile(
          name: name.text.trim(),
          mobile: mobile.text.trim(),
          email: email.text.trim(),
          about: about.text.trim(),
          experience: exp.text.trim(),
          languages: langs.text.trim(),
          specializations: specs.text.trim(),
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(label: 'Full Name', controller: name),
          const SizedBox(height: 12),
          AppTextField(label: 'Mobile Number', controller: mobile),
          const SizedBox(height: 12),
          AppTextField(label: 'Email', controller: email),
          const SizedBox(height: 12),
          AppTextField(label: 'Experience (years)', controller: exp, keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          AppTextField(label: 'Languages', controller: langs),
          const SizedBox(height: 12),
          AppTextField(label: 'Specializations', controller: specs),
          const SizedBox(height: 12),
          AppTextField(label: 'About Me', controller: about, maxLines: 5),
          const SizedBox(height: 20),
          AppButton(label: 'Save Changes', onTap: _save),
        ],
      ),
    );
  }
}
