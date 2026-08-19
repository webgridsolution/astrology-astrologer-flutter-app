import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class SharedPreferencesService {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw StateError('SharedPreferencesService not initialized');
    }
    return _prefs!;
  }

  Future<void> setLogin({
    required String name,
    required String mobile,
    String? image,
    String? email,
    String? about,
    String? experience,
    String? languages,
    String? specializations,
  }) async {
    await init();
    await prefs.setBool(AppConstants.prefsLoggedIn, true);
    await prefs.setString(AppConstants.prefsName, name);
    await prefs.setString(AppConstants.prefsMobile, mobile);
    if (image != null) await prefs.setString(AppConstants.prefsImage, image);
    if (email != null) await prefs.setString(AppConstants.prefsEmail, email);
    if (about != null) await prefs.setString(AppConstants.prefsAbout, about);
    if (experience != null) {
      await prefs.setString(AppConstants.prefsExperience, experience);
    }
    if (languages != null) {
      await prefs.setString(AppConstants.prefsLanguages, languages);
    }
    if (specializations != null) {
      await prefs.setString(AppConstants.prefsSpecializations, specializations);
    }
    await prefs.setBool(AppConstants.prefsRegistered, true);
  }

  Future<bool> isLoggedIn() async {
    await init();
    return prefs.getBool(AppConstants.prefsLoggedIn) ?? false;
  }

  Future<String> getAstrologerName() async {
    await init();
    return prefs.getString(AppConstants.prefsName) ??
        AppConstants.defaultAstrologerName;
  }

  Future<String> getMobileNumber() async {
    await init();
    return prefs.getString(AppConstants.prefsMobile) ?? '+91 98765 10001';
  }

  Future<String> getProfileImage() async {
    await init();
    return prefs.getString(AppConstants.prefsImage) ?? AppAssets.meera;
  }

  Future<String> getEmail() async {
    await init();
    return prefs.getString(AppConstants.prefsEmail) ?? 'meera@astrochat.app';
  }

  Future<String> getAbout() async {
    await init();
    return prefs.getString(AppConstants.prefsAbout) ??
        'I am a Vedic astrologer with more than 8 years of experience in Vedic Astrology, Tarot, Kundli analysis and Numerology.';
  }

  Future<String> getExperience() async {
    await init();
    return prefs.getString(AppConstants.prefsExperience) ?? '8';
  }

  Future<String> getLanguages() async {
    await init();
    return prefs.getString(AppConstants.prefsLanguages) ??
        'Hindi, English, Sanskrit';
  }

  Future<String> getSpecializations() async {
    await init();
    return prefs.getString(AppConstants.prefsSpecializations) ??
        'Vedic Astrology, Kundli, Tarot, Numerology, Love & Relationship, Career Guidance';
  }

  Future<void> setOnlineStatus(bool online) async {
    await init();
    await prefs.setBool(AppConstants.prefsOnline, online);
  }

  Future<bool> getOnlineStatus() async {
    await init();
    return prefs.getBool(AppConstants.prefsOnline) ?? true;
  }

  Future<void> saveAstrologer({
    String? name,
    String? mobile,
    String? image,
    String? email,
    String? about,
    String? experience,
    String? languages,
    String? specializations,
  }) async {
    await init();
    if (name != null) await prefs.setString(AppConstants.prefsName, name);
    if (mobile != null) await prefs.setString(AppConstants.prefsMobile, mobile);
    if (image != null) await prefs.setString(AppConstants.prefsImage, image);
    if (email != null) await prefs.setString(AppConstants.prefsEmail, email);
    if (about != null) await prefs.setString(AppConstants.prefsAbout, about);
    if (experience != null) {
      await prefs.setString(AppConstants.prefsExperience, experience);
    }
    if (languages != null) {
      await prefs.setString(AppConstants.prefsLanguages, languages);
    }
    if (specializations != null) {
      await prefs.setString(AppConstants.prefsSpecializations, specializations);
    }
  }

  Future<void> logout() async {
    await init();
    await prefs.setBool(AppConstants.prefsLoggedIn, false);
  }
}
