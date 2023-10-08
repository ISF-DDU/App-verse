// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/enums/message_enums.dart';
import '../../../common/providers/message_reply_provider.dart';
import '../../../common/utils/utils.dart';
import '../../../constants/colors.dart';
import '../controllers/chat_controller.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    required this.isGroupChat,
    required this.recieverUserId,
    super.key,
  });

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool showSendIcon = false;
  bool isRecorderInit = false;
  bool isRecording = false;
  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic is not allowed');
    }

    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (showSendIcon & _messageController.text.isNotEmpty) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
            widget.isGroupChat,
          );

      setState(() {
        _messageController.text = "";
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = "${tempDir.path}/flutter_sound.aac";
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFile(file: File(path), messageEnum: MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFile({
    required File file,
    required MessageEnum messageEnum,
  }) {
    ref.read(chatControllerProvider).sendFileMessage(
        context: context,
        file: file,
        recieverUserId: widget.recieverUserId,
        messageEnum: messageEnum,
        isGroupChat: widget.isGroupChat);
  }

  void selectImageFile() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFile(file: image, messageEnum: MessageEnum.image);
    }
  }

  void selectVideoFile() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFile(file: video, messageEnum: MessageEnum.video);
    }
  }

  void selectGif() async {
    GiphyGif? gif = await pickGif(context);
    if (gif != null) {
      ref.read(chatControllerProvider).sendGif(
            context: context,
            gif: gif.url,
            recieverUserId: widget.recieverUserId,
            isGroupChat: widget.isGroupChat,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    bool showMessageReply = messageReply != null;
    return Column(
      children: [
        if (showMessageReply) const MessageReplyPreview(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      showSendIcon = true;
                    });
                  } else {
                    setState(() {
                      showSendIcon = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: SizedBox(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: selectGif,
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: selectImageFile,
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: selectVideoFile,
                          icon: const Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(5),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            FloatingActionButton(
              backgroundColor: tabColor,
              onPressed: sendTextMessage,
              shape: const CircleBorder(),
              child: Icon(_messageController.text.isNotEmpty
                  ? Icons.send
                  : isRecording
                      ? Icons.mic_off
                      : Icons.mic),
            )
          ],
        ),
      ],
    );
  }
}
