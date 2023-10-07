import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatify/features/chat/widgets/video_player.dart';
import 'package:flutter/material.dart';

import '../../../common/enums/message_enums.dart';

// ignore: must_be_immutable
class MessageBox extends StatelessWidget {
  final String message;
  final MessageEnum messageEnum;
  MessageBox({super.key, required this.message, required this.messageEnum});

  bool isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    switch (messageEnum) {
      case MessageEnum.text:
        return Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        );

      case MessageEnum.video:
        return VideoPlayer(
          videoUrl: message,
        );

      case MessageEnum.image:
        return CachedNetworkImage(
          imageUrl: message,
        );

      case MessageEnum.gif:
        return CachedNetworkImage(
          imageUrl: message,
        );

      case MessageEnum.audio:
        return StatefulBuilder(
          builder: (context, setState) => IconButton(
            constraints: const BoxConstraints(minWidth: 100),
            onPressed: () async {
              if (isPlaying) {
                await _audioPlayer.pause();
              } else {
                await _audioPlayer.play(UrlSource(message));
              }
              setState(() {
                isPlaying = !isPlaying;
              });
            },
            icon: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 30,
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
