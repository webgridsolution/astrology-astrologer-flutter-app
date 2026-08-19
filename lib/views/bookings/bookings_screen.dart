import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/booking_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/booking_card.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();
    const tabs = ['All', 'Upcoming', 'Completed', 'Cancelled'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Bookings')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final selected = c.tab == tabs[i];
                return ChoiceChip(
                  label: Text(tabs[i]),
                  selected: selected,
                  onSelected: (_) => c.setTab(tabs[i]),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: Colors.white,
                );
              },
            ),
          ),
          Expanded(
            child: c.filtered.isEmpty
                ? const Center(child: Text('No bookings in this tab'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: c.filtered.length,
                    itemBuilder: (_, i) {
                      final b = c.filtered[i];
                      return BookingCard(
                        booking: b,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.bookingDetails,
                          arguments: b.id,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
