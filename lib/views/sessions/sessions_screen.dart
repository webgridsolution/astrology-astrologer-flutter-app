import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/call_controller.dart';
import '../../models/booking_model.dart';
import '../../models/session_model.dart';
import '../../services/mock_data_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/soft_card.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessions = MockDataService.instance.sessions;
    final upcoming = sessions.where((s) => s.state == SessionState.upcoming).toList();
    final history = sessions.where((s) => s.state != SessionState.upcoming).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.primary,
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Active'), Tab(text: 'History')],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _list(context, upcoming, upcoming: true),
          _active(context),
          _list(context, history, upcoming: false),
        ],
      ),
    );
  }

  Widget _active(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SoftCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 36, backgroundImage: AssetImage(AppAssets.aman)),
            const SizedBox(height: 10),
            const Text('Aman Verma', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const Text('Chat Session · 00:12:40', style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 16),
            AppButton(
              label: 'Open Chat',
              onTap: () => Navigator.pushNamed(context, AppRoutes.chat, arguments: 'c1'),
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'End Session',
              color: AppColors.danger,
              onTap: () => Navigator.pushNamed(context, AppRoutes.sessionSummary, arguments: {
                'clientId': 'c1',
                'clientName': 'Aman Verma',
                'type': 'Chat Session',
                'duration': 13,
                'amount': 297.0,
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context, List sessions, {required bool upcoming}) {
    if (sessions.isEmpty) return const Center(child: Text('No sessions'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (_, i) {
        final s = sessions[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage(s.clientImage)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.clientName, style: const TextStyle(fontWeight: FontWeight.w700)),
                          Text(
                            '${s.type.name[0].toUpperCase()}${s.type.name.substring(1)} Consultation',
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Text('₹${s.amount.toInt()}',
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${DateFormat('d MMM yyyy').format(s.dateTime)}  ·  ${DateFormat('hh:mm a').format(s.dateTime)}  ·  ${s.durationMinutes} Minutes',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
                if (upcoming) ...[
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Start Session',
                    height: 46,
                    onTap: () {
                      if (s.type == ConsultationType.audio) {
                        context.read<CallController>().startOutgoing(
                              kind: CallKind.audio,
                              clientId: s.clientId,
                              clientName: s.clientName,
                              clientImage: s.clientImage,
                            );
                        Navigator.pushNamed(context, AppRoutes.audioCall);
                      } else if (s.type == ConsultationType.video) {
                        context.read<CallController>().startOutgoing(
                              kind: CallKind.video,
                              clientId: s.clientId,
                              clientName: s.clientName,
                              clientImage: s.clientImage,
                            );
                        Navigator.pushNamed(context, AppRoutes.videoCall);
                      } else {
                        Navigator.pushNamed(context, AppRoutes.chat, arguments: s.clientId);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
