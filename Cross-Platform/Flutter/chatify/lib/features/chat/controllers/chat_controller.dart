// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/enums/message_enums.dart';
import '../../../common/providers/message_reply_provider.dart';
import '../../../models/chat_model.dart';
import '../../../models/group_model.dart';
import '../../../models/message_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getContactsList();
  }

  Stream<List<GroupModel>> chatGroups() {
    return chatRepository.getChatGroups();
  }

  Stream<List<MessageModel>> chatMessages(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  Stream<List<MessageModel>> groupChatMessages(String recieverUserId) {
    return chatRepository.getGroupChatStream(recieverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          ),
        );

    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required MessageEnum messageEnum,
    required bool isGroupChat,
  }) {
    final messageReply = ref.read(messageReplyProvider);
    ref
        .read(userDataAuthProvider)
        .whenData((value) => chatRepository.sendFileMessage(
              context: context,
              senderUser: value!,
              recieverUserId: recieverUserId,
              file: file,
              messageEnum: messageEnum,
              ref: ref,
              messageReply: messageReply,
              isGroupChat: isGroupChat,
            ));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGif({
    required BuildContext context,
    required String gif,
    required String recieverUserId,
    required bool isGroupChat,
  }) {
    int gifUrlUniqueIndex = gif.lastIndexOf('-') + 1;
    String uniqueGifUrl = gif.substring(gifUrlUniqueIndex);
    String gifUrl = 'https://i.giphy.com/media/$uniqueGifUrl/200.gif';

    final messageReply = ref.read(messageReplyProvider);

    ref.read(userDataAuthProvider).whenData((value) => chatRepository.sendGif(
        context: context,
        gif: gifUrl,
        recieverUserId: recieverUserId,
        senderUser: value!,
        messageReply: messageReply,
        isGroupChat: isGroupChat));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void setChatMessageSeen(
      {required BuildContext context,
      required String recieverId,
      required String messageId}) {
    chatRepository.setChatMessageSeen(
        context: context, recieverId: recieverId, messageId: messageId);
  }
}
