import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:paperbrain/src/features/pdf_viewer/domain/pdf_repository.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfRepositoryImpl implements PdfRepository {
  @override
  Future<Uint8List?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      return result.files.single.bytes;
    }
    return null;
  }

  @override
  Future<Uint8List?> loadAssetPdf(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> extractText(Uint8List pdfBytes) async {
    try {
      final PdfDocument document = PdfDocument(inputBytes: pdfBytes);
      final PdfTextExtractor extractor = PdfTextExtractor(document);
      final String text = extractor.extractText();
      document.dispose();
      return text;
    } catch (e) {
      throw Exception('Failed to extract text from PDF: $e');
    }
  }
}
