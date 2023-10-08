import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/enums/message_enums.dart';
import '../../../common/providers/message_reply_provider.dart';
import '../../../common/widgets/loader.dart';
import '../../../models/message_model.dart';
import '../controllers/chat_controller.dart';
import 'message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const ChatList(this.recieverUserId, this.isGroupChat, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController _messageController = ScrollController();

  void onMessageReply({
    required String message,
    required bool isMe,
    required MessageEnum messageEnum,
  }) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message: message,
            isMe: isMe,
            messageEnum: messageEnum,
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      stream: widget.isGroupChat
          ? ref
              .read(chatControllerProvider)
              .groupChatMessages(widget.recieverUserId)
          : ref
              .read(chatControllerProvider)
              .chatMessages(widget.recieverUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        SchedulerBinding.instance.addPostFrameCallback((_) {
          _messageController
              .jumpTo(_messageController.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: _messageController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final messages = snapshot.data![index];

            if (!messages.isSeen &&
                messages.recieverId == FirebaseAuth.instance.currentUser!.uid) {
              ref.read(chatControllerProvider).setChatMessageSeen(
                    context: context,
                    recieverId: widget.recieverUserId,
                    messageId: messages.messageId,
                  );
            }

            return MessageCard(
              message: messages.text,
              date: DateFormat.Hm().format(messages.timeSent),
              isMe: messages.senderId == FirebaseAuth.instance.currentUser!.uid
                  ? "true"
                  : "false",
              messageEnum: messages.type,
              repliedMessageType: messages.repliedMessageType,
              repliedText: messages.repliedMessage,
              userName: messages.repliedTo,
              onSwipe: () => onMessageReply(
                message: messages.text,
                isMe:
                    messages.senderId == FirebaseAuth.instance.currentUser!.uid
                        ? true
                        : false,
                messageEnum: messages.type,
              ),
              isSeen: messages.isSeen,
            );
          },
        );
      },
    );
  }
}
