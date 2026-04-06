import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperbrain/src/features/chatbot/presentation/controllers/chat_controller.dart';
import 'package:paperbrain/src/features/chatbot/presentation/widgets/chatbot_widgets.dart';
import 'package:paperbrain/src/features/pdf_viewer/presentation/controllers/pdf_controller.dart';

class ChatBottomSheet extends StatefulWidget {
  const ChatBottomSheet({super.key});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatController chatController = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    final pdfController = Get.find<PDFController>();
    if (pdfController.extractedText.value != null && !chatController.isPDFLoaded.value) {
      chatController.loadPDF(pdfController.extractedText.value!);
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    chatController.sendMessage(text);
    _textController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withAlpha(204),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: Colors.white.withAlpha(25),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                children: [
                  const ChatHeader(),
                  Expanded(
                    child: Obx(() {
                      if (chatController.isLoading.value) {
                        return const ChatLoadingView();
                      }

                      if (chatController.messages.isEmpty && !chatController.isTyping.value) {
                        return const EmptyChatView();
                      }

                      return ChatMessagesList(
                        messages: chatController.messages,
                        scrollController: _scrollController,
                        isTyping: chatController.isTyping.value,
                      );
                    }),
                  ),
                  ChatInputBox(
                    controller: _textController,
                    onSend: _sendMessage,
                    isEnabled: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
