import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/message_enums.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(
      {required this.message, required this.isMe, required this.messageEnum});
}

final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);
