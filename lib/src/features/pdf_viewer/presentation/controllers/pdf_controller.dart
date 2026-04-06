import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:paperbrain/src/features/pdf_viewer/domain/usecases/pdf_usecases.dart';

enum PDFStatus { initial, loading, loaded, error }

class PDFController extends GetxController {
  final PickPdfUseCase _pickPdfUseCase;
  final ExtractTextUseCase _extractTextUseCase;

  PDFController(this._pickPdfUseCase, this._extractTextUseCase);

  final Rx<PDFStatus> status = PDFStatus.initial.obs;
  final Rx<String?> pdfPath = Rx<String?>(null);
  final Rx<Uint8List?> pdfBytes = Rx<Uint8List?>(null);
  final Rx<String> errorMessage = ''.obs;
  final Rx<String?> extractedText = Rx<String?>(null);

  Future<void> pickPDF() async {
    try {
      status.value = PDFStatus.loading;
      final bytes = await _pickPdfUseCase.execute();

      if (bytes != null) {
        pdfBytes.value = bytes;
        pdfPath.value = "uploaded.pdf"; // Default name or we can extract from picker if we update usecase
        
        // Extract text for AI
        extractedText.value = await _extractTextUseCase.execute(bytes);
        
        status.value = PDFStatus.loaded;
      } else {
        status.value = PDFStatus.initial;
      }
    } catch (e) {
      errorMessage.value = 'Failed to pick PDF: ${e.toString()}';
      status.value = PDFStatus.error;
    }
  }

  void clearPDF() {
    pdfPath.value = null;
    pdfBytes.value = null;
    extractedText.value = null;
    status.value = PDFStatus.initial;
  }
}
