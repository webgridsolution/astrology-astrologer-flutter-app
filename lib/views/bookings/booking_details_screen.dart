import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/booking_controller.dart';
import '../../controllers/call_controller.dart';
import '../../models/booking_model.dart';
import '../../services/mock_data_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/soft_card.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;
  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final data = MockDataService.instance;
    final booking = data.bookingById(bookingId);
    if (booking == null) {
      return const Scaffold(body: Center(child: Text('Booking not found')));
    }
    final client = data.clientById(booking.clientId);
    final bc = context.watch<BookingController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Details')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          SoftCard(
            child: Column(
              children: [
                CircleAvatar(radius: 42, backgroundImage: AssetImage(booking.clientImage)),
                const SizedBox(height: 10),
                Text(booking.clientName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Text(client?.mobile ?? '', style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text(booking.typeLabel), backgroundColor: AppColors.lavender),
                    Chip(
                      label: Text(booking.statusLabel),
                      backgroundColor: AppColors.primarySoft,
                      labelStyle: const TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              children: [
                _row('Date', DateFormat('EEEE, d MMM yyyy').format(booking.dateTime)),
                _row('Time', DateFormat('hh:mm a').format(booking.dateTime)),
                _row('Duration', '${booking.durationMinutes} Minutes'),
                _row('Amount', '₹${booking.amount.toInt()}'),
                _row('Type', booking.typeLabel),
                _row('Status', booking.statusLabel),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (booking.status == BookingStatus.upcoming) ...[
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Accept',
                    onTap: () {
                      bc.accept(booking.id);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Booking accepted')));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    label: 'Reject',
                    filled: false,
                    color: AppColors.danger,
                    onTap: () {
                      bc.reject(booking.id);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (booking.type == ConsultationType.chat)
              AppButton(
                label: 'Start Chat',
                icon: Icons.chat_bubble_outline,
                onTap: () => Navigator.pushNamed(context, AppRoutes.chat, arguments: booking.clientId),
              ),
            if (booking.type == ConsultationType.audio)
              AppButton(
                label: 'Start Call',
                icon: Icons.call_outlined,
                onTap: () => _startCall(context, booking, CallKind.audio),
              ),
            if (booking.type == ConsultationType.video)
              AppButton(
                label: 'Start Video Call',
                icon: Icons.videocam_outlined,
                onTap: () => _startCall(context, booking, CallKind.video),
              ),
            if (booking.type == ConsultationType.kundli)
              AppButton(
                label: 'Open Client Kundli',
                icon: Icons.auto_awesome,
                onTap: () => Navigator.pushNamed(context, AppRoutes.clientKundli,
                    arguments: booking.clientId),
              ),
          ] else
            AppButton(
              label: 'View Client',
              filled: false,
              onTap: () => Navigator.pushNamed(context, AppRoutes.clientDetails,
                  arguments: booking.clientId),
            ),
          const SizedBox(height: 10),
          AppButton(
            label: 'Client Profile & Notes',
            filled: false,
            onTap: () => Navigator.pushNamed(context, AppRoutes.clientDetails,
                arguments: booking.clientId),
          ),
        ],
      ),
    );
  }

  void _startCall(BuildContext context, BookingModel booking, CallKind kind) {
    context.read<CallController>().startOutgoing(
          kind: kind,
          clientId: booking.clientId,
          clientName: booking.clientName,
          clientImage: booking.clientImage,
        );
    Navigator.pushNamed(
      context,
      kind == CallKind.video ? AppRoutes.videoCall : AppRoutes.audioCall,
      arguments: {'bookingId': booking.id, 'clientId': booking.clientId},
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(k, style: const TextStyle(color: AppColors.textMuted))),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
