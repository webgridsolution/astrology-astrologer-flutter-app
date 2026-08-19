import 'package:flutter/material.dart';
import '../models/astrologer_model.dart';
import '../services/shared_preferences_service.dart';
import '../utils/constants.dart';

class PendingAuth {
  final String mobile;
  final bool isRegister;
  final Map<String, String> registerData;

  const PendingAuth({
    required this.mobile,
    this.isRegister = false,
    this.registerData = const {},
  });
}

class AuthController extends ChangeNotifier {
  final SharedPreferencesService prefs;
  AuthController(this.prefs);

  bool initialized = false;
  bool loggedIn = false;
  bool loading = false;
  String? error;
  PendingAuth? pending;

  AstrologerModel astrologer = const AstrologerModel(
    id: 'ast-1',
    name: AppConstants.defaultAstrologerName,
    mobile: '+91 98765 10001',
    email: 'meera@astrochat.app',
    title: AppConstants.defaultTitle,
    image: AppAssets.meera,
    about:
        'I am a Vedic astrologer with more than 8 years of experience in Vedic Astrology, Tarot, Kundli analysis and Numerology.',
    experienceYears: 8,
    rating: 4.9,
    reviewCount: 128,
    clients: 156,
    profileViews: 248,
    specializations: [
      'Vedic Astrology',
      'Kundli',
      'Tarot',
      'Numerology',
      'Love & Relationship',
      'Career Guidance',
    ],
    languages: ['Hindi', 'English', 'Sanskrit'],
  );

  Future<void> bootstrap() async {
    loggedIn = await prefs.isLoggedIn();
    if (loggedIn) {
      await _hydrate();
    }
    initialized = true;
    notifyListeners();
  }

  Future<void> _hydrate() async {
    final name = await prefs.getAstrologerName();
    final mobile = await prefs.getMobileNumber();
    final image = await prefs.getProfileImage();
    final email = await prefs.getEmail();
    final about = await prefs.getAbout();
    final exp = int.tryParse(await prefs.getExperience()) ?? 8;
    final langs = (await prefs.getLanguages())
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final specs = (await prefs.getSpecializations())
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final online = await prefs.getOnlineStatus();
    astrologer = astrologer.copyWith(
      name: name,
      mobile: mobile,
      email: email,
      image: image,
      about: about,
      experienceYears: exp,
      languages: langs.isEmpty ? astrologer.languages : langs,
      specializations: specs.isEmpty ? astrologer.specializations : specs,
      online: online,
    );
  }

  void startLogin(String mobile) {
    error = null;
    pending = PendingAuth(mobile: mobile, isRegister: false);
    notifyListeners();
  }

  void startRegister(Map<String, String> data) {
    error = null;
    pending = PendingAuth(
      mobile: data['mobile'] ?? '',
      isRegister: true,
      registerData: data,
    );
    notifyListeners();
  }

  Future<bool> verifyOtp(String otp) async {
    error = null;
    if (otp != AppConstants.mockOtp) {
      error = 'Invalid OTP. Please try again.';
      notifyListeners();
      return false;
    }
    final p = pending;
    if (p == null) {
      error = 'Session expired. Please start again.';
      notifyListeners();
      return false;
    }

    if (p.isRegister) {
      final d = p.registerData;
      await prefs.setLogin(
        name: d['name'] ?? AppConstants.defaultAstrologerName,
        mobile: p.mobile,
        email: d['email'],
        about: d['about'],
        experience: d['experience'],
        languages: d['languages'],
        specializations: d['specializations'],
        image: AppAssets.meera,
      );
    } else {
      await prefs.setLogin(
        name: astrologer.name,
        mobile: p.mobile,
        image: astrologer.image,
        email: astrologer.email,
        about: astrologer.about,
        experience: '${astrologer.experienceYears}',
        languages: astrologer.languages.join(', '),
        specializations: astrologer.specializations.join(', '),
      );
    }
    loggedIn = true;
    await _hydrate();
    notifyListeners();
    return true;
  }

  Future<void> updateProfile({
    required String name,
    required String mobile,
    required String email,
    required String about,
    required String experience,
    required String languages,
    required String specializations,
  }) async {
    await prefs.saveAstrologer(
      name: name,
      mobile: mobile,
      email: email,
      about: about,
      experience: experience,
      languages: languages,
      specializations: specializations,
    );
    await _hydrate();
    notifyListeners();
  }

  Future<void> setOnline(bool value) async {
    astrologer = astrologer.copyWith(online: value);
    await prefs.setOnlineStatus(value);
    notifyListeners();
  }

  Future<void> logout() async {
    await prefs.logout();
    loggedIn = false;
    pending = null;
    notifyListeners();
  }
}
