import 'package:flutter/material.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/otp_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/availability/availability_screen.dart';
import '../views/bookings/booking_details_screen.dart';
import '../views/calls/audio_call_screen.dart';
import '../views/calls/incoming_call_screen.dart';
import '../views/chat/chat_screen.dart';
import '../views/clients/client_details_screen.dart';
import '../views/clients/client_kundli_screen.dart';
import '../views/clients/clients_screen.dart';
import '../views/earnings/payouts_screen.dart';
import '../views/notifications/notifications_screen.dart';
import '../views/profile/edit_profile_screen.dart';
import '../views/profile/kyc_screen.dart';
import '../views/profile/profile_screen.dart';
import '../views/reviews/reviews_screen.dart';
import '../views/services/service_form_screen.dart';
import '../views/services/services_screen.dart';
import '../views/sessions/session_summary_screen.dart';
import '../views/sessions/sessions_screen.dart';
import '../views/settings/help_screen.dart';
import '../views/settings/settings_screen.dart';
import '../views/shell/main_shell.dart';
import '../views/splash/splash_screen.dart';
import '../views/video_call/video_call_screen.dart';
import 'constants.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.splash:
        return _p(const SplashScreen());
      case AppRoutes.login:
        return _p(const LoginScreen());
      case AppRoutes.register:
        return _p(const RegisterScreen());
      case AppRoutes.otp:
        return _p(const OtpScreen());
      case AppRoutes.dashboard:
        return _p(const MainShell());
      case AppRoutes.bookings:
        return _p(const MainShell(initialIndex: 1));
      case AppRoutes.bookingDetails:
        return _p(BookingDetailsScreen(bookingId: args as String));
      case AppRoutes.chatList:
        return _p(const MainShell(initialIndex: 2));
      case AppRoutes.chat:
        return _p(ChatScreen(clientId: args as String));
      case AppRoutes.audioCall:
        return _p(const AudioCallScreen());
      case AppRoutes.videoCall:
        return _p(const VideoCallScreen());
      case AppRoutes.incomingCall:
        return _p(const IncomingCallScreen());
      case AppRoutes.sessions:
        return _p(const SessionsScreen());
      case AppRoutes.sessionSummary:
        return _p(SessionSummaryScreen(args: (args as Map<String, dynamic>?) ?? {}));
      case AppRoutes.services:
        return _p(const ServicesScreen());
      case AppRoutes.addService:
        return _p(const ServiceFormScreen());
      case AppRoutes.editService:
        return _p(ServiceFormScreen(serviceId: args as String?));
      case AppRoutes.profile:
        return _p(const ProfileScreen());
      case AppRoutes.editProfile:
        return _p(const EditProfileScreen());
      case AppRoutes.kyc:
        return _p(const KycScreen());
      case AppRoutes.earnings:
        return _p(const MainShell(initialIndex: 3));
      case AppRoutes.payouts:
        return _p(const PayoutsScreen());
      case AppRoutes.reviews:
        return _p(const ReviewsScreen());
      case AppRoutes.availability:
        return _p(const AvailabilityScreen());
      case AppRoutes.notifications:
        return _p(const NotificationsScreen());
      case AppRoutes.clients:
        return _p(const ClientsScreen());
      case AppRoutes.clientDetails:
        return _p(ClientDetailsScreen(clientId: args as String));
      case AppRoutes.clientKundli:
        return _p(ClientKundliScreen(clientId: args as String));
      case AppRoutes.settings:
        return _p(const SettingsScreen());
      case AppRoutes.help:
        return _p(const HelpScreen());
      case AppRoutes.privacy:
        return _p(const SimpleInfoScreen(
          title: 'Privacy Policy',
          body:
              'AstroChat collects only the data needed to operate consultations, payouts and verification. Private astrologer notes are never shared with customers.',
        ));
      case AppRoutes.terms:
        return _p(const SimpleInfoScreen(
          title: 'Terms & Conditions',
          body:
              'By using the AstroChat Astrologer Partner App you agree to provide genuine consultations, honour accepted bookings and follow platform payout policies.',
        ));
      case AppRoutes.about:
        return _p(const AboutScreen());
      case AppRoutes.notificationSettings:
        return _p(const NotificationSettingsScreen());
      default:
        return _p(const SplashScreen());
    }
  }

  static MaterialPageRoute _p(Widget child) => MaterialPageRoute(builder: (_) => child);
}
