import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/call_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final call = context.watch<CallController>();
    final me = context.watch<AuthController>().astrologer;

    if (call.phase == CallPhase.ended) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.sessionSummary, arguments: {
          'clientId': call.clientId,
          'clientName': call.clientName,
          'type': 'Video Call',
          'duration': (call.seconds / 60).ceil().clamp(1, 99),
          'amount': 387.0,
        });
      });
    }

    final status = call.phase == CallPhase.connected
        ? call.timerLabel
        : call.phase == CallPhase.calling
            ? 'Calling…'
            : call.phase == CallPhase.connecting
                ? 'Connecting…'
                : 'Video Call';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(call.clientImage, fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.transparent, Colors.black87],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Text(call.clientName,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                Text(status, style: const TextStyle(color: Colors.white70)),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(me.image, width: 92, height: 124, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _btn(Icons.mic_off_outlined, call.muted, call.toggleMute),
                    _btn(Icons.videocam_outlined, !call.cameraOn, call.toggleCamera),
                    _btn(Icons.volume_up_outlined, call.speaker, call.toggleSpeaker),
                    _btn(Icons.more_horiz, false, () {}),
                  ],
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: call.end,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: active ? Colors.white : Colors.white24,
        child: Icon(icon, color: active ? Colors.black : Colors.white),
      ),
    );
  }
}
