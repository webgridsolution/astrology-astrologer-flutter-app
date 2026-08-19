import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/call_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/notification_controller.dart';
import '../../models/booking_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/earnings_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/soft_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greet() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final dash = context.watch<DashboardController>();
    final notes = context.watch<NotificationController>();
    final a = auth.astrologer;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(AppAssets.logo, width: 40, height: 40, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AstroChat',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                          Text('Astrologer Panel',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Demo incoming call',
                      onPressed: () {
                        context.read<CallController>().startIncoming(
                              kind: CallKind.video,
                              clientId: 'c1',
                              clientName: 'Aman Verma',
                              clientImage: AppAssets.aman,
                            );
                        Navigator.pushNamed(context, AppRoutes.incomingCall);
                      },
                      icon: const Icon(Icons.ring_volume_outlined),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
                          icon: const Icon(Icons.notifications_none_rounded),
                        ),
                        if (notes.unreadCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: AppColors.danger, shape: BoxShape.circle),
                              child: Text('${notes.unreadCount}',
                                  style: const TextStyle(color: Colors.white, fontSize: 9)),
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => auth.setOnline(!a.online),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: a.online ? AppColors.successSoft : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: a.online ? AppColors.online : AppColors.offline,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(a.online ? 'Online' : 'Offline',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: a.online ? AppColors.success : AppColors.textMuted,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                      child: CircleAvatar(radius: 18, backgroundImage: AssetImage(a.image)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_greet()}, ${a.name} ✨',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    const Text("Here's what's happening with your practice today.",
                        style: TextStyle(color: AppColors.textMuted)),
                    if (!a.online) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.goldSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'You are currently offline. New consultation requests are paused.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: EarningsCard(
                            title: 'Total Bookings',
                            value: '${dash.totalBookings}',
                            subtitle: 'Today',
                            icon: Icons.calendar_month_outlined,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: EarningsCard(
                            title: 'Upcoming Sessions',
                            value: '${dash.upcomingSessions}',
                            subtitle: 'Today',
                            icon: Icons.schedule,
                            tint: const Color(0xFF7C3AED),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: EarningsCard(
                            title: 'Total Earnings',
                            value: '₹${dash.totalEarnings.toInt()}',
                            subtitle: 'This Month',
                            icon: Icons.account_balance_wallet_outlined,
                            tint: AppColors.gold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: EarningsCard(
                            title: 'Total Clients',
                            value: '${dash.totalClients}',
                            subtitle: 'All Time',
                            icon: Icons.groups_outlined,
                            tint: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SoftCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Earnings Overview',
                                    style: TextStyle(fontWeight: FontWeight.w700)),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dash.earningsFilter,
                                  items: const [
                                    'Today',
                                    'This Week',
                                    'This Month',
                                    'This Year',
                                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  onChanged: (v) {
                                    if (v != null) dash.setFilter(v);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 180,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  getDrawingHorizontalLine: (_) =>
                                      const FlLine(color: AppColors.border, strokeWidth: 1),
                                ),
                                titlesData: FlTitlesData(
                                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 36,
                                      getTitlesWidget: (v, _) => Text('₹${(v / 1000).toStringAsFixed(0)}k',
                                          style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: (v, _) {
                                        const labels = ['1 Aug', '5 Aug', '10 Aug', '15 Aug', '20 Aug', '25 Aug', '30 Aug'];
                                        final i = v.toInt();
                                        if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(labels[i],
                                              style: const TextStyle(fontSize: 9, color: AppColors.textLight)),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                minY: 0,
                                maxY: 8000,
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    color: AppColors.primary,
                                    barWidth: 3,
                                    dotData: const FlDotData(show: true),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: AppColors.primary.withOpacity(0.12),
                                    ),
                                    spots: const [
                                      FlSpot(0, 1500),
                                      FlSpot(1, 2400),
                                      FlSpot(2, 3200),
                                      FlSpot(3, 4850),
                                      FlSpot(4, 4100),
                                      FlSpot(5, 5800),
                                      FlSpot(6, 6700),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    SoftCard(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Bookings Overview',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: 130,
                                height: 130,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    PieChart(
                                      PieChartData(
                                        sectionsSpace: 3,
                                        centerSpaceRadius: 38,
                                        sections: [
                                          PieChartSectionData(
                                              value: dash.completed.toDouble(),
                                              color: AppColors.primary,
                                              radius: 18,
                                              showTitle: false),
                                          PieChartSectionData(
                                              value: dash.upcomingSessions.toDouble(),
                                              color: const Color(0xFFE879F9),
                                              radius: 18,
                                              showTitle: false),
                                          PieChartSectionData(
                                              value: dash.cancelled.toDouble(),
                                              color: AppColors.gold,
                                              radius: 18,
                                              showTitle: false),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${dash.totalBookings}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w800, fontSize: 20)),
                                        const Text('Total',
                                            style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  children: [
                                    _legend('Completed', dash.completed, AppColors.primary, dash.totalBookings),
                                    _legend('Upcoming', dash.upcomingSessions, const Color(0xFFE879F9), dash.totalBookings),
                                    _legend('Cancelled', dash.cancelled, AppColors.gold, dash.totalBookings),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SectionHeader(
                      title: "Today's Schedule",
                      action: 'View All',
                      onAction: () => Navigator.pushNamed(context, AppRoutes.sessions),
                    ),
                    ...dash.todaySchedule.map((b) => _scheduleTile(context, b)),
                    SectionHeader(
                      title: 'Recent Bookings',
                      action: 'View All',
                      onAction: () => Navigator.pushNamed(context, AppRoutes.bookings),
                    ),
                    ...dash.recentBookings.map((b) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(backgroundImage: AssetImage(b.clientImage)),
                          title: Text(b.clientName, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            '${DateFormat('d MMM, hh:mm a').format(b.dateTime)} · ${b.typeLabel}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                          trailing: const Chip(
                            label: Text('Upcoming', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                            backgroundColor: AppColors.primarySoft,
                            visualDensity: VisualDensity.compact,
                          ),
                          onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetails, arguments: b.id),
                        )),
                    const SizedBox(height: 8),
                    SoftCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Your Rating',
                                    style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                                const SizedBox(height: 4),
                                Text('${a.rating}',
                                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => const Icon(Icons.star_rounded, color: AppColors.gold, size: 18),
                                  ),
                                ),
                                Text('(${a.reviewCount} Reviews)',
                                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B6CFF), Color(0xFF6D4AFF)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Text('Profile Views',
                                    style: TextStyle(color: Colors.white70, fontSize: 11)),
                                Text('${a.profileViews}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
                                const Text('This month',
                                    style: TextStyle(color: Colors.white70, fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(String label, int value, Color color, int total) {
    final pct = total == 0 ? 0 : ((value / total) * 100).round();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Text('$value ($pct%)', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _scheduleTile(BuildContext context, BookingModel b) {
    IconData icon;
    switch (b.type) {
      case ConsultationType.audio:
        icon = Icons.call_outlined;
        break;
      case ConsultationType.video:
        icon = Icons.videocam_outlined;
        break;
      default:
        icon = Icons.chat_bubble_outline;
    }
    return SoftCard(
      onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetails, arguments: b.id),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.lavender, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 72,
            child: Text(DateFormat('hh:mm a').format(b.dateTime),
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(b.typeLabel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(b.clientName, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Upcoming',
                style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
