import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/chat_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<ChatController>();
    const tabs = ['All', 'Unread', 'Starred'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search clients…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune_rounded),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: tabs.map((t) {
                final selected = c.tab == t;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(t == 'Unread' ? 'Unread  ${c.data.threads.where((e) => e.unread > 0).length}' : t),
                    selected: selected,
                    onSelected: (_) => c.setTab(t),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: c.threads.length,
              itemBuilder: (_, i) {
                final t = c.threads[i];
                return ListTile(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.chat, arguments: t.clientId),
                  leading: Stack(
                    children: [
                      CircleAvatar(radius: 24, backgroundImage: AssetImage(t.clientImage)),
                      if (t.online)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.online,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(t.clientName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(t.lastMessage,
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textMuted)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(t.lastTime),
                        style: const TextStyle(fontSize: 11, color: AppColors.textLight),
                      ),
                      if (t.unread > 0) ...[
                        const SizedBox(height: 6),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.primary,
                          child: Text('${t.unread}',
                              style: const TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ],
                    ],
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
