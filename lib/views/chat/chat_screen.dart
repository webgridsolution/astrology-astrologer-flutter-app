import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/call_controller.dart';
import '../../controllers/chat_controller.dart';
import '../../services/mock_data_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String clientId;
  const ChatScreen({super.key, required this.clientId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = MockDataService.instance;
    final thread = data.threadForClient(widget.clientId);
    final chat = context.watch<ChatController>();
    final messages = chat.messagesFor(thread.id);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.clientDetails, arguments: widget.clientId),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(thread.clientImage)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(thread.clientName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(thread.online ? 'Online' : 'Last seen recently',
                      style: TextStyle(
                          fontSize: 11,
                          color: thread.online ? AppColors.success : AppColors.textMuted)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () {
              context.read<CallController>().startOutgoing(
                    kind: CallKind.audio,
                    clientId: widget.clientId,
                    clientName: thread.clientName,
                    clientImage: thread.clientImage,
                  );
              Navigator.pushNamed(context, AppRoutes.audioCall, arguments: {'clientId': widget.clientId});
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {
              context.read<CallController>().startOutgoing(
                    kind: CallKind.video,
                    clientId: widget.clientId,
                    clientName: thread.clientName,
                    clientImage: thread.clientImage,
                  );
              Navigator.pushNamed(context, AppRoutes.videoCall, arguments: {'clientId': widget.clientId});
            },
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'kundli') {
                Navigator.pushNamed(context, AppRoutes.clientKundli, arguments: widget.clientId);
              } else if (v == 'end') {
                Navigator.pushNamed(context, AppRoutes.sessionSummary, arguments: {
                  'clientId': widget.clientId,
                  'clientName': thread.clientName,
                  'type': 'Chat Session',
                  'duration': 28,
                  'amount': 387.0,
                });
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'kundli', child: Text('View Kundli')),
              PopupMenuItem(value: 'end', child: Text('End Session')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              itemCount: messages.length,
              itemBuilder: (_, i) => ChatBubble(message: messages[i]),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions_outlined)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file)),
                  Expanded(
                    child: TextField(
                      controller: _input,
                      decoration: const InputDecoration(
                        hintText: 'Type a message…',
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                      onPressed: () {
                        chat.send(thread.id, _input.text);
                        _input.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
