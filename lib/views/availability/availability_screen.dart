import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/soft_card.dart';

class AvailabilityScreen extends StatelessWidget {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProfileController>();
    return Scaffold(
      appBar: AppBar(title: const Text('My Availability')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...List.generate(p.availability.length, (i) {
            final d = p.availability[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SoftCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(d.day, style: const TextStyle(fontWeight: FontWeight.w700))),
                        Switch.adaptive(
                          value: d.enabled,
                          activeColor: AppColors.primary,
                          onChanged: (v) => p.setDayEnabled(i, v),
                        ),
                      ],
                    ),
                    if (d.enabled)
                      Row(
                        children: [
                          Text(d.startTime, style: const TextStyle(color: AppColors.textMuted)),
                          const Text('  —  '),
                          Text(d.endTime, style: const TextStyle(color: AppColors.textMuted)),
                        ],
                      )
                    else
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Offline', style: TextStyle(color: AppColors.danger)),
                      ),
                  ],
                ),
              ),
            );
          }),
          AppButton(
            label: 'Save Availability',
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Availability saved')));
            },
          ),
        ],
      ),
    );
  }
}
