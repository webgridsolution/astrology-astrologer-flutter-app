import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/soft_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final a = context.watch<AuthController>().astrologer;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          SoftCard(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(radius: 52, backgroundImage: AssetImage(a.image)),
                    Positioned(
                      right: 0,
                      bottom: 4,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: a.online ? AppColors.online : AppColors.offline,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(a.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    if (a.verified) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.verified, color: AppColors.primary, size: 18),
                    ],
                  ],
                ),
                Text(a.title, style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _stat('${a.experienceYears}+', 'Years Exp.'),
                    _stat('${a.rating}', 'Rating'),
                    _stat('${a.clients}', 'Clients'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About Me', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(a.about, style: const TextStyle(height: 1.45, color: AppColors.textDark)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Specializations', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: a.specializations
                      .map((s) => Chip(
                            label: Text(s),
                            backgroundColor: AppColors.lavender,
                            side: BorderSide.none,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                Text('Languages: ${a.languages.join(', ')}',
                    style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 4),
                Text('Mobile: ${a.mobile}', style: const TextStyle(color: AppColors.textMuted)),
                Text('Email: ${a.email}', style: const TextStyle(color: AppColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Edit Profile',
            onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
          ),
          const SizedBox(height: 10),
          AppButton(
            label: 'Verification / KYC',
            filled: false,
            onTap: () => Navigator.pushNamed(context, AppRoutes.kyc),
          ),
        ],
      ),
    );
  }

  Widget _stat(String v, String l) {
    return Column(
      children: [
        Text(v, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.primary)),
        Text(l, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      ],
    );
  }
}
