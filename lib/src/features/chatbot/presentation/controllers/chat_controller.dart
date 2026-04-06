import 'package:get/get.dart';
import 'package:paperbrain/src/domain/repositories/app_repositories.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatController extends GetxController {
  final AppRepository _repo;

  ChatController(this._repo);

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isTyping = false.obs;
  final RxBool isPDFLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    isPDFLoaded.value = _repo.hasPDFContext;
  }

  Future<void> loadPDF(String pdfText) async {
    try {
      isLoading.value = true;
      await _repo.initializeChatWithPDF(pdfText);
      isPDFLoaded.value = true;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to initialize AI with PDF text.');
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    try {
      // Add user message
      messages.add(ChatMessage(
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));

      isTyping.value = true;

      final response = await _repo.sendMessage(message);

      messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));

      isTyping.value = false;
    } catch (e) {
      isTyping.value = false;
      messages.add(ChatMessage(
        text: 'Sorry, I encountered an error: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }
  }

  void clearChat() {
    messages.clear();
    _repo.clearChat();
  }
}
