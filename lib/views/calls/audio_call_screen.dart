import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/call_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final call = context.watch<CallController>();
    String status;
    switch (call.phase) {
      case CallPhase.calling:
        status = 'Calling…';
        break;
      case CallPhase.connecting:
        status = 'Connecting…';
        break;
      case CallPhase.connected:
        status = 'Connected';
        break;
      case CallPhase.ended:
        status = 'Call ended';
        break;
      default:
        status = 'Audio Call';
    }

    if (call.phase == CallPhase.ended) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.sessionSummary, arguments: {
          'clientId': call.clientId,
          'clientName': call.clientName,
          'type': 'Audio Call',
          'duration': (call.seconds / 60).ceil().clamp(1, 99),
          'amount': 387.0,
        });
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F0FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Text(call.clientName, style: const TextStyle(fontSize: 16)),
            Text(call.phase == CallPhase.connected ? call.timerLabel : status,
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ],
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          CircleAvatar(radius: 78, backgroundImage: AssetImage(call.clientImage)),
          const SizedBox(height: 18),
          Text(call.clientName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(status, style: const TextStyle(color: AppColors.textMuted)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ctrl(Icons.mic_off_outlined, 'Mute', call.muted, call.toggleMute),
              _ctrl(Icons.volume_up_outlined, 'Speaker', call.speaker, call.toggleSpeaker),
              _ctrl(Icons.dialpad, 'Keypad', false, () {}),
              _ctrl(Icons.more_horiz, 'More', false, () {}),
            ],
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: call.end,
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
              child: const Icon(Icons.call_end, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _ctrl(IconData icon, String label, bool active, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: active ? AppColors.primary : Colors.white,
            child: Icon(icon, color: active ? Colors.white : AppColors.textDark),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}
