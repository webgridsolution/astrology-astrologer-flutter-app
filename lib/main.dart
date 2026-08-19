import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/booking_controller.dart';
import 'controllers/call_controller.dart';
import 'controllers/chat_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/earnings_controller.dart';
import 'controllers/notification_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/service_controller.dart';
import 'services/shared_preferences_service.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';
import 'utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final prefs = SharedPreferencesService();
  await prefs.init();

  runApp(AstroChatApp(prefs: prefs));
}

class AstroChatApp extends StatelessWidget {
  final SharedPreferencesService prefs;
  const AstroChatApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController(prefs)..bootstrap()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
        ChangeNotifierProvider(create: (_) => ChatController()),
        ChangeNotifierProvider(create: (_) => CallController()),
        ChangeNotifierProvider(create: (_) => ServiceController()),
        ChangeNotifierProvider(create: (_) => EarningsController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
      ],
      child: MaterialApp(
        title: 'AstroChat Astrologer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: RouteGenerator.generate,
      ),
    );
  }
}
