import 'package:flutter/material.dart';
import '../chat/chat_list_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../bookings/bookings_screen.dart';
import '../earnings/earnings_screen.dart';
import '../more/more_screen.dart';
import '../../widgets/bottom_nav_bar.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const DashboardScreen(),
      const BookingsScreen(),
      const ChatListScreen(),
      const EarningsScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: AppBottomNav(
        index: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}
