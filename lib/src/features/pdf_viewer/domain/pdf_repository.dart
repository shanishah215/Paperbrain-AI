import 'dart:typed_data';

abstract class PdfRepository {
  Future<Uint8List?> pickPdf();
  Future<Uint8List?> loadAssetPdf(String assetPath);
  Future<String> extractText(Uint8List pdfBytes);
}
