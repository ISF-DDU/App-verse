import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../common/enums/message_enums.dart';
import '../../../constants/colors.dart';
import 'message_box.dart';

class MessageCard extends StatefulWidget {
  final String isMe;
  final String message;
  final String date;
  final MessageEnum messageEnum;
  final VoidCallback onSwipe;
  final String repliedText;
  final String userName;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.isMe,
    required this.messageEnum,
    required this.onSwipe,
    required this.repliedText,
    required this.userName,
    required this.repliedMessageType,
    required this.isSeen,
  }) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    final isReplying = widget.repliedText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: widget.isMe == "true" ? widget.onSwipe : null,
      onRightSwipe: widget.isMe == "false" ? widget.onSwipe : null,
      child: Align(
        alignment: widget.isMe == "true"
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
            minWidth: 110,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: widget.isMe == 'true' ? messageColor : senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: widget.messageEnum == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          widget.userName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: MessageBox(
                            message: widget.repliedText,
                            messageEnum: widget.repliedMessageType,
                          ),
                        ),
                      ],
                      MessageBox(
                        message: widget.message,
                        messageEnum: widget.messageEnum,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: widget.isMe == 'true' ? 4 : 2,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        widget.date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        widget.isMe == "true"
                            ? widget.isSeen
                                ? Icons.done_all
                                : Icons.done
                            : null,
                        size: 20,
                        color: widget.isSeen ? Colors.red : Colors.white60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
