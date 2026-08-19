import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const AppBottomNav({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem(Icons.home_outlined, Icons.home_rounded, 'Home'),
      _NavItem(Icons.calendar_today_outlined, Icons.calendar_today, 'Bookings'),
      _NavItem(Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
      _NavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Earnings'),
      _NavItem(Icons.grid_view_outlined, Icons.grid_view_rounded, 'More'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Row(
            children: List.generate(items.length, (i) {
              final selected = i == index;
              final item = items[i];
              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => onChanged(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          selected ? item.active : item.icon,
                          color: selected ? AppColors.primary : AppColors.textLight,
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                            color: selected ? AppColors.primary : AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData active;
  final String label;
  _NavItem(this.icon, this.active, this.label);
}
