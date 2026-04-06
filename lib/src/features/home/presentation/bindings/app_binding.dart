import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paperbrain/src/features/pdf_viewer/domain/pdf_repository.dart';
import 'package:paperbrain/src/features/pdf_viewer/data/repositories/pdf_repository_impl.dart';
import 'package:paperbrain/src/features/pdf_viewer/domain/usecases/pdf_usecases.dart';
import 'package:paperbrain/src/features/pdf_viewer/presentation/controllers/pdf_controller.dart';
import 'package:paperbrain/src/features/chatbot/presentation/controllers/chat_controller.dart';
import 'package:paperbrain/src/domain/repositories/app_repositories.dart';
import 'package:paperbrain/src/data/repositories/app_repositories_impl.dart';
import 'package:paperbrain/src/domain/services/gemini_chat_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    final apiKey = const String.fromEnvironment(
      'API_KEY',
      defaultValue: '',
    ).isNotEmpty 
        ? const String.fromEnvironment('API_KEY') 
        : (dotenv.env['API_KEY'] ?? '');
    
    Get.lazyPut(() => GeminiService(apiKey));

    // Data Sources & Repositories
    Get.lazyPut<PdfRepository>(() => PdfRepositoryImpl());
    Get.lazyPut<AppRepository>(() => AppRepositoryImpl(Get.find<GeminiService>()));

    // Use cases
    Get.lazyPut(() => PickPdfUseCase(Get.find<PdfRepository>()));
    Get.lazyPut(() => ExtractTextUseCase(Get.find<PdfRepository>()));

    // Controllers
    Get.put(PDFController(
      Get.find<PickPdfUseCase>(),
      Get.find<ExtractTextUseCase>(),
    ));

    // For chatbot
    Get.lazyPut(() => ChatController(Get.find<AppRepository>()));
  }
}
