import 'dart:typed_data';

abstract class AppRepository {
  Future<void> initializeChatWithPDF(String pdfContent);
  Future<String> sendMessage(String message);
  void clearChat();
  bool get hasPDFContext;
  Future<String> extractTextFromPdf(Uint8List pdfBytes);
}
