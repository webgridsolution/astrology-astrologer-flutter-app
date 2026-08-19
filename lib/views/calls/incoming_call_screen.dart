import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/call_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class IncomingCallScreen extends StatelessWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final call = context.watch<CallController>();
    final isVideo = call.kind == CallKind.video;

    return Scaffold(
      backgroundColor: const Color(0xFF2A2154),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            Text(
              isVideo ? 'Incoming Video Call' : 'Incoming Audio Call',
              style: const TextStyle(color: Colors.white70, letterSpacing: 0.6),
            ),
            const SizedBox(height: 28),
            CircleAvatar(radius: 72, backgroundImage: AssetImage(call.clientImage)),
            const SizedBox(height: 18),
            Text(call.clientName,
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('AstroChat consultation', style: TextStyle(color: Colors.white54)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _round(Icons.call_end, 'Decline', AppColors.danger, () {
                    call.decline();
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (_) => false);
                  }),
                  _round(isVideo ? Icons.videocam : Icons.call, isVideo ? 'Accept Video' : 'Accept',
                      AppColors.success, () {
                    call.accept();
                    Navigator.pushReplacementNamed(
                      context,
                      isVideo ? AppRoutes.videoCall : AppRoutes.audioCall,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  Widget _round(IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(radius: 34, backgroundColor: color, child: Icon(icon, color: Colors.white, size: 28)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
