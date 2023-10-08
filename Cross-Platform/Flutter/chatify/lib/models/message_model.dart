// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:chatify/common/enums/message_enums.dart';

class MessageModel {
  final String senderId;
  final String recieverId;
  final String text;
  final DateTime timeSent;
  final bool isSeen;
  final MessageEnum type;
  final String messageId;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  MessageModel({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.timeSent,
    required this.isSeen,
    required this.type,
    required this.messageId,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'type': type.type,
      'messageId': messageId,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      recieverId: map['recieverId'] as String,
      text: map['text'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      isSeen: map['isSeen'] as bool,
      type: (map['type'] as String).toEnum(),
      messageId: map['messageId'] as String,
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
    );
  }

}
