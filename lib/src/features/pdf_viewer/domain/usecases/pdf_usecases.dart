import 'dart:typed_data';
import 'package:paperbrain/src/features/pdf_viewer/domain/pdf_repository.dart';

class PickPdfUseCase {
  final PdfRepository _repository;

  PickPdfUseCase(this._repository);

  Future<Uint8List?> execute() async {
    return await _repository.pickPdf();
  }
}

class ExtractTextUseCase {
  final PdfRepository _repository;

  ExtractTextUseCase(this._repository);

  Future<String> execute(Uint8List pdfBytes) async {
    return await _repository.extractText(pdfBytes);
  }
}
